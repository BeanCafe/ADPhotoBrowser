//
//  ADMainCollectionCell.m
//  ADPhotoBrowser
//
//  Created by Zeaple on 16/5/26.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import "ADMainCollectionCell.h"

extern CGFloat photoGap;
#define LowQualityImageViewWidth 150

#import "ADPhotoView.h"
#import "CustomProgress.h"
#import "ADPhoto.h"

@interface ADMainCollectionCell ()
@property(strong, nonatomic)ADPhotoView *adPhotoView;
@end
@implementation ADMainCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adPhotoView = [[ADPhotoView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width-photoGap, frame.size.height)];
        [self.contentView addSubview:self.adPhotoView];
    }
    return self;
}

- (void)setPhotoData:(ADPhoto *)photoData {
    _photoData = photoData;
    
    //清空复用cell的前状态
    [self.adPhotoView.photoContainerView setZoomScale:1.0];
    [self.adPhotoView removeWaitViewFromImageView];
    [CustomProgress dismissInView:self.adPhotoView];
    
    __weak typeof(self) weakSelf = self;
    CGFloat bottomWidth = self.adPhotoView.photoContainerView.frame.size.width;
    CGFloat bottomHeight = self.adPhotoView.photoContainerView.frame.size.height;
    
    //检查本地是否有小图的缓存
    NSMutableURLRequest *lowQualityImageDownloadRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:photoData.lowQualityPhotoUrl]];
    UIImage *image = [[UIImageView sharedImageCache] cachedImageForRequest:lowQualityImageDownloadRequest];
    
    bool isCachedLowQualityImage = NO;
    CGFloat lHeight = 150;
    CGFloat lWidth = LowQualityImageViewWidth;
    CGFloat correctImageToCenter = Main_Screen_Height/20;
    if (image) {
        isCachedLowQualityImage = YES;
        lHeight = image.size.height*(lWidth/image.size.width);
        weakSelf.adPhotoView.adImageView.image = image;
        [weakSelf.adPhotoView addWaitViewForImageView];
    } else {
        isCachedLowQualityImage = NO;
        [CustomProgress showInView:self.adPhotoView];
    }
    weakSelf.adPhotoView.adImageView.frame = CGRectMake((Main_Screen_Width-lWidth)/2, (Main_Screen_Height-lHeight)/2-correctImageToCenter, lWidth, lHeight);

    //下载高清大图
    NSMutableURLRequest *highQualityImageDownloadRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:photoData.highQualityPhotoUrl]];
    [highQualityImageDownloadRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    [weakSelf.adPhotoView.adImageView setImageWithURLRequest:highQualityImageDownloadRequest placeholderImage:nil success:^(bool isCached, NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        //清空Progress
        if (!isCachedLowQualityImage) {
            [CustomProgress dismissInView:weakSelf.adPhotoView];
        }
        [weakSelf.adPhotoView removeWaitViewFromImageView];
        [weakSelf.adPhotoView.adImageView setImage:image];
        
        //        CGFloat width = image.size.width>bottomWidth?image.size.width:bottomWidth;
        CGFloat width = bottomWidth;
        CGFloat height = image.size.height*(width/image.size.width);
        
        if (isCached) {
            if (image.size.height>bottomHeight) {
                weakSelf.adPhotoView.adImageView.frame = CGRectMake(0, 0, width, height);
                weakSelf.adPhotoView.photoContainerView.contentOffset = CGPointZero;
            } else {
                weakSelf.adPhotoView.adImageView.frame = CGRectMake(0, (bottomHeight-height)/2, width, height);
            }
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                if (image.size.height>bottomHeight) {
                    weakSelf.adPhotoView.adImageView.frame = CGRectMake(0, 0, width, height);
                    weakSelf.adPhotoView.photoContainerView.contentOffset = CGPointZero;
                } else {
                    weakSelf.adPhotoView.adImageView.frame = CGRectMake(0, (bottomHeight-height)/2, width, height);
                }
            }];
        }
        weakSelf.adPhotoView.photoContainerView.maximumZoomScale = bottomHeight/height;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"FAIL!!!");
    }];
}

@end
