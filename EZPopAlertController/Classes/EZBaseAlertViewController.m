//
//  EZBaseAlertViewController.m
//  EZAlertController_Example
//
//  Created by melo on 2020/3/21.
//  Copyright © 2020 melo30. All rights reserved.
//

#import "EZBaseAlertViewController.h"
#import "Masonry.h"

@interface EZBaseAlertViewController ()

@property (nonatomic, strong) UIControl *backgoundControl;

@end

@implementation EZBaseAlertViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//渐变出现
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;//原来视图(上一层视图)的不隐藏
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置黑色透明
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    
    // 给self.view加一个UIControl，控制点击self.view实现隐藏
    if (![self isModal]) {
        [self.view addSubview:self.backgoundControl];
        [self.backgoundControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //这里的高度先不用去设置它，子类里面子控件会自动把它撑起来
        make.centerY.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset([self horizonalEdge]);
        make.right.mas_equalTo(self.view).offset(-[self horizonalEdge]);
    }];
}

#pragma mark - public
- (CGFloat)horizonalEdge {
    return 30.0f;
}

- (CGFloat)containerCircular {
    return 5.0f;
}

- (BOOL)isModal {
    return NO;
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.transform = CGAffineTransformScale(self.containerView.transform, 0.5, 0.5);
        self.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        self.containerView.transform = CGAffineTransformScale(self.containerView.transform, 1/0.5, 1/0.5);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - private
- (void)show {
    self.containerView.alpha = 0.0;
    self.containerView.transform = CGAffineTransformScale(self.containerView.transform, 0.5, 0.5);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.containerView.transform = CGAffineTransformScale(self.containerView.transform, 1/0.5, 1/0.5);
        self.containerView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - lazyLoad
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = [self containerCircular];
        _containerView.layer.masksToBounds = YES;
    }
    return _containerView;
}

- (UIControl *)backgoundControl {
    if (!_backgoundControl) {
        _backgoundControl = [[UIControl alloc] init];
        [_backgoundControl addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgoundControl;
}
@end
