//
//  YLNumberKeyboard.m
//  moneyKeyboard
//
//  Created by 谢贤 on 2017/9/27.
//  Copyright © 2017年 包燕龙. All rights reserved.
//

#import "YLNumberKeyboard.h"
#define YLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define KScreen_Width   [UIScreen mainScreen].bounds.size.width
#define KScreen_Height  [UIScreen mainScreen].bounds.size.height
#define keyBoardHeight 50.0 //数字键的高度
#define maxLength  100000//限制最大长度

@implementation YLNumberKeyboard

#pragma mark - ---------懒加载---------
/// 键盘背景色
-(UIColor *)bgColor
{
    if (_bgColor == nil) {
        _bgColor = YLColor(242, 242, 242);
    }
    return _bgColor;
}
/// 键盘数字背景色
-(UIColor *)keyboardNumBgColor
{
    if (_keyboardNumBgColor == nil) {
        _keyboardNumBgColor = YLColor(208, 208, 208);
    }
    return _keyboardNumBgColor;
}
/// 键盘文字颜色
-(UIColor *)keyboardTitleColor
{
    if (_keyboardTitleColor == nil) {
        _keyboardTitleColor = YLColor(51, 51, 51);
    }
    return _keyboardTitleColor;
}

/// 间隔线颜色
-(UIColor *)marginColor
{
    if (_marginColor == nil) {
        _marginColor = YLColor(207, 207, 207);
    }
    return _marginColor;
}

/// return键被背景色
-(UIColor *)returnBgColor
{
    if (_returnBgColor == nil) {
        _returnBgColor = HEXCOLOR(0xe46641);
    }
    return _returnBgColor;
}
/// return键文字颜色
-(UIColor *)returnTitleColor
{
    if (_returnTitleColor == nil) {
        _returnTitleColor = YLColor(255, 255, 255);
    }
    return _returnTitleColor;
}
/// return键title
-(NSString *)title
{
    if (_title == nil) {
        _title = @"确定";
    }
    return _title;
}
/// 输出内容格式（00000.00）
-(NSString *)formatString
{
    if (_formatString == nil) {
        _formatString = @"00000.00";
    }
    return _formatString;
}


#pragma mark - ---------初始化方法---------
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // 设置frame
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, keyBoardHeight *4);
        
    }
    return self;
}

- (void)drawKeyboard
{
    // Initialization code
    // 设置背景色
    self.backgroundColor = self.bgColor;
    
    // 画横竖线
    [self addLines];
    
    // 初始化键盘内容
    [self initCustomKeyborad];
}

// 画横竖线
- (void)addLines
{
    for (int i = 0; i <4; i ++) {
        // 画横线
        UIView *HView = [[UIView alloc] init];
        HView.backgroundColor = self.marginColor;
        HView.frame = CGRectMake(0, i*keyBoardHeight, 3*KScreen_Width/4, 0.5);
        if (i==0) {
            HView.frame = CGRectMake(0, i*keyBoardHeight, KScreen_Width, 0.5);
        }
        [self addSubview:HView];
        
        // 画竖线
        UIView *VView = [[UIView alloc]init];
        VView.backgroundColor = self.marginColor;
        VView.frame = CGRectMake(i*KScreen_Width/4, 0, 0.5, keyBoardHeight*4);
        if (i==0) {
            VView.frame = CGRectMake(0, 0, 0, 0);
        }
        [self addSubview:VView];

    }
}


