//
//  SPCustomAction.m
//  Smallparking
//
//  Created by smallpos on 15/1/9.
//  Copyright (c) 2015年 smallpos. All rights reserved.
//

#import "SPCustomAction.h"
#import "commoncrypto/commondigest.h"
static UIAlertView* alert;
@implementation SPCustomAction
+(void)alertWithMsg:(NSString *)msg andTime:(int)time{
    alert = [[UIAlertView alloc] initWithTitle:(time==0?@"温馨提示":nil)
                                       message:msg
                                      delegate:(time==0?nil:self)
                             cancelButtonTitle:(time==0?@"确定":nil)
                             otherButtonTitles:nil];
    [alert show];
    if (time==0) {
        return;
    }
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(hide) userInfo:nil repeats:NO];
}
+ (void)hide{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}
+ (BOOL) validateMobile:(NSString *)mobile{
    //(13[0-9]|14[57]|15[012356789]|18[012356789])\\d{8}
    //^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$
    NSString *phoneRegex = @"(13[0-9]|14[57]|15[0123546789]|17[0123456789]|18[0123456789])\\d{8}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
    
}
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//车牌
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}
//通知
+(void)sendNotifation{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSDictionary* dic = @{@"erro":@"服务器未响应！"};
    NSNotification* notification = [NSNotification notificationWithName:@"8000" object:nil userInfo:dic];
    [center postNotification:notification];
}
+(NSString *) compareCurrentTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
+(NSArray*)shengFen{
    
    NSArray* shen = @[@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"港",@"澳",@"台"];
     NSLog(@"fuckc");
    return shen;
}
+(NSArray*)shuZi{
    NSArray* shuzi = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    
    NSLog(@"fuckA");
    return shuzi;
    
}
+(NSArray*)ziMu{
    NSArray* zi = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
     NSLog(@"fuckb");
    return zi;
}
+ (UIBarButtonItem *)createBarBackButtonItem:(id)target
                                    selector:(SEL)action
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 30);
    button.layer.cornerRadius = 15.0;
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.masksToBounds = YES;
    [button setTitle:@"重新登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

+(UIBarButtonItem *)creatLeftBarBtuttonItem:(id)target selector:(SEL)action{

    UIImage * image = [UIImage imageNamed:@"back.png"];
    CGRect buttomFrame = CGRectMake(0, 0, 27.5, 27.5);
    
    UIButton* button = [[UIButton alloc]initWithFrame:buttomFrame];

    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
   // barButton.landscapeImagePhoneInsets = UIEdgeInsetsMake(0, -50,0,0);
   // barButton.width = -100;
    return barButton;
}
+ (NSArray *)creatLeftBarButtonItems:(id)target selector:(SEL)action{
    UIImage * image = [UIImage imageNamed:@"back.png"];
    CGRect buttomFrame = CGRectMake(0, 0, 27.5, 27.5);
    UIButton* button = [[UIButton alloc]initWithFrame:buttomFrame];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 27.5, 27.5);
    UIBarButtonItem* barButton2 = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return @[barButton , barButton2];
}
#pragma mark - XiangtingLu.
//合成颜色.
+ (UIColor*)colorWithHexString:(NSString *)color
{
    NSCharacterSet* set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString* cString = [[color stringByTrimmingCharactersInSet:set] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int red, green, blue, one = 1;
    [[NSScanner scannerWithString:rString] scanHexInt:&red];
    [[NSScanner scannerWithString:gString] scanHexInt:&green];
    [[NSScanner scannerWithString:bString] scanHexInt:&blue];
    const float r = (((float)red)   / 255.0f);
    const float g = (((float)green) / 255.0f);
    const float b = (((float)blue)  / 255.0f);
    const float i = (((float)one));
    return [UIColor colorWithRed:r green:g blue:b alpha:i];
}
@end
