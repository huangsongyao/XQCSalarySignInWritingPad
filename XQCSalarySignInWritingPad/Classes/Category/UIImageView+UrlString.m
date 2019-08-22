//
//  UIImageView+UrlString.m
//  XQCSalarySignInWritingPad
//
//  Created by anmin on 2019/8/19.
//

#import "UIImageView+UrlString.h"
#import "ReactiveObjC.h"
#import "UIImage+Convert.h"

@implementation UIImageView (UrlString)

- (void)xqc_setImageUrlString:(NSString *)urlString
{
    UIImage *placeholderImage = [UIImage xqc_imageWithBundle:@"home_ad_small_icon"];
    [self xqc_setImageUrlString:urlString placeholderImage:placeholderImage options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {}];
}

- (void)xqc_setImageUrlString:(NSString *)urlString placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDExternalCompletionBlock)completed
{
    @weakify(self);
    //去除首尾的空格符
    NSString *realUrlString = [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //如果url链接不是以http开头，并且url链接的长度不为0
    if (![realUrlString hasPrefix:@"http"] && realUrlString.length) {
        //尝试将这个不以http为开头的url链接当做是本地png图片的名称，来获取图片，如果获取得到，则直接设置并返回
        UIImage *thisImage = [UIImage xqc_imageWithBundle:urlString];
        if (thisImage) {
            self.image = thisImage;
            self.highlightedImage = thisImage;
            return;
        }
    }
    //如果url链接的长度为0，则手动设置一个默认的域名
    if (!realUrlString.length) {
        realUrlString = @"https://xqc";
    }
    realUrlString = [realUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:realUrlString];
    //获取这个默认的占位图，如果这个占位图为nil，则设置为默认的占位图 --> knot_real_name_icon
    UIImage *realPlaceholderImage = placeholder;
    if (!realPlaceholderImage) {
        realPlaceholderImage = [UIImage xqc_imageWithBundle:@"home_ad_small_icon"]; 
    }
    [self sd_setImageWithURL:url placeholderImage:realPlaceholderImage options:options completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        UIImage *targetImage = image;
        //如果链接加载获取不到图片，则设置图片为默认的占位图
        if (!targetImage) {
            targetImage = realPlaceholderImage;
        }
        //回归主线程通过NSRunLoopCommonModes状态设置图片
        [[RACScheduler mainThreadScheduler] schedule:^{
            @strongify(self);
            [self performSetImage:targetImage];
            if (completed) {
                completed(image, error, cacheType, imageURL);
            }
        }];
    }];
}

- (void)performSetImage:(UIImage *)image
{
    [self performSelector:@selector(setImage:) withObject:image afterDelay:0.0 inModes:@[NSDefaultRunLoopMode]];
    [self performSelector:@selector(setHighlightedImage:) withObject:image afterDelay:0.0 inModes:@[NSDefaultRunLoopMode]];
}


@end
