//
//  UIImage+BundleImage.m
//  MSCategory
//
//  Created by Fan on 2019/5/30.
//

#import "UIImage+BundleImage.h"

@implementation UIImage (BundleImage)

+ (UIImage *)getImageFromBundle:(NSObject *)bundleClass bundleName:(NSString *)bundleName imageName:(NSString *)imageName{
    if (![bundleName hasSuffix:@".bundle"]) {
        bundleName = [NSString stringWithFormat:@"%@.bundle",bundleName];
    }
    NSBundle *currentBundle = [NSBundle bundleForClass:bundleClass.class]; // 获取当前bundle
    NSString *imagePath = [currentBundle pathForResource:imageName ofType:nil inDirectory:bundleName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
