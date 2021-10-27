//
//  EZViewController.m
//  EZPopAlertController
//
//  Created by melo30 on 03/21/2020.
//  Copyright (c) 2020 melo30. All rights reserved.
//

#import "EZViewController.h"
#import "Masonry.h"
#import "EZTextAlertViewController.h"

@interface EZViewController ()

@end

@implementation EZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"弹出来吧！" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(100);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
}

- (void)btnClicked:(UIButton *)sender {
    EZTextAlertViewController *vc = [[EZTextAlertViewController alloc] initWithTitle:@"这是标题" content:@"这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容...这是内容..." buttons:@[@"取消",@"确定"] tapBlock:^(EZTextAlertViewController * _Nonnull controller, NSString * _Nonnull title, NSInteger buttonIndex) {
        
    }];
    vc.buttonColors = @[[UIColor redColor]];
//    vc.hideVerticalLine = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
