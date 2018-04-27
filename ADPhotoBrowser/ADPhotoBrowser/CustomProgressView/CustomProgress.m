//
//  CustomProgress.m
//  进度条
//
//  Created by zy-gyl on 16/5/24.
//  Copyright © 2016年 www.zyii.cn. All rights reserved.
//

#import "CustomProgress.h"
#import "DrawView.h"

#define KlineWith 10
#define KRadius self.frame.size.width/2-1.7
#define KProgressWith 40

@interface CustomProgress ()
@end

@implementation CustomProgress
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
        [self _initSubviews];
    }
    return self;
}

- (void)_initSubviews{
    DrawView  *drawView = [[DrawView alloc]initWithFrame:self.bounds];
    [self addSubview:drawView];
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self creatBezierPathArc2:context];
}

- (void)creatBezierPathArc2:(CGContextRef)context{
    CGPoint center = (CGPoint){self.frame.size.width/2,self.frame.size.width/2};
    CGFloat radius = KRadius;
    CGFloat startAngle = 0;
    CGFloat endAngle =2*M_PI;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    UIColor *color = [UIColor blackColor];
    [color set];
    path.lineWidth = KlineWith;
    [path stroke];
}
//显示的方法
+ (void)showInView:(UIView *)view{
    CustomProgress *progress = [[CustomProgress alloc]initWithFrame:CGRectMake(0, 0, KProgressWith, KProgressWith)];
    progress.tag = 300;
    progress.center = (CGPoint){view.frame.size.width/2,view.frame.size.height/2};
    [view addSubview:progress];
    [view bringSubviewToFront:progress];
}


//隐藏的方法
+ (void)dismissInView:(UIView *)view{
    CustomProgress *progress = (CustomProgress*)[view viewWithTag:300];
    if(progress){
        [progress removeFromSuperview];
    }
}

+ (void)show{
    CustomProgress *progress = [[CustomProgress alloc]initWithFrame:CGRectMake(0, 0, KProgressWith, KProgressWith)];
    progress.tag = 301;
    UIWindow *window = (UIWindow*)[UIApplication sharedApplication].keyWindow;
    progress.center =window.center;
    [window addSubview:progress];
    [window bringSubviewToFront:progress];
}

+ (void)dismiss{
    UIWindow *window = (UIWindow*)[UIApplication sharedApplication].keyWindow;
    CustomProgress *progress = (CustomProgress*)[window viewWithTag:301];
    [progress removeFromSuperview];
}


@end
