//
//  UIButton+MSKit.m
//  MSCategory
//
//  Created by Fan on 2019/6/11.
//

#import "UIButton+MSKit.h"
#import <objc/runtime.h>

@implementation UIButton (MSKit)

- (void)setButtonLayoutStyle:(MSKit_ButtonLayoutStyle)buttonLayoutStyle{
    objc_setAssociatedObject(self, @selector(buttonLayoutStyle), @(buttonLayoutStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setupButtonStyle];
}

- (MSKit_ButtonLayoutStyle)buttonLayoutStyle{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setMidSpacing:(NSInteger)midSpacing{
    objc_setAssociatedObject(self, @selector(midSpacing), @(midSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)midSpacing{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setupButtonStyle{
    CGFloat image_w = self.imageView.bounds.size.width;
    CGFloat image_h = self.imageView.bounds.size.height;
    
    CGFloat title_w = self.titleLabel.bounds.size.width;
    CGFloat title_h = self.titleLabel.bounds.size.height;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        title_w = self.titleLabel.intrinsicContentSize.width;
        title_h = self.titleLabel.intrinsicContentSize.height;
    }
    
    UIEdgeInsets imageEdge = UIEdgeInsetsZero;
    UIEdgeInsets titleEdge = UIEdgeInsetsZero;
    
    if (self.midSpacing == 0){
        self.midSpacing = 8;
    }
    switch (self.buttonLayoutStyle) {
        case ButtonLayoutStyleLeftImageRightTitle:
        {
            titleEdge = UIEdgeInsetsMake(0, self.midSpacing, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.midSpacing);
        }
            break;
        case ButtonLayoutStyleLeftTitleRightImage:
        {
            titleEdge = UIEdgeInsetsMake(0, -image_w - self.midSpacing, 0, image_w);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.midSpacing, 0, -title_w);
        }
            break;
        case ButtonLayoutStyleTopImageBottomTitle:
        {
            titleEdge = UIEdgeInsetsMake(0, -image_w, -image_h - self.midSpacing, 0);
            imageEdge = UIEdgeInsetsMake(-title_h - self.midSpacing, 0, 0, -title_w);
        }
            break;
        case ButtonLayoutStyleTopTitleBottomImage:
        {
            titleEdge = UIEdgeInsetsMake(-image_h - self.midSpacing, -image_w, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, -title_h - self.midSpacing, -title_w);
        }
            break;
        default:
            break;
    }
    self.imageEdgeInsets = imageEdge;
    self.titleEdgeInsets = titleEdge;
}


@end
