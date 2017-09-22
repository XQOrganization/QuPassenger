//
//  QuHudHelper.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/22.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"

@interface QuHudHelper : NSObject

//MBProgressHUD
+ (MBProgressHUD *)mb_loading;
+ (MBProgressHUD *)mb_loading:(NSString *)msg;
+ (MBProgressHUD *)mb_loading:(NSString *)msg inView:(UIView *)view;
+ (MBProgressHUD *)mb_loading:(NSString *)msg inView:(UIView *)view delay:(CGFloat)seconds completion:(void (^)())completion;

+ (void)mb_dismiss;
+ (void)mb_dismiss:(NSString *)msg;
+ (void)mb_dismiss:(NSString *)msg inView:(UIView *)view;
+ (void)mb_dismiss:(NSString *)msg inView:(UIView *)view delay:(CGFloat)seconds completion:(void (^)())completion;

+ (void)mb_stopLoading:(MBProgressHUD *)hud;
+ (void)mb_stopLoading:(MBProgressHUD *)hud message:(NSString *)msg;
+ (void)mb_stopLoading:(MBProgressHUD *)hud message:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;

+ (void)mb_tipMessage:(NSString *)msg;
+ (void)mb_tipMessage:(NSString *)msg delay:(CGFloat)seconds;
+ (void)mb_tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;

//SVProgressHUD
+ (void)sv_showErrorWithStatus:(NSString *)status;
+ (void)sv_showErrorWithStatus:(NSString *)status deley:(CGFloat)seconds;

//custom
+ (void)qu_showMessage:(NSString *)message;
+ (void)qu_showMessage:(NSString *)message withEndBlock:(void(^)(void))endBlock;

@end
