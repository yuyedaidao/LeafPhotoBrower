//
//  LeafPhotoBrower.m
//  LeafPhotoBrower
//
//  Created by Wang on 14-5-15.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "LeafPhotoBrower.h"

static LeafPhotoBrower* _brower = nil;

@implementation LeafPhotoBrower

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(void)showWithImageViews:(NSArray *)imgViews originalImageUrls:(NSArray *)urls{
    if(_brower==nil){
        _brower = [[LeafPhotoBrower alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _brower.type = LeafPhotoBrowerFromImageView;
        _brower.imageViews = imgViews;
        _brower.originalImageUrls = urls;
    }
}
+(void)showWithThumbnailImageUrls:(NSArray *)thumUrls originalImageUrls:(NSArray *)urls{
    
}

@end
