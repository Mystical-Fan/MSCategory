//
//  UIImage+BundleImage.h
//  MSCategory
//
//  Created by Fan on 2019/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BundleImage)

+ (UIImage *)getImageFromBundle:(NSObject *)bundleClass bundleName:(NSString *)bundleName imageName:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