// 初始化键盘内容
- (void)initCustomKeyborad
{
    for (int x = 0; x < 12; x++)
    {
        
        UIButton *NumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 设置frame 九宫格算法
        [NumBtn setFrame:CGRectMake( x%3*(KScreen_Width / 4),  x/3*keyBoardHeight , KScreen_Width / 4, keyBoardHeight)];
        
        
        if (x <= 9){
            //数字1~9  小数点
            [NumBtn setTag:(x + 1)];
            [NumBtn setTitle:[NSString stringWithFormat:@"%ld",NumBtn.tag] forState:UIControlStateNormal];
            if (x==9) {
            [NumBtn setTitle:[NSString stringWithFormat:@"."] forState:UIControlStateNormal];
            }
        }else if (x == 11){
            //退下键盘
            NumBtn.tag = x;
            [NumBtn setImage:[UIImage imageNamed:@"resign"] forState:UIControlStateNormal];

        }else if (x == 10){
            //数字0
            NumBtn.tag = 0;
            [NumBtn setTitle:[NSString stringWithFormat:@"%ld",NumBtn.tag] forState:UIControlStateNormal];
        }
        
        [NumBtn setBackgroundColor:[UIColor clearColor]];
        [NumBtn setTitleColor:self.keyboardTitleColor forState:UIControlStateNormal];
        NumBtn.titleLabel.font = [UIFont systemFontOfSize:22];
        NumBtn.adjustsImageWhenHighlighted = TRUE;
        [NumBtn setBackgroundImage:[self createImageWithColor:self.keyboardNumBgColor] forState:UIControlStateHighlighted];
        
        [NumBtn addTarget:self action:@selector(keyboardViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:NumBtn];
    }
    
    // 删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initButton:deleteBtn withFrame:CGRectMake(3*KScreen_Width/4, 0, KScreen_Width/4, keyBoardHeight*2) backgroundColor:[UIColor clearColor] image:[UIImage imageNamed:@"delete"] backgroundImageOfColor:self.keyboardNumBgColor font:0 title:@"" tag:12];
    
    // 确定按钮
    UIButton *resignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self initButton:resignBtn withFrame:CGRectMake(3*KScreen_Width/4, keyBoardHeight*2, KScreen_Width/4, keyBoardHeight*2) backgroundColor:self.returnBgColor image:nil backgroundImageOfColor:self.returnBgColor font:22 title:self.title tag:13];
}

- (void)initButton:(UIButton *)btn withFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image backgroundImageOfColor:(UIColor *)backgroundImageColor font:(NSInteger)font title:(NSString *)title tag:(NSInteger)tag
{
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:backgroundColor];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:[self createImageWithColor:backgroundImageColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:self.returnTitleColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(keyboardViewAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self addSubview:btn];
}

// 点击键盘
- (void)keyboardViewAction:(UIButton *)sender
{
    NSInteger tag = sender.tag;
//    NSLog(@"%ld",tag);
    switch (tag)
    {
        case 10:
        {
            // 小数点
            if(self.textFiled.text.length > 0 && [self.textFiled.text rangeOfString:@"." options:NSCaseInsensitiveSearch].location == NSNotFound && self.textFiled.text.length < maxLength)
                self.textFiled.text = [NSString stringWithFormat:@"%@.",self.textFiled.text];
        }
            break;
        case 11:
        {
            // 消失
            [self.textFiled resignFirstResponder];

        }
            break;
        case 12:
        {
            // 删除
            if(self.textFiled.text.length > 0)
                self.textFiled.text = [self.textFiled.text substringWithRange:NSMakeRange(0, self.textFiled.text.length - 1)];
        }
            break;
        case 13:
        {
            // 确认
            [self.textFiled resignFirstResponder];
            
            // 添加额外操作
            self.confirmClickBlock();
            
        }
            break;
        default:
        {

            // 判断输入的金额是不是00000.00格式
            [self judgeMoneyStr:self.textFiled.text number:tag];
        }
            break;
    }
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


// 判断输入的金额是不是00000.00格式
- (void)judgeMoneyStr:(NSString *)str number:(NSInteger )tag
{
    NSString *intFormatStr = @"";
    NSString *decimalFormatStr = @"";
    if ([self.formatString containsString:@"."]) {
        NSArray *formatArray = [self.formatString componentsSeparatedByString:@"."];
        intFormatStr = formatArray[0];
        decimalFormatStr = formatArray[1];
    }else{
        intFormatStr = self.formatString;
        decimalFormatStr = @"";
    }

    
    if ([str containsString:@"."]) {// 包含小数点
        NSArray *tempArray = [str componentsSeparatedByString:@"."];
        NSString *intStr = tempArray[0];
        NSString *decimalStr = tempArray[1];

        if (decimalStr.length >= decimalFormatStr.length) {
            NSString *newDecimalStr = [decimalStr substringToIndex:decimalFormatStr.length];
            self.textFiled.text = [NSString stringWithFormat:@"%@.%@",intStr,newDecimalStr];
        }else{
            // 数字
            self.textFiled.text = [NSString stringWithFormat:@"%@%ld",self.textFiled.text,tag];

        }
        
    }else{// 不包含小数
        if (str.length >= intFormatStr.length) {
            self.textFiled.text = [self.textFiled.text substringToIndex:intFormatStr.length];
        }else{
            
            if ([self.textFiled.text isEqualToString:@"0"]) {
                self.textFiled.text = @"0";
            }else{
                // 数字
                self.textFiled.text = [NSString stringWithFormat:@"%@%ld",self.textFiled.text,tag];
            }
        }
    }

}
@end
