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

+ (XQCSalarySignedSheetView *)showCustomWrigtingPad:(nullable NSDictionary *)paramters userSureSigned:(XQCSalarySignedBlock)signedBlock;

@end

NS_ASSUME_NONNULL_END
