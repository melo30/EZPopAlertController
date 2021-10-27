//
//  EZBaseAlertViewController.h
//  EZAlertController_Example
//
//  Created by melo on 2020/3/21.
//  Copyright © 2020 melo30. All rights reserved.
//  基类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EZBaseAlertViewController : UIViewController

/** 中间的弹出框背景 */
@property (nonatomic, strong) UIView *containerView;

/** 控制点击屏幕区域是否可以隐藏 默认是NO - 可以隐藏*/
- (BOOL)isModal;

/** 中间弹出框的左右距离 （默认：30，可以在子类重写） */
- (CGFloat)horizonalEdge;

/** 中间弹出框的圆角（默认为：5，可以在子类重写） */
- (CGFloat)containerCircular;

/** 暴露出来子类用 */
- (void)hide;

@end

NS_ASSUME_NONNULL_END
