//
//  UINavigationController+TransparentBar.m
//  com.westar.pdzw
//
//  Created by Fan on 2017/12/27.
//  Copyright © 2017年 Fan. All rights reserved.
//

#import "UINavigationController+TransparentBar.h"

@implementation UINavigationController (TransparentBar)

// 设置导航栏背景透明度
- (void)setNeedsNavigationBackground:(CGFloat)alpha backgroundColor:(UIColor *)color {
    float version = [[UIDevice currentDevice].systemVersion floatValue];
    if (version <= 10.0) {
        [[[self.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
    }
    else{
        //         导航栏背景透明度设置
        UIView *barBackgroundView = [[self.navigationBar subviews] objectAtIndex:0];// _UIBarBackground
        UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0]; // UIImageView
        if (self.navigationBar.isTranslucent) {
            if (backgroundImageView != nil && backgroundImageView.image != nil) {
                barBackgroundView.alpha = alpha;
            }
            else {
                UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
                if (backgroundEffectView != nil) {
                    backgroundEffectView.backgroundColor = color;
                    backgroundEffectView.alpha = alpha;
                }
            }
        } else {
            barBackgroundView.alpha = alpha;
        }
        
        // 对导航栏下面那条线做处理
        self.navigationBar.clipsToBounds = alpha == 0.0;
    }
}


@end
