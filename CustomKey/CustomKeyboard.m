//
//  CustomKeyboard.m
//  CustomKey
//
//  Created by Zy on 16/8/1.
//  Copyright © 2016年 ldw. All rights reserved.
//
#import "CustomKeyboard.h"
#import "SPCustomAction.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define keyHight 9*(SCREEN_WIDTH-50)/9+87
@implementation CustomKeyboard
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createKeyBoard];
        [self createCoverView];
        self.myBgView.hidden = NO;
        self.myCoverView.hidden = NO;
        [self addSubview:self.myCoverView];
        [self addSubview:self.myBgView];
    }
    else{
        self.myCoverView.hidden = YES;
        self.myBgView.hidden = YES;
    }

    return self;
}
-(NSArray *)provinceArr{
    if (!_provinceArr) {
        _provinceArr = [SPCustomAction shengFen];
    }
    return  _provinceArr;
}
-(NSArray *)letterArr{
    if (!_letterArr) {
        _letterArr = [SPCustomAction ziMu];
    }
    return _letterArr;
}
-(NSArray *)digitArr{
    if (!_digitArr) {
        _digitArr = [SPCustomAction shuZi];
    }
    return _digitArr;
}
-(void)createCoverView{
    self.myCoverView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-keyHight, SCREEN_WIDTH, 40 )];
    self.myCoverView.backgroundColor = [UIColor redColor];
    self.myCoverView.alpha = 0.4;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, self.myCoverView.frame.size.width, self.myCoverView.frame.size.height);
    [button addTarget:self action:@selector(hideKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
    [self.myCoverView addSubview:button];
}
-(void)hideKeyBoard:(id)seader{
    self.myBgView.hidden = YES;
    self.myCoverView.hidden = YES;
}

-(void)createKeyBoard{
    self.myBgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,keyHight)];
     self.myBgView.backgroundColor = [UIColor greenColor];
//    self.myBgView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
    UIButton *sureBtn = [self customKeyBoardButton];
    sureBtn.frame = CGRectMake(SCREEN_WIDTH-90, 5, 80, 25);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(didMakeSure:) forControlEvents:UIControlEventTouchUpInside];
    [self.myBgView addSubview:sureBtn];
    UIButton *cancelBtn = [self customKeyBoardButton];
    cancelBtn.frame = CGRectMake(10, 5, 80, 25);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.myBgView addSubview:cancelBtn];
    [self addNewKeyboardWithView:self.myBgView];
}

