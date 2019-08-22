//
//  UIButton+Clicked.m
//  XQCSalarySignInWritingPad
//
//  Created by anmin on 2019/8/19.
//

#import "UIButton+Clicked.h"
#import "ReactiveObjC.h"

@implementation UIButton (Clicked)

+ (instancetype)xqc_buttonWithAction:(void(^)(UIButton *button))action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [[[[button rac_signalForControlEvents:UIControlEventTouchUpInside] deliverOn:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (action) {
            action((UIButton *)x);
        }
    }];
    return button;
}

@end
