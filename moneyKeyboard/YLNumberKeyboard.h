//
//  YLNumberKeyboard.h
//  moneyKeyboard
//
//  Created by 谢贤 on 2017/9/27.
//  Copyright © 2017年 包燕龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ConfirmBlock)();

@interface YLNumberKeyboard : UIView

@property (nonatomic, weak) UITextField *textFiled;

/// 点击确定回调block
@property (nonatomic,copy) ConfirmBlock confirmClickBlock;

/// 键盘背景色
@property (nonatomic,strong) UIColor *bgColor;
/// 键盘数字背景色
@property (nonatomic,strong) UIColor *keyboardNumBgColor;
/// 键盘文字颜色
@property (nonatomic,strong) UIColor *keyboardTitleColor;
/// 间隔线颜色
@property (nonatomic,strong) UIColor *marginColor;
/// return键被背景色
@property (nonatomic,strong) UIColor *returnBgColor;
/// return键文字颜色
@property (nonatomic,strong) UIColor *returnTitleColor;
/// return键title
@property (nonatomic,strong) NSString *title;
/// 输出内容格式（00000.00）
@property (nonatomic,strong) NSString *formatString;

- (void)drawKeyboard;
@end
