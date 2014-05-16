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

@end
