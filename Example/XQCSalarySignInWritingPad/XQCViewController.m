//
//  XQCViewController.m
//  XQCSalarySignInWritingPad
//
//  Created by huangsongyao on 08/21/2019.
//  Copyright (c) 2019 huangsongyao. All rights reserved.
//

#import "XQCViewController.h"
#import "XQCWrigtingPadTools.h"

@interface XQCViewController ()

@end

@implementation XQCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = self.view.bounds;
    [button setTitle:@"clicked me" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.view addSubview:button];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)test:(id)sender
{
    [XQCWrigtingPadTools showCustomWrigtingPad:@{} userSureSigned:^RACSignal * _Nonnull(NSString * _Nonnull userSignedString, UIImage * _Nonnull image) {
        return [RACSignal empty];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
