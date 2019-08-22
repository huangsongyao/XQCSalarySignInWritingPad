//
//  XQCBaseWritingPadView.m
//  XQC
//
//  Created by anmin on 2019/6/19.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "XQCBaseWritingPadView.h"
#import "UIImage+Convert.h" 
#import "ReactiveObjC.h"

@interface XQCBaseWritingPadView ()

@property (nonatomic, assign) CGMutablePathRef pathRef;
@property (nonatomic, strong) NSNumber *isClearWritingPad;

@end 

@implementation XQCBaseWritingPadView

- (instancetype)initWithObserver:(void(^)(BOOL isClear))observer
{
    if (self = [super init]) {
        self.backgroundColor = UIColor.clearColor;
        self.pathRef = CGPathCreateMutable();
        self.witingBenWidth = 5.0f;
        self.isClearWritingPad = @(YES);
        [[RACObserve(self, isClearWritingPad) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNumber * _Nullable x) { 
            observer(x.boolValue);
        }];
    }
    return self;
}

#pragma mark - Touch Event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint position = [touches.anyObject locationInView:self];
    CGPathMoveToPoint(self.pathRef, nil, position.x, position.y);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint position = [touches.anyObject locationInView:self];
    [self pathAddPoints:@[[NSValue valueWithCGPoint:position]]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint position = [touches.anyObject locationInView:self];
    [self pathAddPoints:@[[NSValue valueWithCGPoint:position],
                          [NSValue valueWithCGPoint:CGPointMake(position.x-1.5f, position.y)],
                          [NSValue valueWithCGPoint:CGPointMake(position.x+1.5f, position.y)], ]];
}

- (void)pathAddPoints:(NSArray<NSValue *> *)positions
{
    for (NSValue *position in positions) {
        CGPathAddLineToPoint(self.pathRef, nil, position.CGPointValue.x, position.CGPointValue.y);
    }
    [self setNeedsDisplay];
    self.isClearWritingPad = @(NO);
}

#pragma mark - DrawRect

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, self.pathRef);
    CGContextSetLineWidth(context, self.witingBenWidth);
    CGContextStrokePath(context);
}

#pragma mark - Replot

- (void)replotPath
{
    self.pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(self.pathRef, nil, 0, 0);
    CGPathAddLineToPoint(self.pathRef, nil, 0, 0);
    [self setNeedsDisplay];
    self.isClearWritingPad = @(YES);
}

#pragma mark - Setter

- (void)setWitingPadBenWidth:(CGFloat)witingBenWidth
{
    _witingBenWidth = witingBenWidth;
    [self setNeedsDisplay];
}

#pragma mark - Create SignedIn Image

- (NSString *)signedInImageBase64Encoded
{
    UIImage *image = self.plotSignedInImage;
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *base64EncodedString = [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    return base64EncodedString;
}

- (UIImage *)plotSignedInImage
{
    UIImage *image = [UIImage xqc_viewDrawingImage:self];
    return image;
}

@end
