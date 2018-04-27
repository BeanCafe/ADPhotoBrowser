//
//  CustomProgress.h
//  进度条
//
//  Created by zy-gyl on 16/5/24.
//  Copyright © 2016年 www.zyii.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CustomProgress : UIView

/*---指定父视图---*/
//出现的方法
+ (void)showInView:(UIView *)view;
//消失的方法
+ (void)dismissInView:(UIView*)view;


/*---添加到window---*/
//出现的方法
+ (void)show;
//消失的方法
+ (void)dismiss;

@end
