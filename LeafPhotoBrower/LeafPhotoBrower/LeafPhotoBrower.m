//
//  LeafPhotoBrower.m
//  LeafPhotoBrower
//
//  Created by Wang on 14-5-15.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "LeafPhotoBrower.h"
#import "LeafPhotoBrowerCell.h"

#import <UIImageView+WebCache.h>
//#import <UIImageView+ProgressView.h>

static LeafPhotoBrower* _brower = nil;
static NSString *name_photocell = @"LeafPhotoBrowerCell";

@implementation LeafPhotoBrower

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor blackColor];
        [self initCollectionView];
        
//        [self initPageLabel];
    }
    return self;
}
-(void)initPageLabel{
    CGFloat w = 60.0f;
    CGFloat h = 30.0f;
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-w, self.bounds.size.height-20-h, w, h)];
    [self addSubview:self.pageLabel];
    self.pageLabel.backgroundColor = [UIColor clearColor];
    self.pageLabel.textColor = [UIColor whiteColor];
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",self.currentIndex+1,self.totalCount];
}
-(void)initCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:self.bounds.size];
    flowLayout.minimumLineSpacing = 0;//消除cell的间隔
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:name_photocell bundle:nil] forCellWithReuseIdentifier:name_photocell];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self addSubview:self.collectionView];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if(self.type == LeafPhotoBrowerFromImageView){
        return self.imageViews.count;
    }else if(self.type == LeafPhotoBrowerFromThumbnail){
        return self.imageViews.count;
    }
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.bounds.size;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LeafPhotoBrowerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:name_photocell forIndexPath:indexPath];
    if(self.type==LeafPhotoBrowerFromThumbnail){
        cell.originalImgView = nil;
        cell.photoImgView.image = self.images[indexPath.item];
        if(self.originalImageUrls){
            [cell downLoadImage:self.originalImageUrls[indexPath.item] progress:YES withCompleteBlock:nil];
        }
        
    }else if(self.type==LeafPhotoBrowerFromImageView){
        cell.photoImgView.image = nil;
        cell.originalImgView = self.imageViews[indexPath.item];
        if(self.originalImageUrls){
            [cell downLoadImage:self.originalImageUrls[indexPath.item] progress:YES withCompleteBlock:nil];
        }
    }

    cell.indexPath = indexPath;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = (scrollView.contentOffset.x+scrollView.bounds.size.width/2)/scrollView.bounds.size.width;
    if(page<self.totalCount && page!=self.currentIndex){
        self.currentIndex = page;
        self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",page+1,self.totalCount];
    }
}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
-(void)scrollToCurrentPage{
    [self.collectionView scrollRectToVisible:CGRectMake(self.currentIndex*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height) animated:NO];
}
+(void)showWithImageViews:(NSArray *)imgViews originalImageUrls:(NSArray *)urls currentIndex:(NSInteger)index{
    if(_brower==nil){
        _brower = [[LeafPhotoBrower alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _brower.type = LeafPhotoBrowerFromImageView;
        _brower.imageViews = imgViews;
        _brower.originalImageUrls = urls;
        _brower.currentIndex = index;
        _brower.totalCount = MAX(imgViews.count, urls.count);
        [_brower initPageLabel];
        _brower.collectionView.hidden = YES;
        
        UIView *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_brower];
        
        //动画
        UIImageView *temp = imgViews[index];
        UIImageView *currentImgView = [[UIImageView alloc] initWithImage:temp.image];
        currentImgView.frame = temp.frame;
        CGRect originalRect = [temp convertRect:temp.frame toView:window];
        [_brower addSubview:currentImgView];
        currentImgView.frame = originalRect;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            currentImgView.frame = window.bounds;
        } completion:^(BOOL finished) {
            [_brower.collectionView reloadData];
            [_brower scrollToCurrentPage];
            _brower.collectionView.hidden = NO;
            [currentImgView removeFromSuperview];
        }];
        
    }
}
+(void)showWithThumbnailImages:(NSArray *)thumbImgs originalImageUrls:(NSArray *)urls currentIndex:(NSInteger)index{
    if(_brower==nil){
        _brower = [[LeafPhotoBrower alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _brower.type = LeafPhotoBrowerFromThumbnail;
        _brower.images = thumbImgs;
        _brower.originalImageUrls = urls;
        _brower.currentIndex = index;
        _brower.totalCount = MAX(thumbImgs.count, urls.count);
        [_brower initPageLabel];
        UIView *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_brower];
        [_brower.collectionView reloadData];
        [_brower scrollToCurrentPage];
    }
}

@end
