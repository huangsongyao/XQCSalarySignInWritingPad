//
//  XQCSalarySignedSheetView.m
//  XQC
//
//  Created by anmin on 2019/6/13.
//  Copyright © 2019 xqc. All rights reserved.
//

#import "XQCSalarySignedSheetView.h"
#import "UIView+Frame.h"
#import "XQCBaseWritingPadView.h"
#import "Masonry.h"
#import "UIButton+Clicked.h"
#import "UIImageView+UrlString.h"
#import "UIImage+Convert.h"
#import "XQCMacroHeader.h"

static CGFloat const kXQCSalarySignedInBodyHeight   = 150.0f;

@interface XQCSalarySignedHeaderFooterView : UIView

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XQCSalarySignedHeaderFooterView

- (instancetype)initWithShowCancel:(BOOL)show signedDateString:(nullable NSString *)dateString cancel:(void(^)(UIButton *button))cancel
{
    if (self = [super initWithSize:CGSizeMake(kPHONE_WIDTH, 50.0f)]) {
        if (show) {
            self.cancelButton = [UIButton xqc_buttonWithAction:cancel];
            UIImage *image = [UIImage xqc_imageWithBundle:@"btn_cancel_bg"];
            [self.cancelButton setImage:image forState:UIControlStateNormal];
            [self.cancelButton setImage:image forState:UIControlStateHighlighted];
            [self addSubview:self.cancelButton];
            [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY);
                make.right.equalTo(self.mas_right);
                make.size.mas_equalTo(CGSizeMake(self.height, self.height));
            }];
        }
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = (self.cancelButton ? XQC_REGULAR_FONT_16 : XQC_REGULAR_FONT_11);
        self.titleLabel.textColor = (self.cancelButton ? RGB16(0x2F2D42) : RGB16(0x999999));
        self.titleLabel.text = (self.cancelButton ? @"签名" : (dateString.length ? [NSString stringWithFormat:@"签署日期: %@", dateString] : @"签名代表您已经确认本次收入单金额无误"));
        if ([dateString isEqualToString:@"反馈"]) {
            self.titleLabel.text = dateString;
        }
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(self.height + 10.0f);
            make.right.equalTo(self.mas_right).offset(-(self.height + 10.0f));
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
        if (!show && iPhoneX) {
            if (dateString.length) { 
                self.height += 30.0f;
            }
        }
    }
    return self;
}

@end

//****************************************************************************************************************************************************************

@interface XQCSalarySignedBodyMaskView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation XQCSalarySignedBodyMaskView

- (instancetype)initWithRemoveMask:(void(^)(UIButton *button))remove
{
    if (self = [super initWithSize:CGSizeMake(kPHONE_WIDTH, kXQCSalarySignedInBodyHeight)]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = XQC_REGULAR_FONT_16;
        self.titleLabel.text = @"签名区(正楷签名)";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = RGB16(0x999999);
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10.0f);
            make.right.equalTo(self.mas_right).offset(-10.0f);
            make.bottom.equalTo(self.mas_centerY).offset(-5.5f);
            make.height.equalTo(@(self.titleLabel.font.lineHeight));
        }];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = XQC_REGULAR_FONT_13;
        self.contentLabel.text = @"请在签名区域手写本人签名，确认签名清晰可辨认";
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.textColor = RGB16(0x999999);
        [self addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left);
            make.right.equalTo(self.titleLabel.mas_right);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(11.0f);
            make.height.equalTo(@(self.contentLabel.font.lineHeight));
        }];
        
        @weakify(self);
        UIButton *button = [UIButton xqc_buttonWithAction:^(UIButton *button) {
            @strongify(self);
            [self removeFromSuperview];
            remove(button);
        }];
        button.backgroundColor = UIColor.clearColor;
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end

//****************************************************************************************************************************************************************

@class XQCSalarySignedBodyView;
typedef void(^XQCSignedInBodyBlock)(UIButton *button, XQCSalarySignedBodyView *signedBodyView);
@interface XQCSalarySignedBodyView : UIView

@property (nonatomic, strong) XQCSalarySignedBodyMaskView *bodyMaskView;
@property (nonatomic, strong) UIImageView *signedInImageView;
@property (nonatomic, strong) XQCBaseWritingPadView *writingPadView;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation XQCSalarySignedBodyView

