//
//  ViewController.h
//  LeafPhotoBrower
//
//  Created by Wang on 14-5-15.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)loadFromNet:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *one;
@property (weak, nonatomic) IBOutlet UIImageView *two;
@property (weak, nonatomic) IBOutlet UIImageView *three;

- (IBAction)clicked:(id)sender;

@end
