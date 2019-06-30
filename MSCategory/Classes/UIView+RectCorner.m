//
//  UIView+RectCorner.m
//  MSCategory
//
//  Created by Fan on 2019/5/22.
//

#import "UIView+RectCorner.h"
#import <objc/runtime.h>

@implementation UIView (RectCorner)

- (void)setViewRectCornerType:(ViewRectCornerType)type viewCornerRadius:(CGFloat)viewCornerRadius{
    self.viewCornerRadius = viewCornerRadius;
    self.viewRectCornerType = type;
}

- (void)setupViewCornerType{
    UIRectCorner corners;
    CGSize cornerRadii;
    cornerRadii = CGSizeMake(self.viewCornerRadius, self.viewCornerRadius);
    if (self.viewCornerRadius == 0){
        cornerRadii = CGSizeMake(0, 0);
    }
    
    switch (self.viewRectCornerType){
            case ViewRectCornerTypeBottomLeft:
        {
            corners = UIRectCornerBottomLeft;
        }
            break;
            case ViewRectCornerTypeBottomRight:
        {
            corners = UIRectCornerBottomRight;
        }
            break;
            case ViewRectCornerTypeTopLeft:
        {
            corners = UIRectCornerTopLeft;
        }
            break;
            case ViewRectCornerTypeTopRight:
        {
            corners = UIRectCornerTopRight;
        }
            break;
            case ViewRectCornerTypeBottomLeftAndBottomRight:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
            break;
            case ViewRectCornerTypeTopLeftAndTopRight:
        {
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        }
            break;
            case ViewRectCornerTypeBottomLeftAndTopLeft:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
        }
            break;
            case ViewRectCornerTypeBottomRightAndTopRight:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight;
        }
            break;
            case ViewRectCornerTypeBottomRightAndTopRightAndTopLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft;
        }
            break;
            case ViewRectCornerTypeBottomRightAndTopRightAndBottomLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft;
        }
            break;
            case ViewRectCornerTypeAllCorners:
        {
            corners = UIRectCornerAllCorners;
        }
            break;
        default:
            break;
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:corners
                                                           cornerRadii:cornerRadii];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.frame = self.bounds;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = bezierPath.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.frame = self.bounds;
    self.layer.mask = shapeLayer;
    [self.layer insertSublayer:borderLayer atIndex:0];
}

- (void)setViewBorderWithColor:(UIColor *)borderColor width:(CGFloat)borderWidth radius:(CGFloat)cornerRadius{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    borderLayer.lineWidth = borderWidth;
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) cornerRadius:cornerRadius];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    self.layer.mask = maskLayer;
    [self.layer insertSublayer:borderLayer atIndex:0];
}

#pragma mark - setter / getter
- (void)setViewRectCornerType:(ViewRectCornerType)viewRectCornerType{
    objc_setAssociatedObject(self, @selector(viewRectCornerType), @(viewRectCornerType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setupViewCornerType];
}

- (ViewRectCornerType)viewRectCornerType{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setViewCornerRadius:(CGFloat)viewCornerRadius{
    objc_setAssociatedObject(self, @selector(viewCornerRadius), @(viewCornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)viewCornerRadius{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end