- (instancetype)initWithSignedString:(NSString *)signedString
                          removeMask:(XQCSignedInBodyBlock)remove
                            observer:(void(^)(BOOL isClear))observer
{
    if (self = [super initWithSize:CGSizeMake(kPHONE_WIDTH, kXQCSalarySignedInBodyHeight)]) {
        self.backgroundColor = THEME_LINE_OR_BACKGROUND_COLOR;
        @weakify(self);
        if ([signedString hasPrefix:@"http"]) {
            self.signedInImageView = [[UIImageView alloc] init];
            self.signedInImageView.backgroundColor = UIColor.clearColor;
            [self.signedInImageView xqc_setImageUrlString:signedString];
            [self addSubview:self.signedInImageView];
            [self.signedInImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        } else {
            self.writingPadView = [[XQCBaseWritingPadView alloc] initWithObserver:observer];
            self.writingPadView.backgroundColor = self.backgroundColor;
            [self addSubview:self.writingPadView];
            [self.writingPadView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            
            self.deleteButton = [UIButton xqc_buttonWithAction:^(UIButton *button) {
                @strongify(self);
                [self.writingPadView replotPath];
            }];
            UIImage *deleteImage = [UIImage xqc_imageWithBundle:@"btn_del"];
            [self.deleteButton setImage:deleteImage forState:UIControlStateNormal];
            [self.deleteButton setImage:deleteImage forState:UIControlStateHighlighted];
            [self addSubview:self.deleteButton];
            [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right);
                make.bottom.equalTo(self.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
            }];
        }
        
        if (!signedString.length) {
            self.bodyMaskView = [[XQCSalarySignedBodyMaskView alloc] initWithRemoveMask:^(UIButton *button) {
                @strongify(self);
                remove(button, self);
            }];
            self.bodyMaskView.backgroundColor = self.backgroundColor;
            [self addSubview:self.bodyMaskView];
            [self bringSubviewToFront:self.bodyMaskView];
        }
    }
    return self;
}

@end

//****************************************************************************************************************************************************************

@interface XQCBaseSignedSheetView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *maskBlackView;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) XQCSalarySignedHeaderFooterView *headerView;
- (void)updateSureButtonState:(BOOL)isClear;

@end

@implementation XQCBaseSignedSheetView

- (instancetype)initWithBlock:(void(^)(UITapGestureRecognizer *tapGestrue))block
{
    return [self initWithView:[[UIApplication sharedApplication] keyWindow] signedDateString:nil tapGestrueBlock:block];
}

