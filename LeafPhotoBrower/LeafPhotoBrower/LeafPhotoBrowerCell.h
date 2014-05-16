//
//  LeafPhotoBrowerCell.h
//  LeafPhotoBrower
//
//  Created by Wang on 14-5-16.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeafPhotoBrowerCell;
typedef void (^DownLoadCompleteBlock)(LeafPhotoBrowerCell *cell);
@interface LeafPhotoBrowerCell : UICollectionViewCell
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (assign,nonatomic,getter = hasLoadedOriginal) BOOL loadedOriginal;
@property (strong,nonatomic) UIImageView *originalImgView;

-(void)downLoadImage:(NSString *)imgUrl withCompleteBlock:(DownLoadCompleteBlock)block;
-(void)downLoadImage:(NSString *)imgUrl progress:(BOOL)progress withCompleteBlock:(DownLoadCompleteBlock)block;
//-(void)downLoadImage:(NSString *)imgUrl thumbnail:(BOOL)thumbnail progress:(BOOL)progress withCompleteBlock:(DownLoadCompleteBlock)block;
@end
