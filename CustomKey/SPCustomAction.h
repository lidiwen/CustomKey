//
//  SPCustomAction.h
//  Smallparking
//
//  Created by smallpos on 15/1/9.
//  Copyright (c) 2015年 smallpos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SPCustomAction : NSObject
+(void)alertWithMsg:(NSString*)msg andTime:(int)time;
+ (BOOL) validateMobile:(NSString *)mobile;
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validateCarNo:(NSString *)carNo;
+(void)sendNotifation;
+(NSArray*)shengFen;
+(NSArray*)ziMu;
+(NSArray*)shuZi;
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
+ (BOOL)checkPassword:(NSString *) password;
+ (UIBarButtonItem *)createBarBackButtonItem:(id)target
                                    selector:(SEL)action;


+ (UIBarButtonItem*)creatLeftBarBtuttonItem:(id)target
                                   selector:(SEL)action;

+ (NSArray*)creatLeftBarButtonItems:(id)target
                           selector:(SEL)action;

#pragma mark - XiangtingLu.
//合成颜色.
+ (UIColor*)colorWithHexString:(NSString *)color;

@end
