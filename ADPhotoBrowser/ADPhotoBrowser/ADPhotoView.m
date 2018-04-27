//
//  ADPhotoView.m
//  ADPhotoBrowser
//
//  Created by Zeaple on 16/5/26.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import "ADPhotoView.h"

#import "CustomProgress.h"

extern NSString *kADImageViewDownloadImageFinished;

@interface ADPhotoView ()<UIScrollViewDelegate>
@end

@implementation ADPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.photoContainerView = [[UIScrollView alloc]initWithFrame:frame];
        self.photoContainerView.delegate = self;
        self.photoContainerView.showsHorizontalScrollIndicator = NO;
        self.photoContainerView.showsVerticalScrollIndicator = NO;
        self.photoContainerView.minimumZoomScale = 1.0;
        self.photoContainerView.maximumZoomScale = 1.5;
        [self addSubview:self.photoContainerView];
        
        self.adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.adImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.photoContainerView addSubview:self.adImageView];
    }
    return self;
}

- (void)addWaitViewForImageView {
    UIView *a = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.adImageView.frame.size.width, self.adImageView.frame.size.height)];
    a.tag = 100+1;
    a.backgroundColor = [UIColor blackColor];
    a.alpha = 0.5;
    [self.adImageView addSubview:a];
    
    [CustomProgress showInView:self.adImageView];
}

- (void)removeWaitViewFromImageView {
    for (UIView *a in self.adImageView.subviews) {
        if (a.tag == 100+1) {
            [a removeFromSuperview];
            break;
        }
    }
    
    [CustomProgress dismissInView:self.adImageView];
}

#pragma mark - ScrollViewDelegates

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = (scrollView.frame.size.width>scrollView.contentSize.width)?(scrollView.frame.size.width-scrollView.contentSize.width)*0.5:0;
    CGFloat offsetY = (scrollView.frame.size.height>scrollView.contentSize.height)?(scrollView.frame.size.height-scrollView.contentSize.height)*0.5:0;
    self.adImageView.center = CGPointMake(scrollView.contentSize.width*0.5+offsetX, scrollView.contentSize.height*0.5+offsetY);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.adImageView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
