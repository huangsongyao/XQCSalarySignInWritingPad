//
//  UIView+GradientColor.h
//  XQC
//
//  Created by anmin on 2019/4/19.
//  Copyright © 2019 xqc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XQCGradientColorDirection) {
    
    XQCGradientColorDirectionHorizontal     = 10001,             //水平(0, 0)->(1, 0)
    XQCGradientColorDirectionVertical       = 10010,             //垂直(0, 0)->(0, 1)
    XQCGradientColorDirectionBisection      = 10011,             //45度角(0, 0)->(1, 1)
    
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GradientColor)

/**
 均等分开的给layer层添加混合色背景色，方向为水平方向从左向右

 @param colors 混合颜色集合
 */
- (void)setHorizontalDirectionMixtureColors:(NSArray<UIColor *> *)colors;
- (void)setLocationBisectionDirectionMixtureColors:(NSArray<UIColor *> *)colors;

/**
 均等分开的给layer层添加混合色背景色，方向为垂直方向从上向下

 @param colors 混合颜色集合
 */
- (void)setVerticalDirectionMixtureColors:(NSArray<UIColor *> *)colors;
- (void)setLocationHorizontalDirectionMixtureColors:(NSArray<UIColor *> *)colors;

/**
 均等分开的给layer层添加混合色背景色，方向为45度角从左上向右下

 @param colors 混合颜色集合
 */
- (void)setBisectionDirectionMixtureColors:(NSArray<UIColor *> *)colors;
- (void)setLocationVerticalDirectionMixtureColors:(NSArray<UIColor *> *)colors;

/**
 生产默认的混合色layer，色值组的区间是均等分的

 @param colors 色值组
 @param frame layer层的frame
 @param direction 方向
 @return CAGradientLayer
 */
+ (CAGradientLayer *)gradientLayer:(NSArray<UIColor *> *)colors
                             frame:(CGRect)frame
                         direction:(XQCGradientColorDirection)direction;
+ (CAGradientLayer *)gradientLocationLayer:(NSArray<UIColor *> *)colors
                                     frame:(CGRect)frame
                                 direction:(XQCGradientColorDirection)direction;

@end

NS_ASSUME_NONNULL_END
