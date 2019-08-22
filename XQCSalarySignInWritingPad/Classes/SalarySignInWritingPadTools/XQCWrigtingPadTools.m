//
//  XQCWrigtingPadTools.m
//  XQCSalarySignInWritingPad
//
//  Created by anmin on 2019/8/19.
//

#import "XQCWrigtingPadTools.h"

@implementation XQCWrigtingPadTools

+ (XQCSalarySignedSheetView *)showCustomWrigtingPad:(nullable NSDictionary *)paramters userSureSigned:(XQCSalarySignedBlock)signedBlock
{
    NSDictionary *realParamters = (paramters ? paramters : @{});
    XQCSalarySignedSheetView *sheetView = [[XQCSalarySignedSheetView alloc] initWithSigneds:realParamters userSureSigned:signedBlock];
    [sheetView show];
    return sheetView;
}

@end
