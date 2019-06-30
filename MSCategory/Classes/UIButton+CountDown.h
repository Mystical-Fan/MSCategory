//
//  UIButton+CountDown.h
//  MSCategory
//
//  Created by Fan on 2019/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CountDownTimeBlock)(NSInteger currentTime);
//typedef void(^CountDownCancelBlock)(void);

@interface UIButton (CountDown)


/**
 取消倒计时返回
 */
@property (nonatomic, copy) void(^CountDownCancelBlock)(void);

/**
 开始倒计时

 @param duration 倒计时总时间 以秒为单位
 @param currentTime 倒计时的当前时间
 */
- (void)startCountDownWithInterval:(NSTimeInterval)duration block:(CountDownTimeBlock)currentTime;

/**
 取消倒计时
 */
- (void)cancelCountDown;

@end

NS_ASSUME_NONNULL_END
