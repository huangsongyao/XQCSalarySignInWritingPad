//
//  XQCMacroHeader.h
//  XQCSalarySignInWritingPad
//
//  Created by anmin on 2019/8/19.
//

#ifndef XQCMacroHeader_h
#define XQCMacroHeader_h

#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define kPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define kPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height

#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define THEME_BLUE_FONT_COLOR                   RGB16(0x6167b9)
#define THEME_LINE_OR_BACKGROUND_COLOR          RGB16(0xf5f5f7)

#define XQC_REGULAR_FONT_11                         [UIFont systemFontOfSize:11.0f weight:UIFontWeightRegular]
#define XQC_REGULAR_FONT_13                         [UIFont systemFontOfSize:13.0f weight:UIFontWeightRegular]
#define XQC_REGULAR_FONT_16                         [UIFont systemFontOfSize:16.0f weight:UIFontWeightRegular]


#endif /* XQCMacroHeader_h */
