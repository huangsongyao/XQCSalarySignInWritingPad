//
//  UIImage+Convert.m
//  XQCSalarySignInWritingPad
//
//  Created by anmin on 2019/8/19.
//

#import "UIImage+Convert.h"
#import "UIView+GradientColor.h"

@implementation UIImage (Convert) 

+ (UIImage *)xqc_viewDrawingImage:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
}

+ (UIImage *)xqc_imageWithColor:(UIColor *)color
{
    return [self xqc_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)xqc_imageWithBundle:(NSString *)name
{
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"XQCWrigtingPadTools")];
    NSURL *bundleURL = [bundle URLForResource:bundle.infoDictionary[@"CFBundleName"] withExtension:@"bundle"];
    if (!bundleURL) {
        bundleURL = [bundle URLForResource:@"XQCSalarySignInWritingPad" withExtension:@"bundle"];
    }
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    UIImage *image = [UIImage imageNamed:name inBundle:resourceBundle compatibleWithTraitCollection:nil];
    return image;
}

+ (UIImage *)xqc_imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (!color || size.width <= 0 || size.height <= 0) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)xqc_imageWithMixColors:(NSArray *)colors size:(CGSize)size
{
    CAGradientLayer *layer = [UIView gradientLocationLayer:colors frame:CGRectMake(0.0f, 0.0f, size.width, size.height) direction:XQCGradientColorDirectionBisection];
    
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return outputImage;
}


@end
