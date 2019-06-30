//
//  UIView+RectCorner.h
//  MSCategory
//
//  Created by Fan on 2019/5/22.
//  切圆角

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM (NSInteger, ViewRectCornerType) {
    /*!
     *  设置下左角 圆角半径
     */
    ViewRectCornerTypeBottomLeft = 0,
    /*!
     *  设置下右角 圆角半径
     */
    ViewRectCornerTypeBottomRight,
    /*!
     *  设置上左角 圆角半径
     */
    ViewRectCornerTypeTopLeft,
    /*!
     *  设置下右角 圆角半径
     */
    ViewRectCornerTypeTopRight,
    /*!
     *  设置下左、下右角 圆角半径
     */
    ViewRectCornerTypeBottomLeftAndBottomRight,
    /*!
     *  设置上左、上右角 圆角半径
     */
    ViewRectCornerTypeTopLeftAndTopRight,
    /*!
     *  设置下左、上左角 圆角半径
     */
    ViewRectCornerTypeBottomLeftAndTopLeft,
    /*!
     *  设置下右、上右角 圆角半径
     */
    ViewRectCornerTypeBottomRightAndTopRight,
    /*!
     *  设置上左、上右、下右角 圆角半径
     */
    ViewRectCornerTypeBottomRightAndTopRightAndTopLeft,
    /*!
     *  设置下右、上右、下左角 圆角半径
     */
    ViewRectCornerTypeBottomRightAndTopRightAndBottomLeft,
    /*!
     *  设置全部四个角 圆角半径
     */
    ViewRectCornerTypeAllCorners
};

@interface UIView (RectCorner)


/**
 * 设置 viewRectCornerType 样式，注意：ViewRectCornerType 必须要先设置 viewCornerRadius，才能有效，否则设置无效，如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效
 */
@property (nonatomic, assign) ViewRectCornerType viewRectCornerType;

/**
 设置 view ：圆角，如果要全部设置四个角的圆角，可以直接用这个方法，必须要在设置 frame 之后，注意：如果是 xib，需要要有固定 宽高，要不然 iOS 10 设置无效
 */
@property (nonatomic, assign) CGFloat viewCornerRadius;

/**
 快速切圆角
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 */
- (void)setViewRectCornerType:(ViewRectCornerType)type
             viewCornerRadius:(CGFloat)viewCornerRadius;


/**
 快速绘制带边框的圆角

 @param borderColor 边框颜色
 @param borderWidth 线条宽度
 @param cornerRadius 圆角大小
 */
- (void)setViewBorderWithColor:(UIColor *)borderColor width:(CGFloat)borderWidth radius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
