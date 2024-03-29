//
//  UIView+Frame.m
//  XQC
//
//  Created by anmin on 2019/4/10.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - Init

- (instancetype)initWithSize:(CGSize)size
{
    CGRect rect = (CGRect){CGPointZero, size};
    return [self initWithFrame:rect];
}

- (instancetype)initWithWidth:(CGFloat)width
{
    CGRect rect = (CGRect){CGPointZero, width, 0.0f};
    return [self initWithFrame:rect];
}

- (instancetype)initWithHeight:(CGFloat)height
{
    CGRect rect = (CGRect){CGPointZero, 0.0f, height};
    return [self initWithFrame:rect];
}

- (instancetype)initWithX:(CGFloat)x
{
    CGRect rect = (CGRect){x, 0.0f, CGSizeZero};
    return [self initWithFrame:rect];
}

- (instancetype)initWithY:(CGFloat)y
{
    CGRect rect = (CGRect){0.0f, y, CGSizeZero};
    return [self initWithFrame:rect];
}

#pragma mark - Get Property

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)x
{
    return self.origin.x;
}

- (CGFloat)y
{
    return self.origin.y;
}

- (CGFloat)right
{
    return self.x + self.width;
}

- (CGFloat)bottom
{
    return self.y + self.height;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)height
{
    return self.size.height;
}

- (CGFloat)width
{
    return self.size.width;
}

- (CGFloat)mid_x
{
    return (self.x + (self.width / 2));
}

- (CGFloat)mid_y
{
    return (self.y + (self.height / 2));
}

- (CGFloat)ceilWidth
{
    return ceil(self.width);
}

- (CGFloat)ceilHeight
{
    return ceil(self.height);
}

- (CGSize)ceilSize
{
    return CGSizeMake(self.ceilWidth, self.ceilHeight); 
}

#pragma mark - Set Origin

- (void)setOrigin:(CGPoint)origin
{
    self.frame = (CGRect){origin, self.size};
}

- (void)setX:(CGFloat)x
{
    [self setOrigin:CGPointMake(x, self.y)];
}

- (void)setY:(CGFloat)y
{
    [self setOrigin:CGPointMake(self.x, y)];
}

#pragma mark - Set Size

- (void)setSize:(CGSize)size
{
    self.frame = (CGRect){self.origin, size};
}

- (void)setWidth:(CGFloat)width
{
    [self setSize:CGSizeMake(width, self.height)];
}

- (void)setHeight:(CGFloat)height
{
    [self setSize:CGSizeMake(self.width, height)];
}



@end
