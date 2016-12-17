//
//  ViewController.m
//  CustomKey
//
//  Created by Zy on 16/8/1.
//  Copyright © 2016年 ldw. All rights reserved.
#import "ViewController.h"
#import "CustomKeyboard.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define keyHight 9*(SCREEN_WIDTH-50)/9+87

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CustomKeyboard *keyboard = [[CustomKeyboard alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,keyHight )];
    keyboard.backgroundColor = [UIColor whiteColor];
    keyboard.textField = self.textField;
    self.textField.inputView = keyboard;
    return YES;
}
@end
