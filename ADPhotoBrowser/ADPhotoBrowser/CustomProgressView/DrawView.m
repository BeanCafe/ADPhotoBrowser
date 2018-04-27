//
//  DrawView.m
//  旋转进度条
//
//  Created by zy-gyl on 16/5/24.
//  Copyright © 2016年 www.zyii.cn. All rights reserved.
//

#import "DrawView.h"

#define KlineWith 8
#define KRadius self.frame.size.width/2-2

@implementation DrawView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = frame.size.width/2-1;
        self.layer.masksToBounds = YES;
        [self rotationAnimation];
    }
    return self;
}
- (void)rotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = 0;
    rotationAnimation.toValue = @(M_PI*2);
    rotationAnimation.repeatCount = HUGE_VALF;
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    rotationAnimation.duration = 1;
    [self.layer addAnimation:rotationAnimation forKey:nil];
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self createBezierPathArc:context];
}

- (void) createBezierPathArc :(CGContextRef) context {
    CGPoint center = (CGPoint){self.frame.size.width/2,self.frame.size.width/2};
    CGFloat radius = KRadius;
    CGFloat startAngle = -M_PI/3;
    CGFloat endAngle = startAngle + 2*M_PI/3;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    UIColor *color = [UIColor whiteColor];
    [color set];
    path.lineWidth = KlineWith;
    path.lineCapStyle = kCGLineCapRound;
    [path stroke];
}
@end
