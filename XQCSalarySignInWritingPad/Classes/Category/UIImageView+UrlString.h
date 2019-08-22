//
//  UIImageView+UrlString.h
//  XQCSalarySignInWritingPad
//
//  Created by anmin on 2019/8/19.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (UrlString)

- (void)xqc_setImageUrlString:(NSString *)urlString;
- (void)xqc_setImageUrlString:(NSString *)urlString placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDExternalCompletionBlock)completed; 

@end

NS_ASSUME_NONNULL_END
