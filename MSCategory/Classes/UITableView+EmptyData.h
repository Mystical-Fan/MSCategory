//
//  UITableView+EmptyData.h
//  TrueBenefitPoint
//
//  Created by lxd on 17/3/3.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)


//添加一个方法
- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

- (void) tableViewDisplayWitImgName:(NSString *)imageName ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
