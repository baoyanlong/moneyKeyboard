//
//  ViewController.m
//  moneyKeyboard
//
//  Created by 谢贤 on 2017/9/27.
//  Copyright © 2017年 包燕龙. All rights reserved.
//

#import "ViewController.h"
#import "YLNumberKeyboard.h"
#define YLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define YLRandomColor YLColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
@interface ViewController ()
/// textField
@property (nonatomic,strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(150, 300, 120, 44);
    [btn setTitle:@"弹出键盘" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showMoneyKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = CGRectMake(150, 200, 120, 44);
    textField.backgroundColor = [UIColor lightGrayColor];
    self.textField = textField;
    [self.view addSubview:textField];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showMoneyKeyboard
{
    YLNumberKeyboard *keyboard = [[YLNumberKeyboard alloc]init];
    // 指定哪个textfield需要弹出数字键盘
    keyboard.textFiled = self.textField;
    self.textField.inputView = keyboard;
    // 个性化设置键盘
    keyboard.bgColor = YLRandomColor;
    keyboard.returnBgColor = YLRandomColor;
    keyboard.returnTitleColor = YLRandomColor;
    keyboard.formatString = @"000.000";
    __weak YLNumberKeyboard *keyboard1 = keyboard;
    keyboard.confirmClickBlock = ^{
       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"要求的格式为%@  输入的数字为%@",keyboard1.formatString,self.textField.text] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    };
    // 绘制键盘
    [keyboard drawKeyboard];
    
}

@end