- (instancetype)initWithView:(UIView *)superview signedDateString:(nullable NSString *)title tapGestrueBlock:(void(^)(UITapGestureRecognizer *tapGestrue))block
{
    if (self = [super initWithSize:CGSizeMake(kPHONE_WIDTH, kPHONE_HEIGHT)]) {
        self.backgroundColor = UIColor.clearColor;
        [superview addSubview:self];
        //半透明遮罩
        self.maskBlackView = [[UIView alloc] init];
        self.maskBlackView.backgroundColor = UIColor.blackColor;
        self.maskBlackView.alpha = 0.0f;
        self.maskBlackView.size = self.size;
        [self addSubview:self.maskBlackView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        tapGesture.delegate = self;
        [[[tapGesture rac_gestureSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:block];
        [self.maskBlackView addGestureRecognizer:tapGesture];
        //主窗口，子类中根据需要设置这个主窗口的高度
        _signedContentView = [[UIView alloc] init]; 
        self.signedContentView.backgroundColor = UIColor.whiteColor;
        self.signedContentView.width = self.width;
        self.signedContentView.y = self.height;
        [self addSubview:self.signedContentView];
        @weakify(self);
        self.headerView = [[XQCSalarySignedHeaderFooterView alloc] initWithShowCancel:YES signedDateString:title cancel:^(UIButton *button) {
            @strongify(self);
            [self remove];
        }];
        [self.signedContentView addSubview:self.headerView];
    }
    return self;
}

#pragma mark - Setter

- (void)createSureButton:(void(^)(UIButton *button))block
{
    if (!self.sureButton) {
        self.sureButton = [UIButton xqc_buttonWithAction:block];
        [self.sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [self.sureButton setTitle:@"确认" forState:UIControlStateHighlighted];
        [self.sureButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.sureButton setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
        [self updateSureButtonState:YES];
        self.sureButton.size = CGSizeMake(self.width, (iPhoneX ? 80.0f : 50.0f));
        [self.signedContentView addSubview:self.sureButton];
    }
}

#pragma mark - Animation

- (void)show
{
    @weakify(self);
    [UIView animateWithDuration:0.35 animations:^{
        @strongify(self);
        self.maskBlackView.alpha = 0.5f;
        self.signedContentView.y = (self.height - self.signedContentView.height);
    } completion:^(BOOL finished) {}];
}

- (void)remove
{
    @weakify(self);
    [UIView animateWithDuration:0.35 animations:^{
        @strongify(self);
        self.maskBlackView.alpha = 0.0f;
        self.signedContentView.y = self.height;
    } completion:^(BOOL finished) {
        @strongify(self);
        [self removeFromSuperview];
    }];
}

#pragma mark - Private

- (void)updateSureButtonState:(BOOL)isClear
{
    self.sureButton.userInteractionEnabled = !isClear;
    UIImage *bgImage = (isClear ? [UIImage xqc_imageWithColor:RGB16(0xD8D8D8)] : [UIImage xqc_imageWithMixColors:@[THEME_BLUE_FONT_COLOR, RGB16(0x4870CB)] size:self.sureButton.size]);
    [self.sureButton setBackgroundImage:bgImage forState:UIControlStateNormal];
    [self.sureButton setBackgroundImage:bgImage forState:UIControlStateHighlighted];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    BOOL isCaptured = ([touch.view isKindOfClass:NSClassFromString(@"XQCSalarySignedHeaderFooterView")] || [touch.view isKindOfClass:NSClassFromString(@"XQCSalarySignedBodyView")]);
    return !isCaptured;
}

@end

//****************************************************************************************************************************************************************

@interface XQCSalarySignedSheetView ()

@property (nonatomic, strong) XQCSalarySignedBodyView *bodyView;
@property (nonatomic, strong) XQCSalarySignedHeaderFooterView *footerView;
@property (nonatomic, copy, readonly) NSString *userSignedName;

@end

@implementation XQCSalarySignedSheetView 

- (instancetype)initWithSigneds:(NSDictionary *)signeds userSureSigned:(XQCSalarySignedBlock)sureSigned
{
    @weakify(self);
    if (self = [super initWithBlock:^(UITapGestureRecognizer *tapGestrue) {
        @strongify(self);
        [self remove];
    }]) {
        //手写板
        self.bodyView = [[XQCSalarySignedBodyView alloc] initWithSignedString:signeds.allValues.firstObject removeMask:^(UIButton *button, XQCSalarySignedBodyView *signedBodyView) {} observer:^(BOOL isClear) {
            @strongify(self);
            [self updateSureButtonState:isClear];
        }];
        self.bodyView.y = self.headerView.bottom;
        [self.signedContentView addSubview:self.bodyView];
        //手写板底部的title
        self.footerView = [[XQCSalarySignedHeaderFooterView alloc] initWithShowCancel:NO signedDateString:signeds.allKeys.firstObject cancel:nil];
        self.footerView.y = self.bodyView.bottom;
        [self.signedContentView addSubview:self.footerView];
        //如果未签收状态，需要显示底部的确定签收按钮
        if (![signeds.allValues.firstObject length]) {
            [self createSureButton:^(UIButton *button) {
                @strongify(self);
                self->_userSignedName = self.bodyView.writingPadView.signedInImageBase64Encoded;
                [[sureSigned(self.userSignedName, self.bodyView.writingPadView.plotSignedInImage) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id _Nullable x) {
                    @strongify(self);
                    if ([x boolValue]) {
                        [self remove];
                    }
                }];
            }];
            self.sureButton.y = self.footerView.bottom;
        }
        self.signedContentView.height = (self.sureButton ? self.sureButton.bottom : self.footerView.bottom);
    }
    return self;
}

@end

