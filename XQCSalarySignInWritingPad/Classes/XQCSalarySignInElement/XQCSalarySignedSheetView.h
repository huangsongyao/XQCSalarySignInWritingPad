//
//  XQCSalarySignedSheetView.h
//  XQC
//
//  Created by anmin on 2019/6/13.
//  Copyright © 2019 xqc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

typedef RACSignal<NSNumber *> *_Nonnull(^XQCSalarySignedBlock)(NSString *userSignedString, UIImage *image); 

@interface XQCBaseSignedSheetView : UIView

@property (nonatomic, strong, readonly) UIView *signedContentView;
- (void)show;
- (void)remove;

@end

@interface XQCSalarySignedSheetView : XQCBaseSignedSheetView
//工资签收手写板
- (instancetype)initWithSigneds:(NSDictionary *)signeds
                 userSureSigned:(XQCSalarySignedBlock)sureSigned;

@end

NS_ASSUME_NONNULL_END
