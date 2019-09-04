//
//  UIButton+TapRange.m
//  MSCategory
//
//  Created by Fan on 2019/9/4.
//  扩大点击范围

#import "UIButton+TapRange.h"

@implementation UIButton (TapRange)

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect bounds = self.bounds;
    //若原热区小于50x50，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(50.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(50.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
