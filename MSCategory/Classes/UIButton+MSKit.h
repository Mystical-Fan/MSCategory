//
//  UIButton+MSKit.h
//  MSCategory
//
//  Created by Fan on 2019/6/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MSKit_ButtonLayoutStyle){
    ButtonLayoutStyleLeftImageRightTitle, // 左图 右文
    ButtonLayoutStyleLeftTitleRightImage, // 左文 右图
    ButtonLayoutStyleTopImageBottomTitle, // 上图 下文
    ButtonLayoutStyleTopTitleBottomImage  // 上文 下图
};

@interface UIButton (MSKit)

// 按钮样式
@property (nonatomic, assign) MSKit_ButtonLayoutStyle buttonLayoutStyle;
// 文字和图片间隔 默认8
@property (nonatomic, assign) NSInteger midSpacing;

@end

NS_ASSUME_NONNULL_END
