//
//  EZCustomAlertView.m
//  Test
//
//  Created by chenc's Mac on 2022/10/9.
//

#import "EZCustomAlertView.h"
#import "Masonry.h"

#define kDefaultTitleColor [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]
#define kDefaultTitleFont [UIFont boldSystemFontOfSize:17]
#define kDefaultContentColor [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]
#define kDefaultContentFont [UIFont systemFontOfSize:15]
#define kLeftDefaultButtonColor [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]
#define kRightDefaultButtonColor [UIColor colorWithRed:16.0/255.0 green:155.0/255.0 blue:246.0/255.0 alpha:1.0]

NSString * const  kEZCustomAlertDataTitle = @"kEZCustomAlertDataTitle";
NSString * const  kEZCustomAlertDataTitleColor = @"kEZCustomAlertDataTitleColor";
NSString * const  kEZCustomAlertDataTitleFont = @"kEZCustomAlertDataTitleFont";
NSString * const  kEZCustomAlertDataContent = @"kEZCustomAlertDataContent";
NSString * const  kEZCustomAlertDataContentColor = @"kEZCustomAlertDataContentColor";
NSString * const  kEZCustomAlertDataContentFont = @"kEZCustomAlertDataContentFont";
NSString * const  kEZCustomAlertDataContentAlignment = @"kEZCustomAlertDataContentAlignment";
NSString * const  kEZCustomAlertDataContentAttributed = @"kEZCustomAlertDataContentAttributed";
NSString * const  kEZCustomAlertDataButtonTitles = @"kEZCustomAlertDataButtonTitles";
NSString * const  kEZCustomAlertDataButtonColors = @"kEZCustomAlertDataButtonColors";
NSString * const  kEZCustomAlertDataPaddingSpace = @"kEZCustomAlertDataPaddingSpace";
NSString * const  kEZCustomAlertDataClickBgViewClose = @"kEZCustomAlertDataClickBgViewClose";
NSString * const  kEZCustomAlertDataIsTextField = @"kEZCustomAlertDataIsTextField";
NSString * const  kEZCustomAlertDataTextFieldPlaceholder = @"kEZCustomAlertDataTextFieldPlaceholder";
NSString * const  kEZCustomAlertDataTextFieldText = @"kEZCustomAlertDataTextFieldText";
NSString * const  kEZCustomAlertDataTextFieldFont = @"kEZCustomAlertDataTextFieldFont";
NSString * const  kEZCustomAlertDataTextFieldColor = @"kEZCustomAlertDataTextFieldColor";


@interface EZCustomAlertView () <UIGestureRecognizerDelegate>

///背景View
@property (nonatomic, strong) UIView *bgV;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) void (^tapBlock) (NSInteger tag, NSString *textFieldText);

@property (nonatomic, assign) BOOL clickBgViewClose;

@property (nonatomic, strong) NSMutableDictionary *configDict;

@end

@implementation EZCustomAlertView

#pragma mark - public

