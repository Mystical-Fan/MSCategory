//
//  UITableView+EmptyData.m
//  TrueBenefitPoint
//
//  Created by lxd on 17/3/3.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)
- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)tableViewDisplayWitImgName:(NSString *)imageName ifNecessaryForRowCount:(NSUInteger)rowCount{
    if (rowCount == 0) {
        UIView *backView = [[UIView alloc]init];
//        backView.backgroundColor = [UIColor whiteColor];
        backView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1.0f];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:imageName];
        [backView addSubview:imageView];
        
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        //子view的中心横坐标等于父view的中心横坐标
        NSLayoutConstraint *constrant1 = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        //子view的中心纵坐标等于父view的中心纵坐标
        NSLayoutConstraint *constrant2 = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
        //子view的宽度为60
        NSLayoutConstraint *constrant3 = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.0];
        //子view的高度为60
        NSLayoutConstraint *constrant4 = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.0];
        //把约束添加到父视图上
        NSArray *array = [NSArray arrayWithObjects:constrant1, constrant2, constrant3, constrant4, nil];
        [backView addConstraints:array];
        
        self.backgroundView = backView;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    else{
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

@end
