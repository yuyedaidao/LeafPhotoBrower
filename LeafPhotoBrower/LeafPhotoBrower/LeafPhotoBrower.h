//
//  LeafPhotoBrower.h
//  LeafPhotoBrower
//
//  Created by Wang on 14-5-15.
//  Copyright (c) 2014年 Wang. All rights reserved.
//
/*
 * 图片加载借助了SDWebImage 单独使用可通过cocoapods加载此库
 *
 *-> SDWebImage (3.6)
     Asynchronous image downloader with cache support with an UIImageView
     category.
     pod 'SDWebImage', '~> 3.6'
     - Homepage: https://github.com/rs/SDWebImage
     - Source:   https://github.com/rs/SDWebImage.git
     - Versions: 3.6, 3.5.4, 3.5.2, 3.5.1, 3.5, 3.4, 3.3, 3.2, 3.1, 3.0, 2.7.4,
     2.7, 2.6, 2.5, 2.4 [master repo]
     - Sub specs:
     - SDWebImage/Core (3.6)
     - SDWebImage/MapKit (3.6)
     - SDWebImage/WebP (3.6)

 *
 */
#import <UIKit/UIKit.h>

typedef enum {
    LeafPhotoBrowerFromImageView,
    LeafPhotoBrowerFromThumbnail
}LeafPhotoBrowerType;

@interface LeafPhotoBrower : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) LeafPhotoBrowerType type;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSArray *originalImageUrls;
@property (nonatomic,strong) NSArray *imageViews;
@property (nonatomic,strong) UILabel *pageLabel;
@property (nonatomic,assign) NSInteger currentIndex;

-(void)scrollToCurrentPage;
/**
 *  适用于像新浪微博一样，通过多个imageView显示出了缩略图的情况，如果只展示缩略图，原始图的参数为空就可以
 *
 *  @param imgViews UIImageView的数组
 *  @param urls     NSString的数组
 *
 *  @return LeafPhotoBrower
 */
+(void)showWithImageViews:(NSArray *)imgViews originalImageUrls:(NSArray *)urls currentIndex:(NSInteger)index;
/**
 *  如果图片没有展示过，可用这个方法直接展示图片
 *
 *  @param thumUrls NSString的数组
 *  @param urls     NSString的数组
 *
 *  @return LeafPhotoBrower
 *
+(void)showWithThumbnailImageUrls:(NSArray *)thumUrls originalImageUrls:(NSArray *)urls;
 */
@end
