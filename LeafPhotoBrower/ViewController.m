//
//  ViewController.m
//  LeafPhotoBrower
//
//  Created by Wang on 14-5-15.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "LeafPhotoBrower.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.one sizeToFit];
    [self.two sizeToFit];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadFromNet:(id)sender {
    NSArray *originalUrls = @[@"http://www.kukud.net/meinv/UploadFiles_3657/201201/20120114225653217.jpg",@"http://www.kukud.net/fengjing/UploadFiles_8688/201207/20120719100642651.jpg",@"http://www.kukud.net/fengjing/UploadFiles_8688/201207/20120704220216988.jpg"];
//    NSArray *thumbinalUrls = @[@"http://img1.gamedog.cn/2012/12/29/24-1212291509330-51.jpg",@"http://img1.gamedog.cn/2013/01/10/24-130110143S00.jpg",@"http://img1.gamedog.cn/2013/01/10/24-130110143S50-50.jpg"];
    
//   LeafPhotoBrower showWithImageViews:<#(NSArray *)#> originalImageUrls:<#(NSArray *)#>
}
- (IBAction)clicked:(UIGestureRecognizer *)sender {
    [LeafPhotoBrower showWithImageViews:@[self.one,self.two,self.three] originalImageUrls:@[@"http://www.kukud.net/meinv/UploadFiles_3657/201201/20120114225653217.jpg",@"http://www.kukud.net/fengjing/UploadFiles_8688/201207/20120719100642651.jpg",@"http://www.kukud.net/fengjing/UploadFiles_8688/201207/20120704220216988.jpg"] currentIndex:sender.view.tag];
}
@end
