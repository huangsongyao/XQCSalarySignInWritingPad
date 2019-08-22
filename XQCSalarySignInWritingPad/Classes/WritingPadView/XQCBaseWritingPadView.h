//
//  XQCBaseWritingPadView.h
//  XQC
//
//  Created by anmin on 2019/6/19.
//  Copyright © 2019 xqc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XQCBaseWritingPadView : UIView

@property (nonatomic, assign, setter=setWitingPadBenWidth:) CGFloat witingBenWidth;
- (instancetype)initWithObserver:(void(^)(BOOL isClear))observer;

//将绘制后的视图绘制成图片
- (UIImage *)plotSignedInImage;
//将绘制后的视图绘制成图片，并将图片转为base64位字符串
- (NSString *)signedInImageBase64Encoded;
//重新绘制
- (void)replotPath;

@end 

NS_ASSUME_NONNULL_END
