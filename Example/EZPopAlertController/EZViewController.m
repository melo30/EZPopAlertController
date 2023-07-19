//
//  EZViewController.m
//  EZPopAlertController
//
//  Created by melo30 on 03/21/2020.
//  Copyright (c) 2020 melo30. All rights reserved.
//

#import "EZViewController.h"
#import "Masonry.h"
#import "EZCustomAlertView.h"

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
#if 1
    //随意组合配置字典属性(推荐)
    [EZCustomAlertView showWithCustomData:@{kEZCustomAlertDataTitle:@"我是标题",
                                            kEZCustomAlertDataTitleColor:UIColor.blackColor,
                                            kEZCustomAlertDataContent:@"我是内容",
                                            kEZCustomAlertDataContentColor:UIColor.grayColor,
                                            kEZCustomAlertDataButtonTitles:@[@"取消",@"确定"],
                                            kEZCustomAlertDataButtonColors:@[UIColor.redColor,UIColor.greenColor],
                                            kEZCustomAlertDataPaddingSpace:@(30.0)
                                          } tapBlock:^(NSInteger tag, NSString * _Nonnull textFieldText) {
                                                if (tag == 0) return;
        
    }];
#endif
    
#if 0
    //标题+内容的基础用法
    [EZCustomAlertView showWithTitle:@"我是标题" content:@"我是内容" buttons:@[@"取消",@"确定"] tapBlock:^(NSInteger tag, NSString * _Nonnull textFieldText) {
        
    }];
    
    // 标题+内容的详细用法
    [EZCustomAlertView showWithTitle:@"提示" titleColor:UIColor.blackColor titleFont:[UIFont systemFontOfSize:16] content:@"内容" contentColor:UIColor.grayColor contentAlignment:NSTextAlignmentCenter contentFont:[UIFont systemFontOfSize:15] contentAttributed:nil buttons:@[@"取消",@"确定"] buttonColors:@[UIColor.redColor,UIColor.greenColor] paddingSpace:30.0 clickBgEZewClose:YES tapBlock:^(NSInteger tag, NSString * _Nonnull textFieldText) {
            
    }];
    
    //标题+TextField详细用法
    [EZCustomAlertView showWithTitle:@"提示" titleColor:UIColor.blackColor titleFont:[UIFont systemFontOfSize:16] buttons:@[@"取消",@"确定"] buttonColors:@[UIColor.redColor,UIColor.greenColor] paddingSpace:30.0 clickBgEZewClose:YES isTextField:YES textFieldPlaceholder:@"我是placeholder" textFieldText:@"我是Text" textFieldFont:[UIFont systemFontOfSize:15] textFieldColor:UIColor.grayColor tapBlock:^(NSInteger tag, NSString * _Nonnull textFieldText) {
            
    }];
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