+ (void)showWithCustomData:(NSDictionary *)configDict tapBlock:(nullable void (^)(NSInteger tag, NSString *textFieldText))tapBlock {
    NSMutableDictionary *mulDict = [self defaultData];
    [mulDict addEntriesFromDictionary:configDict];
    EZCustomAlertView *alertView = [[EZCustomAlertView alloc] init];
    alertView.configDict = mulDict;
    alertView.tapBlock = tapBlock;
    alertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    alertView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [alertView initSubviewsWithTitle:mulDict[kEZCustomAlertDataTitle]
                          titleColor:mulDict[kEZCustomAlertDataTitleColor]
                           titleFont:mulDict[kEZCustomAlertDataTitleFont]
                             content:mulDict[kEZCustomAlertDataContent]
                        contentColor:mulDict[kEZCustomAlertDataContentColor]
                    contentAlignment:[mulDict[kEZCustomAlertDataContentAlignment] integerValue]
                         contentFont:mulDict[kEZCustomAlertDataContentFont]
                   contentAttributed:mulDict[kEZCustomAlertDataContentAttributed]
                             buttons:mulDict[kEZCustomAlertDataButtonTitles]
                        buttonColors:mulDict[kEZCustomAlertDataButtonColors]
                        paddingSpace:[mulDict[kEZCustomAlertDataPaddingSpace] floatValue]
                    clickBgViewClose:[mulDict[kEZCustomAlertDataClickBgViewClose] boolValue]
                         isTextField:[mulDict[kEZCustomAlertDataIsTextField] boolValue]
                textFieldPlaceholder:mulDict[kEZCustomAlertDataTextFieldPlaceholder]
                       textFieldText:mulDict[kEZCustomAlertDataTextFieldText]
                       textFieldFont:mulDict[kEZCustomAlertDataTextFieldFont]
                      textFieldColor:mulDict[kEZCustomAlertDataTextFieldColor]
                            tapBlock:tapBlock];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+ (NSMutableDictionary *)defaultData {
    NSDictionary *dict = @{kEZCustomAlertDataTitle : @"提示",
                           kEZCustomAlertDataTitleColor : kDefaultTitleColor,
                           kEZCustomAlertDataTitleFont : kDefaultTitleFont,
                           kEZCustomAlertDataContent : @"确定吗？",
                           kEZCustomAlertDataContentColor:kDefaultContentColor,
                           kEZCustomAlertDataContentFont:kDefaultContentFont,
                           kEZCustomAlertDataContentAlignment:@(NSTextAlignmentCenter),
                           kEZCustomAlertDataPaddingSpace:@(30),
                           kEZCustomAlertDataButtonTitles:@[@"取消",@"确定"],
                           kEZCustomAlertDataButtonColors:@[kLeftDefaultButtonColor,kRightDefaultButtonColor]
    };
    
    return [NSMutableDictionary dictionaryWithDictionary:dict];
}

+ (void)showWithTitle:(NSString *)title
              content:(NSString *)content
              buttons:(NSArray <NSString *>* _Nullable)buttons
             tapBlock:(nullable void (^)(NSInteger tag, NSString *textFieldText))tapBlock {
    
    NSArray <UIColor *>* buttonColors;
    if (!buttons || buttons.count == 0) {
        buttonColors = @[];
    }else if (buttons.count == 1) {
        buttonColors = @[kRightDefaultButtonColor];
    }else if (buttons.count == 2) {
        buttonColors = @[kLeftDefaultButtonColor, kRightDefaultButtonColor];
    }
    
    [self showWithTitle:title titleColor:kDefaultTitleColor titleFont:kDefaultTitleFont content:content contentColor:kDefaultContentColor contentAlignment:NSTextAlignmentCenter contentFont:kDefaultContentFont contentAttributed:nil buttons:buttons buttonColors:buttonColors paddingSpace:30.0 clickBgViewClose:NO tapBlock:tapBlock];
}

+ (void)showWithTitle:(NSString *)title
           titleColor:(UIColor *)titleColor
            titleFont:(UIFont *)titleFont
              content:(NSString *)content
         contentColor:(UIColor *)contentColor
     contentAlignment:(NSTextAlignment)contentAlignment
          contentFont:(UIFont *)contentFont
    contentAttributed:(nullable NSMutableAttributedString *)contentAttributed
              buttons:(NSArray <NSString *>* _Nullable)buttons
         buttonColors:(NSArray <UIColor *>* _Nullable)buttonColors
         paddingSpace:(CGFloat)paddingSpace
     clickBgViewClose:(BOOL)clickBgViewClose
             tapBlock:(nullable void (^)(NSInteger tag, NSString *textFieldText))tapBlock {
    //1.初始化子View
    EZCustomAlertView *alertView = [[EZCustomAlertView alloc] init];
    alertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    alertView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [alertView initSubviewsWithTitle:title titleColor:titleColor titleFont:titleFont content:content contentColor:contentColor contentAlignment:contentAlignment contentFont:contentFont contentAttributed:contentAttributed buttons:buttons buttonColors:buttonColors paddingSpace:paddingSpace clickBgViewClose:clickBgViewClose isTextField:NO textFieldPlaceholder:nil textFieldText:nil textFieldFont:nil textFieldColor:nil tapBlock:tapBlock];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+ (void)showWithTitle:(NSString *)title
           titleColor:(UIColor *)titleColor
            titleFont:(UIFont *)titleFont
              buttons:( NSArray <NSString *>* _Nullable)buttons
         buttonColors:(NSArray <UIColor *>* _Nullable)buttonColors
         paddingSpace:(CGFloat)paddingSpace
     clickBgViewClose:(BOOL)clickBgViewClose
          isTextField:(BOOL)isTextField
 textFieldPlaceholder:(NSString *)textFieldPlaceholder
        textFieldText:(nullable NSString *)textFieldText
        textFieldFont:(UIFont *)textFieldFont
       textFieldColor:(UIColor *)textFieldColor
             tapBlock:(nullable void (^)(NSInteger tag, NSString *textFieldText))tapBlock {
    //1.初始化子View
    EZCustomAlertView *alertView = [[EZCustomAlertView alloc] init];
    alertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    alertView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [alertView initSubviewsWithTitle:title titleColor:titleColor titleFont:titleFont content:nil contentColor:nil contentAlignment:NSTextAlignmentCenter contentFont:nil contentAttributed:nil buttons:buttons buttonColors:buttonColors paddingSpace:paddingSpace clickBgViewClose:clickBgViewClose isTextField:isTextField textFieldPlaceholder:textFieldPlaceholder textFieldText:textFieldText textFieldFont:textFieldFont textFieldColor:textFieldColor tapBlock:tapBlock];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

#pragma mark - private
- (void)initSubviewsWithTitle:(NSString *)title
           titleColor:(UIColor *)titleColor
            titleFont:(UIFont *)titleFont
              content:(NSString *)content
         contentColor:(UIColor *)contentColor
     contentAlignment:(NSTextAlignment)contentAlignment
          contentFont:(UIFont *)contentFont
    contentAttributed:(nullable NSMutableAttributedString *)contentAttributed
              buttons:(NSArray <NSString *>*)buttons
         buttonColors:(NSArray <UIColor *>*)buttonColors
         paddingSpace:(CGFloat)paddingSpace
     clickBgViewClose:(BOOL)clickBgViewClose
          isTextField:(BOOL)isTextField
 textFieldPlaceholder:(NSString *)textFieldPlaceholder
        textFieldText:(NSString *)textFieldText
        textFieldFont:(UIFont *)textFieldFont
       textFieldColor:(UIColor *)textFieldColor
             tapBlock:(void (^)(NSInteger tag, NSString *textFieldText))tapBlock {
    
    NSAssert(buttons.count == buttonColors.count, @"buttons 和 buttonColors数组需一一对应！");
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureEvent)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    
    self.tapBlock = tapBlock;
    self.clickBgViewClose = clickBgViewClose;
    
    _bgV = [UIView new];
    _bgV.backgroundColor = UIColor.whiteColor;
    _bgV.layer.masksToBounds = YES;
    _bgV.layer.cornerRadius = 5;
    [self addSubview:_bgV];
    [_bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(paddingSpace);
        make.right.mas_equalTo(-paddingSpace);
        make.centerY.mas_equalTo(self);
        //这里的高度先不用设置，后面子View会自动把它撑起来
    }];
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = title;
    titleLab.textColor = titleColor;
    titleLab.font = titleFont;
    [_bgV addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(20);
    }];
    
    
    _textField = [[UITextField alloc] init];
    UILabel *contentLab = [UILabel new];
    if (isTextField) {
        _textField.placeholder = textFieldPlaceholder;
        _textField.text = textFieldText;
        _textField.font = textFieldFont;
        _textField.textColor = textFieldColor;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.layer.masksToBounds = YES;
        _textField.layer.cornerRadius = 4.0;
        _textField.layer.borderColor = [UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0].CGColor;
        _textField.layer.borderWidth = 0.5;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 40)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_bgV addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.right.mas_equalTo(-18);
            make.height.mas_equalTo(44);
            make.top.mas_equalTo(titleLab.mas_bottom).offset(20);
            if (!buttons || buttons.count == 0) {
                make.bottom.mas_equalTo(-20);
            }
        }];
    }else {
        contentLab.numberOfLines = 0;
        contentLab.text = content;
        contentLab.textColor = contentColor;
        contentLab.textAlignment = contentAlignment;
        contentLab.font = contentFont;
        if (contentAttributed) {
            contentLab.attributedText = contentAttributed;
        }
        [_bgV addSubview:contentLab];
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(18);
            make.right.mas_equalTo(-18);
            make.top.mas_equalTo(titleLab.mas_bottom).offset(20);
            if (!buttons || buttons.count == 0) {
                make.bottom.mas_equalTo(-20);
            }
        }];
    }
    
    UIView *horizontalLine = [UIView new];
    horizontalLine.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    [_bgV addSubview:horizontalLine];
    [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(isTextField ? _textField.mas_bottom : contentLab.mas_bottom).offset(20);
    }];
    
    UIView *verticalLine = [UIView new];
    verticalLine.hidden = buttons.count < 2;
    verticalLine.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    [_bgV addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(horizontalLine.mas_bottom);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(50);
    }];
    
    if (!buttons || buttons.count == 0) {//底部没有按钮
        horizontalLine.hidden = YES;
        verticalLine.hidden = YES;
    }
    
    if (buttons.count == 1) {//底部只有一个按钮
        NSAssert([buttons[0] isKindOfClass:[NSString class]], @"按钮标题请传入NSString类型！");
        UIButton *btn = [UIButton new];
        [btn setTitle:buttons[0] forState:UIControlStateNormal];
        [btn setTitleColor:buttonColors[0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [btn addTarget:self action:@selector(oneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bgV addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(horizontalLine.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
            make.bottom.mas_equalTo(0);
        }];
    }else if (buttons.count == 2) {//底部有两个按钮
        [buttons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [UIButton new];
            btn.tag = idx;
            [btn setTitle:buttons[idx] forState:UIControlStateNormal];
            [btn setTitleColor:buttonColors[idx] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            [btn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_bgV addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (idx == 0) {
                    make.top.mas_equalTo(horizontalLine.mas_bottom);
                    make.left.mas_equalTo(0);
                    make.width.mas_equalTo(_bgV.mas_width).multipliedBy(0.49);
                    make.height.mas_equalTo(50);
                    make.bottom.mas_equalTo(0);
                }else {
                    make.top.mas_equalTo(horizontalLine.mas_bottom);
                    make.right.mas_equalTo(0);
                    make.width.mas_equalTo(_bgV.mas_width).multipliedBy(0.49);
                    make.height.mas_equalTo(50);
                    make.bottom.mas_equalTo(0);
                }
            }];
        }];
    }else {
        NSLog(@"暂不支持添加两个以上的按钮！");
    }
    
    //弹出动画
    _bgV.transform = CGAffineTransformScale(_bgV.transform, 0.5, 0.5);
    [UIView animateWithDuration:0.3 animations:^{
        self.bgV.transform = CGAffineTransformScale(self.bgV.transform, 1/0.5, 1/0.5);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {

    }];
}

- (void)hide {
    //隐藏动画
    [UIView animateWithDuration:0.3 animations:^{
        self.bgV.transform = CGAffineTransformScale(self.bgV.transform, 0.5, 0.5);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)tapGestureEvent {
    if (self.clickBgViewClose) {
        [self hide];
    }
}

#pragma mark - buttonEvent
- (void)oneBtnClick:(UIButton *)sender {
    if (self.tapBlock) {
        self.tapBlock(0, _textField.text?:@"");
    }
    [self hide];
}

- (void)twoBtnClick:(UIButton *)sender {
    if (self.tapBlock) {
        self.tapBlock(sender.tag, _textField.text?:@"");
    }
    [self hide];
}

#pragma mark - lifeCycle
- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
