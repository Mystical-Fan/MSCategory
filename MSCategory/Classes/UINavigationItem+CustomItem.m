//
//  UINavigationItem+CustomItem.m
//  com.westar.pdzw
//
//  Created by Fan on 2017/12/27.
//  Copyright © 2017年 Fan. All rights reserved.
//

#import "UINavigationItem+CustomItem.h"

@implementation UINavigationItem (CustomItem)

static NSString *LEFT_BAR_BTN= @"LeftBarBtn";
static NSString *RIGHT_BAR_BTN = @"RightBarBtn";

- (void)customBarButtonsWithImage:(NSString *)imgName location:(BarButtonLocation)location{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,25,25)];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *items = [[UIBarButtonItem alloc]initWithCustomView:button];
    if (location == BarButtonLocationLeft) {
        self.leftBarButtonItem = items;
        [button addTarget:self action:@selector(leftBarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        self.rightBarButtonItem = items;
        [button addTarget:self action:@selector(rightBarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)customBarButtonsWithTitle:(NSString *)title location:(BarButtonLocation)location{
    UIBarButtonItem *item;
    [item setTitleTextAttributes:@{NSBackgroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:10.0f]} forState:UIControlStateNormal];
    if (location == BarButtonLocationLeft) {
        item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonTapped:)];
        self.leftBarButtonItem = item;
    }
    else{
        item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonTapped:)];
        self.rightBarButtonItem = item;
        
    }
}

- (void)leftBarButtonTapped:(UIBarButtonItem *)sender{

}

- (void)rightBarButtonTapped:(UIBarButtonItem *)sender{

}

@end
