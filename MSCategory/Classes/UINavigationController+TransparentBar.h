//
//  UINavigationController+TransparentBar.h
//  com.westar.pdzw
//
//  Created by Fan on 2017/12/27.
//  Copyright © 2017年 Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (TransparentBar)

// 设置导航栏背景透明度
- (void)setNeedsNavigationBackground:(CGFloat)alpha backgroundColor:(UIColor *)color;

@end
