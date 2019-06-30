//
//  UITextField+Empty.m
//  com.westar.pdzw
//
//  Created by Fan on 2018/1/25.
//  Copyright © 2018年 Fan. All rights reserved.
//

#import "UITextField+Empty.h"

@implementation UITextField (Empty)

- (BOOL)isEmpty{
    if ([self.text isEqualToString:@""] || self.text == nil) {
        return YES;
    }
    return NO;
}

@end