-(UIButton *)customKeyBoardButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.layer.cornerRadius = 8.0;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:234.0/255 green:85.0/255 blue:32.0/255 alpha:1.0] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    return btn;
}
-(void)addNewKeyboardWithView:(UIView*)view
{
    CGFloat tLength;
    tLength = SCREEN_WIDTH;
    self.proScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, tLength, 4*(tLength-50)/9+15)];
    self.proScroll.showsVerticalScrollIndicator = NO;
    self.proScroll.scrollEnabled = NO;
    for (int i=0; i<self.provinceArr.count; i++) {
        self.proBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.proBtn setFrame:CGRectMake(5*(i%9+1)+(tLength-50)/9*(i%9), (tLength-50)/9*(i/9)+5*(i/9), (tLength-50)/9, (tLength-50)/9)];
        self.proBtn.tag = i+600;
        self.proBtn.layer.masksToBounds = YES;
        self.proBtn.layer.cornerRadius = 4.0;
        [self.proBtn setTitle:self.provinceArr[i] forState:UIControlStateNormal];
        self.proBtn.backgroundColor = [UIColor whiteColor];
        [self.proBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.proBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.proScroll addSubview:self.proBtn];
    }
    [self.proScroll setContentSize:CGSizeMake(0, 4*(tLength-50)/9+15)];
    [view addSubview:self.proScroll];
    self.letterScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 4*(tLength-50)/9+65, 6*(tLength-50)/9+30, 5*(tLength-50)/9+20)];
    self.letterScroll.showsVerticalScrollIndicator = NO;
    self.letterScroll.scrollEnabled = NO;
    for (int i=0; i<self.letterArr.count; i++) {
        self.letterBtn = [[UIButton alloc]initWithFrame:CGRectMake(5*(i%6+1)+(tLength-50)/9*(i%6), (tLength-50)/9*(i/6)+5*(i/6), (tLength-50)/9, (tLength-50)/9)];
        self.letterBtn .tag = 700+i;
        self.letterBtn.layer.masksToBounds = YES;
        self.letterBtn.layer.cornerRadius = 4.0;
        [self.letterBtn  setTitle:self.letterArr[i] forState:UIControlStateNormal];
        [self.letterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.letterBtn .backgroundColor = [UIColor whiteColor];
        [self.letterBtn  addTarget:self action:@selector(letterClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.letterScroll addSubview:self.letterBtn];
    }
    [self.letterScroll setContentSize:CGSizeMake(0, 5*(tLength-50)/9+20)];
    [view addSubview:self.letterScroll];
    self.digitScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(30+6*(tLength-50)/9,4*(tLength-50)/9+65, tLength-(6*(tLength-50)/9+30),4*(tLength-50)/9+15)];
    self.digitScroll.showsVerticalScrollIndicator = NO;
    self.digitScroll.scrollEnabled = NO;
    for (int i=0; i<self.digitArr.count; i++) {
        self.digitBtn = [[UIButton alloc]initWithFrame:CGRectMake(5*(i%3+1)+(tLength-50)/9*(i%3),(tLength-50)/9*(i/3)+5*(i/3),(tLength-50)/9, (tLength-50)/9)];
        self.digitBtn.tag = 800+i;
        self.digitBtn.layer.masksToBounds = YES;
        self.digitBtn.layer.cornerRadius = 4.0;
        [self.digitBtn setTitle:self.digitArr[i] forState:UIControlStateNormal];
        self.digitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [self.digitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.digitBtn.backgroundColor = [UIColor whiteColor];
        [self.digitBtn addTarget:self action:@selector(digitClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.digitScroll addSubview:self.digitBtn];
    }
    [self.digitScroll setContentSize:CGSizeMake(0, 4*(tLength-50)/9+15)];
    [view addSubview:self.digitScroll];

}
-(void)didMakeSure:(UIButton *)btn{
    
    self.myCoverView.hidden = YES;
    btn.superview.hidden = YES;
}
-(void)didCancel:(UIButton *)btn{
    
    
    if ([self.textField.text isEqualToString:@""]) {
        self.myCoverView.hidden = YES;
        btn.superview.hidden = YES;
//           self.hidden = YES;
//        self.backgroundColor = [UIColor whiteColor];
    }
    else{
        
        self.textField.text = [self.textField.text substringToIndex:self.textField.text.length-1];
    }
}
-(void)clicked:(UIButton *)btn{
    for (int i=0; i<self.provinceArr.count; i++) {
        UIButton *probtn=(UIButton *)[self.proScroll viewWithTag:600+i];
        probtn.backgroundColor = [UIColor whiteColor];
        [probtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if (i==(btn.tag-600)) {
            
            probtn.backgroundColor = [UIColor colorWithRed:234.0/255 green:85.0/255 blue:32.0/255 alpha:1.0];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [NSThread sleepForTimeInterval:0.2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    probtn.backgroundColor = [UIColor whiteColor];
                    [probtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                });
            });
            [probtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    self.textField.text = [self.textField.text stringByAppendingString:btn.titleLabel.text];
}
-(void)digitClicked:(UIButton *)btn{
    for (int i=0; i<self.digitArr.count; i++) {
        UIButton *letbtn=(UIButton *)[self.digitScroll viewWithTag:800+i];
        //[probtn setFrame:CGRectMake(5+(i%9)*2+i%9*33, 2*(i/9)+i/9*33, 33, 33)];
        letbtn.backgroundColor = [UIColor whiteColor];
        [letbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i==(btn.tag-800)) {
            letbtn.backgroundColor = [UIColor colorWithRed:234.0/255 green:85.0/255 blue:32.0/255 alpha:1.0];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [NSThread sleepForTimeInterval:0.2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    letbtn.backgroundColor = [UIColor whiteColor];
                    [letbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                });
            });
            [letbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    self.textField.text = [self.textField.text stringByAppendingString:btn.titleLabel.text];
}
-(void)letterClicked:(UIButton *)btn{
    for (int i=0; i<self.letterArr.count; i++) {
        UIButton *letbtn=(UIButton *)[self.letterScroll viewWithTag:700+i];
        //        [probtn setFrame:CGRectMake(5+(i%9)*2+i%9*33, 2*(i/9)+i/9*33, 33, 33)];
        letbtn.backgroundColor = [UIColor whiteColor];
        [letbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i==(btn.tag-700)) {
            letbtn.backgroundColor = [UIColor colorWithRed:234.0/255 green:85.0/255 blue:32.0/255 alpha:1.0];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [NSThread sleepForTimeInterval:0.2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    letbtn.backgroundColor = [UIColor whiteColor];
                    [letbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                });
            });
            [letbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    self.textField.text = [self.textField.text stringByAppendingString:btn.titleLabel.text];
}

@end
