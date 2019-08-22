//
//  UIButton+Clicked.h
//  XQCSalarySignInWritingPad
//
//  Created by anmin on 2019/8/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Clicked)

+ (instancetype)xqc_buttonWithAction:(void(^)(UIButton *button))action;

@end

NS_ASSUME_NONNULL_END
