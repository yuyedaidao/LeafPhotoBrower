//
//  LeafPhotoBrowerCell.m
//  LeafPhotoBrower
//
//  Created by Wang on 14-5-16.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "LeafPhotoBrowerCell.h"
#import <UIImageView+WebCache.h>
@implementation LeafPhotoBrowerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)awakeFromNib{
    self.indicatorView.hidden = YES;
//    [self.oneTap requireGestureRecognizerToFail:self.doubleTap];
}
-(void)downLoadImage:(NSString *)imgUrl withCompleteBlock:(DownLoadCompleteBlock)block{
    [self downLoadImage:imgUrl progress:NO withCompleteBlock:block];
}
-(void)downLoadImage:(NSString *)imgUrl  progress:(BOOL)progress withCompleteBlock:(DownLoadCompleteBlock)block{
   
    [self.photoImgView cancelCurrentImageLoad];
    
    if(progress){
        self.indicatorView.hidden = NO;
        [self.indicatorView startAnimating];
    }else{
        self.indicatorView.hidden = YES;
    }
    
    [self.photoImgView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {

        if(progress){
            [self.indicatorView stopAnimating];
            self.indicatorView.hidden = YES;
        }
        if(block){
            block(self);
        }
    }];
    
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
    float scale = self.scrollView.zoomScale;
    if(scale>1){
        CGRect zoomRect = [self zoomRectForScale:1 withCenter:[gesture locationInView:gesture.view]];
        [self.scrollView zoomToRect:zoomRect animated:YES];
    }else{
        
        CGRect zoomRect = [self zoomRectForScale:scale*1.5 withCenter:[gesture locationInView:gesture.view]];
        [self.scrollView zoomToRect:zoomRect animated:YES];
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.scrollView.frame.size.height / scale;
    NSLog(@"zoomRect.size.height is %f",zoomRect.size.height);
    NSLog(@"self.frame.size.height is %f",self.scrollView.frame.size.height);
    zoomRect.size.width  = self.scrollView.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.photoImgView;
}
//当滑动结束时
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
//{
//    //把当前的缩放比例设进ZoomScale，以便下次缩放时实在现有的比例的基础上
//    NSLog(@"scale is %f",scale);
//    [self.scrollView setZoomScale:scale animated:NO];
//}
@end
