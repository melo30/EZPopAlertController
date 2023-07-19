//
//  EZCustomAlertEZew.h
//  Test
//
//  Created by chenc's Mac on 2022/10/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * kEZCustomAlertDataKey NS_TYPED_EXTENSIBLE_ENUM;
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataTitle;//标题
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataTitleColor;//标题颜色
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataTitleFont;//标题字体

UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataContent;//内容
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataContentColor;//内容颜色
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataContentFont;//内容字体
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataContentAlignment;//内容排版
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataContentAttributed;//内容富文本

UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataButtonTitles;//按钮标题数组
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataButtonColors;//按钮标题颜色数组

UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataPaddingSpace;//左右间距
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataClickBgEZewClose;//点击背景关闭

UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataIsTextField;//中间是否为UITextField
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataTextFieldPlaceholder;
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataTextFieldText;
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataTextFieldFont;
UIKIT_EXTERN kEZCustomAlertDataKey const _Nullable kEZCustomAlertDataTextFieldColor;

@interface EZCustomAlertView : UIView

/// 弹出框(支持自定义组合数据)
/// - Parameter configDict: 配置字典
/// kEZCustomAlertDataTitle;//标题
/// kEZCustomAlertDataTitleColor;//标题颜色
/// kEZCustomAlertDataTitleFont;//标题字体
/// kEZCustomAlertDataContent;//内容
/// kEZCustomAlertDataContentColor;//内容颜色
/// kEZCustomAlertDataContentFont;//内容字体
/// kEZCustomAlertDataContentAlignment;//内容排版
/// kEZCustomAlertDataButtonTitles;//按钮标题数组
/// kEZCustomAlertDataButtonColors;//按钮标题颜色数组
/// kEZCustomAlertDataPaddingSpace;//左右间距
/// kEZCustomAlertDataClickBgEZewClose;//点击背景关闭
/// kEZCustomAlertDataIsTextField;//中间是否为UITextField
/// kEZCustomAlertDataTextFieldPlaceholder;//UITextField的占位
/// kEZCustomAlertDataTextFieldText;//UITextField的内容
/// kEZCustomAlertDataTextFieldFont;//UITextField的字体
/// kEZCustomAlertDataTextFieldColor;//UITextField的字体颜色
/// kEZCustomAlertDataTapBlock;//回调
+ (void)showWithCustomData:(NSDictionary *)configDict tapBlock:(nullable void (^)(NSInteger tag, NSString *textFieldText))tapBlock;

/// 弹出框(默认设置)
/// - Parameters:
///   - title: 标题文本
///   - content: 内容文本
///   - buttons: 按钮文本数组
///   - tapBlock: 按钮点击回调(tag==0:左 / tag==1:右)
+ (void)showWithTitle:(NSString *)title
              content:(NSString *)content
              buttons:(NSArray <NSString *>* _Nullable)buttons
             tapBlock:(nullable void (^)(NSInteger tag, NSString *textFieldText))tapBlock;

/// 弹出框(自定义设置)
/// - Parameters:
///   - title: 标题文本
///   - titleColor: 标题文本颜色
///   - titleFont: 标题文本字体
///   - content: 内容文本
///   - contentColor: 内容文本颜色
///   - contentAlignment: 内容文本排列方式
///   - contentFont: 内容文本字体
///   - contentAttributed: 富文本内容(nil:无富文本)
///   - buttons: 按钮文本数组
///   - buttonColors: 按钮文本颜色数组
///   - paddingSpace: 左右间距(默认30)
///   - clickBgViewClose: 点击背景能否关闭(默认:NO)
///   - tapBlock: 按钮点击回调(tag==0:左 / tag==1:右)
+ (void)showWithTitle:(NSString *)title
           titleColor:(UIColor *)titleColor
            titleFont:(UIFont *)titleFont
              content:(NSString *)content
         contentColor:(UIColor *)contentColor
     contentAlignment:(NSTextAlignment)contentAlignment
          contentFont:(UIFont *)contentFont
    contentAttributed:(nullable NSMutableAttributedString *)contentAttributed
              buttons:( NSArray <NSString *>* _Nullable)buttons
         buttonColors:(NSArray <UIColor *>* _Nullable)buttonColors
         paddingSpace:(CGFloat)paddingSpace
     clickBgViewClose:(BOOL)clickBgViewClose
             tapBlock:(nullable void (^)(NSInteger tag, NSString *textFieldText))tapBlock;

/// 弹出框TextField(自定义设置)
/// - Parameters:
///   - title: 标题文本
///   - titleColor: 标题文本颜色
///   - titleFont: 标题文本字体
///   - buttons: 按钮文本数组
///   - buttonColors: 按钮文本颜色数组
///   - paddingSpace: 左右间距(默认30)
///   - clickBgViewClose: 点击背景能否关闭(默认:NO)
///   - isTextField: 中间是否为UITextField(UITextField和Content只能二选一)
///   - textFieldPlaceholder: UITextField的placeholder
///   - textFieldText: UITextField的Text
///   - textFieldFont: UITextField的Font
///   - textFieldColor: UITextField的Color
///   - tapBlock: 按钮点击回调(tag==0:左 / tag==1:右)
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
             tapBlock:(nullable void (^)(NSInteger tag, NSString *textFieldText))tapBlock;

@end

NS_ASSUME_NONNULL_END
