//
//  EZTextAlertViewController.h
//  EZAlertController
//
//  Created by melo on 2020/3/21.
//

#import "EZBaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class EZTextAlertViewController;

typedef void(^EZAlertControllerCompletionBlock)(EZTextAlertViewController * __nonnull controller, NSString *__nonnull title, NSInteger buttonIndex);

@interface EZTextAlertViewController : EZBaseAlertViewController

/// 全能初始化方法
/// @param title 标题
/// @param content 内容
/// @param buttons 底部按钮数组标题 (只接受字符串数组)
/// @param tapBlock 回调
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content buttons:(NSArray *)buttons tapBlock:(EZAlertControllerCompletionBlock)tapBlock;

#pragma mark - 自定义属性
/// 标题
@property (nonatomic, copy) NSString *titleText;

/// 标题颜色
@property (nonatomic, strong) UIColor *titleColor;

/// 标题字体
@property (nonatomic, strong) UIFont *titleFont;

/// 内容
@property (nonatomic, copy) NSString *content;

/// 内容排布
@property (nonatomic, assign) NSTextAlignment contentAlignment;

/// 内容颜色
@property (nonatomic, strong) UIColor *contentColor;

/// 内容字体
@property (nonatomic, strong) UIFont *contenFont;

/// 底部按钮的字体颜色数组，只接收UIColor对象数组，并且数组数量只能等于上面全能初始化方法传入的底部按钮数组数量
@property (nonatomic, strong) NSArray *buttonColors;

/// 是否隐藏两个按钮中间的竖线（默认为NO：显示，设置为YES即隐藏）
@property (nonatomic, assign) BOOL isHideVerticalLine;

/// 时候显示标题与内容之间的横线（默认为NO：不显示，设置为YESj即显示）
@property (nonatomic, assign) BOOL isShowTopHorizaonLine;

@property (nonatomic, copy) EZAlertControllerCompletionBlock tapBlock;

@end

NS_ASSUME_NONNULL_END
