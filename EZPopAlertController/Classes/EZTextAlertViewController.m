//
//  EZTextAlertViewController.m
//  EZAlertController
//
//  Created by melo on 2020/3/21.
//

#import "EZTextAlertViewController.h"
#import "Masonry.h"

@interface EZTextAlertViewController ()

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;

/// 标题和内容之间的水平线
@property (nonatomic, strong) UIView *topHorizontalLine;

/// 内容
@property (nonatomic, strong) UILabel *contentLabel;

/// 底部按钮水平线
@property (nonatomic, strong) UIView *horizontalLine;

/// 底部按钮垂直线
@property (nonatomic, strong) UIView *verticalLine;

/// 按钮数组
@property (nonatomic, strong) NSArray *buttons;

@end

@implementation EZTextAlertViewController

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content buttons:(NSArray *)buttons tapBlock:(EZAlertControllerCompletionBlock)tapBlock {
    self = [super init];
    if (self) {
        _titleText = title;
        _content = content;
        self.buttons = buttons;
        self.tapBlock = tapBlock;
    }
    return self;
}

#pragma mark - setMethod
- (void)setButtonColors:(NSArray *)buttonColors {
    [buttonColors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSAssert([obj isKindOfClass:[UIColor class]], @"底部按钮颜色的数组只能是UIColor对象!");
    }];
    _buttonColors = buttonColors;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}

- (void)initSubviews {
    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _titleText?:@"这是标题";
    _titleLabel.textColor = _titleColor?:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    _titleLabel.font = _titleFont?:[UIFont systemFontOfSize:17];
    [self.containerView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.containerView).offset(10);
        make.right.mas_equalTo(self.containerView).offset(-10);
        make.top.mas_equalTo(self.containerView).offset(20);
    }];
    
    _topHorizontalLine = [UIView new];
    _topHorizontalLine.hidden = _isShowTopHorizaonLine?NO:YES;
    _topHorizontalLine.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    [self.containerView addSubview:_topHorizontalLine];
    [_topHorizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.containerView);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
    }];

    
    _contentLabel = [UILabel new];
    _contentLabel.text = _content?:@"这是内容";
    _contentLabel.numberOfLines = 0;
    _contentLabel.textAlignment = _contentAlignment;
    _contentLabel.textColor = _contentColor?:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    _contentLabel.font = _contenFont?:[UIFont systemFontOfSize:15];
    [self.containerView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.containerView).offset(18);
        make.right.mas_equalTo(self.containerView).offset(-18);
    }];
    
    _horizontalLine = [UIView new];
    _horizontalLine.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    [self.containerView addSubview:_horizontalLine];
    [_horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.containerView);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(20);
    }];
    
    
    _verticalLine = [UIView new];
    _verticalLine.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    _verticalLine.hidden = _isHideVerticalLine;
    [self.containerView addSubview:_verticalLine];
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(_horizontalLine.mas_bottom);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(50);
    }];
    
    
    if (!self.buttons || self.buttons.count == 0) {//底部没有button
        _horizontalLine.hidden = YES;
        _verticalLine.hidden = YES;
        return;
    }

    if (self.buttons.count == 1) {//底部只有一个按钮
        NSAssert([self.buttons[0] isKindOfClass:[NSString class]], @"按钮标题请传入NSString类型！");
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:self.buttons[0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        if (self.buttonColors && (self.buttonColors.count == 1 || self.buttonColors.count == 2)) {
            [btn setTitleColor:self.buttonColors[0] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(oneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_horizontalLine.mas_bottom);
            make.left.right.mas_equalTo(self.containerView);
            make.height.mas_equalTo(50);
            make.bottom.mas_equalTo(self.containerView);
        }];
    }else if (self.buttons.count == 2) {//底部只有两个按钮
        [self.buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAssert([obj isKindOfClass:[NSString class]], @"按钮标题请传入NSString类型！");
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitle:self.buttons[idx] forState:UIControlStateNormal];
            btn.tag = idx;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(twoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.containerView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (idx == 0) {
                    if (self.buttonColors && self.buttonColors.count == 2) {
                        [btn setTitleColor:self.buttonColors[0] forState:UIControlStateNormal];
                    }
                    make.top.mas_equalTo(_horizontalLine.mas_bottom);
                    make.left.mas_equalTo(self.containerView);
                    make.width.mas_equalTo(self.containerView.mas_width).multipliedBy(0.49);
                    make.height.mas_equalTo(50);
                    make.bottom.mas_equalTo(self.containerView);
                }else {
                    if (self.buttonColors && self.buttonColors.count == 2) {
                        [btn setTitleColor:self.buttonColors[1] forState:UIControlStateNormal];
                    }
                    make.top.mas_equalTo(_horizontalLine.mas_bottom);
                    make.right.mas_equalTo(self.containerView);
                    make.width.mas_equalTo(self.containerView.mas_width).multipliedBy(0.49);
                    make.height.mas_equalTo(50);
                    make.bottom.mas_equalTo(self.containerView);
                }
                
                //是按钮数组有两个，但是按钮颜色数组只传了一个 的情况
                if (self.buttonColors && self.buttonColors.count == 1) {
                    [btn setTitleColor:self.buttonColors[0] forState:UIControlStateNormal];
                }
                
            }];

        }];
    }else {
        NSLog(@"暂不支持添加两个以上的按钮！");
    }
    
}

#pragma mark - ButtonEvent

/// 底部只有一个按钮时候的点击事件
/// @param sender 按钮
- (void)oneBtnClicked:(UIButton *)sender {
    if (self.tapBlock) {
        self.tapBlock(self, sender.currentTitle, 0);
    }
    [self hide];
}

/// 底部只两个按钮时候的点击事件
/// @param sender 按钮
- (void)twoBtnClicked:(UIButton *)sender {
    if (self.tapBlock) {
        self.tapBlock(self, sender.currentTitle, sender.tag);
    }
    [self hide];
}
@end
