//
//  ADPhotoBrowserController.h
//  ADPhotoBrowser
//
//  Created by Zeaple on 16/5/26.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADPhotoBrowserController : UIViewController

@property(nonatomic, assign)NSInteger currentIndex;

@property(strong, nonatomic)NSArray *highQualityPhotoUrls;
@property(strong, nonatomic)NSArray *lowQualityPhotoUrls;
@end
