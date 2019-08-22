//
//  UIView+GradientColor.m
//  XQC
//
//  Created by anmin on 2019/4/19.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "UIView+GradientColor.h"

@implementation UIView (GradientColor)

#pragma mark - Methods

+ (NSArray<NSNumber *> *)locationsByMixtureColors:(NSArray<UIColor *> *)colors
{
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%@", @(1.0f)]];
    NSDecimalNumber *byDividing = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%@", @(colors.count)]];
    NSDecimalNumber *result = [decimalNumber decimalNumberByDividingBy:byDividing];
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:colors.count];
    for (NSInteger i = 0; i < colors.count; i ++) {
        if (i > 0) {
            result = [result decimalNumberByAdding:result];
        }
        [results addObject:result];
    }
    return results.mutableCopy;
}

- (void)setLocationBisectionDirectionMixtureColors:(NSArray<UIColor *> *)colors
{
    [self setMixtureColors:colors locations:@[@(0.0f), @(1.0f)] direction:XQCGradientColorDirectionBisection];
}

- (void)setBisectionDirectionMixtureColors:(NSArray<UIColor *> *)colors
{
    NSArray *results = [self.class locationsByMixtureColors:colors];
    [self setMixtureColors:colors locations:results.mutableCopy direction:XQCGradientColorDirectionBisection];
}

- (void)setLocationHorizontalDirectionMixtureColors:(NSArray<UIColor *> *)colors
{
    [self setMixtureColors:colors locations:@[@(0.0f), @(1.0f)] direction:XQCGradientColorDirectionHorizontal];
}

- (void)setHorizontalDirectionMixtureColors:(NSArray<UIColor *> *)colors
{
    NSArray *results = [self.class locationsByMixtureColors:colors];
    [self setMixtureColors:colors locations:results.mutableCopy direction:XQCGradientColorDirectionHorizontal];
}

- (void)setLocationVerticalDirectionMixtureColors:(NSArray<UIColor *> *)colors
{
    [self setMixtureColors:colors locations:@[@(0.0f), @(1.0f)] direction:XQCGradientColorDirectionVertical];
}

- (void)setVerticalDirectionMixtureColors:(NSArray<UIColor *> *)colors
{
    NSArray *results = [self.class locationsByMixtureColors:colors];
    [self setMixtureColors:colors locations:results.mutableCopy direction:XQCGradientColorDirectionVertical];
}

- (void)setMixtureColors:(NSArray<NSDictionary<UIColor *, NSNumber *> *> *)colors direction:(XQCGradientColorDirection)direction
{
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    NSMutableArray *locations = [NSMutableArray arrayWithCapacity:colors.count];
    for (NSDictionary *color in colors) {
        [cgColors addObject:color.allKeys.firstObject];
        [locations addObject:color.allValues.firstObject];
    }
    [self setMixtureColors:cgColors locations:locations direction:direction];
}

- (void)setMixtureColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations direction:(XQCGradientColorDirection)direction
{
    CAGradientLayer *layer = [self.class gradientLayer:colors locations:locations frame:self.frame direction:direction];
    [self.layer addSublayer:layer];
}

+ (CAGradientLayer *)gradientLayer:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations frame:(CGRect)frame direction:(XQCGradientColorDirection)direction
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    NSParameterAssert(!CGRectEqualToRect(frame, CGRectZero));
    layer.frame = frame;
    NSDictionary<NSValue *, NSValue *> *directionDictionary = [self.class mixtrueColorDrawCGPoint:direction];
    layer.startPoint = directionDictionary.allKeys.firstObject.CGPointValue;
    layer.endPoint = directionDictionary.allValues.firstObject.CGPointValue;
    
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors) {
        [cgColors addObject:((__bridge id)color.CGColor)];
    }
    
    layer.colors = cgColors.mutableCopy;
    layer.locations = locations;
    return layer;
}

+ (CAGradientLayer *)gradientLayer:(NSArray<UIColor *> *)colors
                             frame:(CGRect)frame
                         direction:(XQCGradientColorDirection)direction
{
    return [self.class gradientLayer:colors
                           locations:[self.class locationsByMixtureColors:colors]
                               frame:frame
                           direction:direction];
}

+ (CAGradientLayer *)gradientLocationLayer:(NSArray<UIColor *> *)colors
                                     frame:(CGRect)frame
                                 direction:(XQCGradientColorDirection)direction
{
    return [self.class gradientLayer:colors
                           locations:@[@(0.0f), @(1.0f)]
                               frame:frame
                           direction:direction];
}

+ (NSDictionary<NSValue *, NSValue *> *)mixtrueColorDrawCGPoint:(XQCGradientColorDirection)direction
{
    NSDictionary<NSValue *, NSValue *> *valueDictionary = @{
                                                            @(XQCGradientColorDirectionHorizontal) : @{[NSValue valueWithCGPoint:CGPointZero] : [NSValue valueWithCGPoint:CGPointMake(1, 0)]},
                                                            @(XQCGradientColorDirectionVertical) : @{[NSValue valueWithCGPoint:CGPointZero] : [NSValue valueWithCGPoint:CGPointMake(0, 1)]},
                                                            @(XQCGradientColorDirectionBisection) : @{[NSValue valueWithCGPoint:CGPointZero] : [NSValue valueWithCGPoint:CGPointMake(1, 1)]}, }[@(direction)];
    return valueDictionary;
                                               
}

@end
