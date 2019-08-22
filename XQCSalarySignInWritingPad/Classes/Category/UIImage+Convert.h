//
//  UIImage+Convert.h
//  XQCSalarySignInWritingPad
//
//  Created by anmin on 2019/8/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Convert)

+ (UIImage *)xqc_viewDrawingImage:(UIView *)view;
+ (UIImage *)xqc_imageWithColor:(UIColor *)color;
+ (UIImage *)xqc_imageWithMixColors:(NSArray *)colors size:(CGSize)size;
+ (UIImage *)xqc_imageWithBundle:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
