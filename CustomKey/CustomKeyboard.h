//
//  CustomKeyboard.h
//  CustomKey
//
//  Created by Zy on 16/8/1.
//  Copyright © 2016年 ldw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomKeyboard : UIView
@property (nonatomic, strong) UIView *myBgView;
@property (nonatomic, strong) UIScrollView *proScroll;
@property (nonatomic, strong) UIButton *proBtn;
@property (nonatomic, strong) UIView *myCarNoView;
@property (nonatomic, strong) UIView *myCoverView;
@property (nonatomic, strong) UIButton *letterBtn;
@property (nonatomic, strong) UIButton *digitBtn;
@property (nonatomic, strong) UIScrollView *digitScroll;
@property(nonatomic,strong)NSArray *provinceArr;
@property(nonatomic,strong)NSArray *letterArr ;
@property(nonatomic,strong)NSArray *digitArr;
@property (nonatomic, strong) UIScrollView *letterScroll;
@property(nonatomic,strong)UITextField *textField;
@end
