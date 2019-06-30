//
//  UIView+Shadow.h
//  MSCategory
//
//  Created by Fan on 2019/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Shadow)

- (void)addShadowWithShadowColor:(UIColor *)shadowColor
                         Opacity:(float)shadowOpacity
                    shadowRadius:(CGFloat)shadowRadius
                          offset:(CGSize)shadowOffset;

- (void)addButtonShadowWithShadowColor:(UIColor *)shadowColor
                               Opacity:(float)shadowOpacity
                          shadowRadius:(CGFloat)shadowRadius
                                offset:(CGSize)shadowOffset
                          cornerRadius:(CGFloat)cornerRadius;


@end

NS_ASSUME_NONNULL_END
