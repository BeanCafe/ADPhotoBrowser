//
//  ADPhotoView.h
//  ADPhotoBrowser
//
//  Created by Zeaple on 16/5/26.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+AFNetworking.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

@interface ADPhotoView : UIView
@property(strong, nonatomic)UIScrollView *photoContainerView;
@property(strong, nonatomic)UIImageView *adImageView;


- (void)addWaitViewForImageView;
- (void)removeWaitViewFromImageView;
@end
