//
//  UIButton+CountDown.m
//  MSCategory
//
//  Created by Fan on 2019/5/22.
//

#import "UIButton+CountDown.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation UIButton (CountDown)

- (void)setTimer:(dispatch_source_t)timer{
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (dispatch_source_t)timer{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCountDownCancelBlock:(void (^)(void))CountDownCancelBlock{
    objc_setAssociatedObject(self, @selector(CountDownCancelBlock), CountDownCancelBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))CountDownCancelBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)startCountDownWithInterval:(NSTimeInterval)duration block:(CountDownTimeBlock)currentTime{
    __block NSInteger timeOut = duration; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    __weak __typeof (self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        __typeof (self) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (currentTime){
                currentTime(timeOut);
            }
            if (timeOut <= 0){
                // 倒计时结束，关闭
                [strongSelf cancelCountDown];
            }else{
                timeOut--;
            }
        });
        
    });
    dispatch_resume(self.timer);
}

- (void)cancelCountDown{
    if (!self.timer) {
        return;
    }else{
        __weak __typeof (self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof (self) strongSelf = weakSelf;
            dispatch_source_cancel(self.timer);
            strongSelf.timer = nil;
            strongSelf.userInteractionEnabled = YES;
            if (strongSelf.CountDownCancelBlock){
                strongSelf.CountDownCancelBlock();
            }
        });
    }
}

@end
