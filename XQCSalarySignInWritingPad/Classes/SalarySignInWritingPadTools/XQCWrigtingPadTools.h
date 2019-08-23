//
//  XQCWrigtingPadTools.h
//  XQCSalarySignInWritingPad
//
//  Created by anmin on 2019/8/19.
//

#import <Foundation/Foundation.h>
#import "XQCSalarySignedSheetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XQCWrigtingPadTools : NSObject

/**
 签收手写板---快速方法

 @param paramters 入参，如果未签名，则返回 -> @{} 表示空键值对，模式为签名模式；如果已签名，则返回 -> @{@"签名时间" : @"签名图片的完整远端地址"} 模式为已签名模式
 @param signedBlock 签名接口，返回一个RACSignal<NSNumber>，来告知方法内部未来发生的结果，这个signal发送的信号类型为NSNumber的BOOL值类型，YES表示接口成功，NO表示接口失败【接口成功后会执行remove，失败则不改变状态】
 @return XQCSalarySignedSheetView
 */
+ (XQCSalarySignedSheetView *)showCustomWrigtingPad:(nullable NSDictionary *)paramters userSureSigned:(XQCSalarySignedBlock)signedBlock;

@end

NS_ASSUME_NONNULL_END
