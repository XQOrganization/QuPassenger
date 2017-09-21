//
//  MBHudHelper.h
//  Entertainment_App
//
//  Created by 朱青 on 2016/11/2.
//  Copyright © 2016年 Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MBHudHelper : NSObject

+ (MBProgressHUD *)loading;
+ (MBProgressHUD *)loading:(NSString *)msg;
+ (MBProgressHUD *)loading:(NSString *)msg inView:(UIView *)view;
+ (MBProgressHUD *)loading:(NSString *)msg inView:(UIView *)view delay:(CGFloat)seconds completion:(void (^)())completion;

+ (void)dismiss;
+ (void)dismiss:(NSString *)msg;
+ (void)dismiss:(NSString *)msg inView:(UIView *)view;
+ (void)dismiss:(NSString *)msg inView:(UIView *)view delay:(CGFloat)seconds completion:(void (^)())completion;

+ (void)stopLoading:(MBProgressHUD *)hud;
+ (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg;
+ (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;

+ (void)tipMessage:(NSString *)msg;
+ (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds;
+ (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;

@end
