//
//  ADTransitionDelegate.m
//  ADPhotoBrowser
//
//  Created by Zeaple on 16/5/27.
//  Copyright © 2016年 Zeaple. All rights reserved.
//

#import "ADTransitionDelegate.h"

#import "ViewController.h"
#import "DemoPhotoCollectionCell.h"
@implementation ADTransitionDelegate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVc.view];
    
    ViewController *fromVc = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DemoPhotoCollectionCell *selcectedCell = (DemoPhotoCollectionCell *)[fromVc.collectionView cellForItemAtIndexPath:fromVc.selectedIndexPath];
    
    UIImageView *animateImageView = [[UIImageView alloc]init];
    animateImageView.image = selcectedCell.photo.image;
    animateImageView.contentMode = UIViewContentModeScaleAspectFill;
    animateImageView.clipsToBounds = YES;
    
    CGRect originFrame = [fromVc.collectionView convertRect:selcectedCell.frame toView:[UIApplication sharedApplication].keyWindow];
    animateImageView.frame = originFrame;
    [containerView addSubview:animateImageView];
    
    
    CGFloat animateImageViewWidth = fromVc.view.frame.size.width;
    CGFloat scale = animateImageView.image.size.width/animateImageView.image.size.height;
    CGFloat animateImageViewHeight = animateImageViewWidth/scale;
    CGFloat y = (fromVc.view.frame.size.height - animateImageViewHeight)/2;
    CGRect endFrame = CGRectMake(0, y, fromVc.view.frame.size.width, animateImageViewHeight);
    toVc.view.alpha = 0;
    
//    [UIView animateWithDuration:0.3 animations:^{
//        animateImageView.frame = endFrame;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//        [UIView animateWithDuration:0.3 animations:^{
//            toVc.view.alpha = 1.0;
//
//        } completion:^(BOOL finished) {
//
//            [animateImageView removeFromSuperview];
//        }];
//    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        animateImageView.frame = endFrame;
        toVc.view.alpha = 1.0;

    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.3 animations:^{
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];

            [animateImageView removeFromSuperview];
        }];
    }];

    
}
@end
