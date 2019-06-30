//
//  UINavigationItem+CustomItem.h
//  com.westar.pdzw
//
//  Created by Fan on 2017/12/27.
//  Copyright © 2017年 Fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, BarButtonLocation)
{
    BarButtonLocationLeft,
    BarButtonLocationRight
    
};

@interface UINavigationItem (CustomItem)

// 自定义barbutton
- (void)customBarButtonsWithImage:(NSString *)imgName location:(BarButtonLocation)location;
- (void)customBarButtonsWithTitle:(NSString *)title location:(BarButtonLocation)location;


- (void)leftBarButtonTapped:(UIBarButtonItem *)sender;
- (void)rightBarButtonTapped:(UIBarButtonItem *)sender;

@end
