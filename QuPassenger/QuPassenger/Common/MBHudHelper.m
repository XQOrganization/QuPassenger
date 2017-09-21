//
//  MBHudHelper.m
//  Entertainment_App
//
//  Created by 朱青 on 2016/11/2.
//  Copyright © 2016年 Entertainment. All rights reserved.
//

#import "MBHudHelper.h"

@implementation MBHudHelper

+ (MBProgressHUD *)loading
{
    return [MBHudHelper loading:nil];
}

+ (MBProgressHUD *)loading:(NSString *)msg
{
    return [MBHudHelper loading:msg inView:nil];
}

+ (MBProgressHUD *)loading:(NSString *)msg inView:(UIView *)view
{
    UIView *inView = view ? view : [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *string = [msg stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (string.length > 0){
            
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.label.text = msg;
        }
        [inView addSubview:hud];
        [hud showAnimated:YES];
        // 超时自动消失
        // [hud hide:YES afterDelay:kRequestTimeOutTime];
    });
    return hud;
}

+ (MBProgressHUD *)loading:(NSString *)msg inView:(UIView *)view delay:(CGFloat)seconds completion:(void (^)())completion
{
    UIView *inView = view ? view : [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *string = [msg stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (string.length > 0){
            
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.label.text = msg;
        }
        [inView addSubview:hud];
        [hud showAnimated:YES];
        // 超时自动消失
        [hud hideAnimated:YES afterDelay:seconds];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion){
                completion();
            }
        });
    });
    return hud;
}

+ (void)dismiss
{
    [MBHudHelper dismiss:nil];
}

+ (void)dismiss:(NSString *)msg
{
    [MBHudHelper dismiss:msg inView:nil];
}

+ (void)dismiss:(NSString *)msg inView:(UIView *)view
{
    UIView *inView = view ? view : [UIApplication sharedApplication].keyWindow;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:inView animated:YES];
        
        if (msg.trim.length > 0) {
            [PublicManager showMessage:msg];
        }
        
    });
}

+ (void)dismiss:(NSString *)msg inView:(UIView *)view delay:(CGFloat)seconds completion:(void (^)())completion
{
    UIView *inView = view ? view : [UIApplication sharedApplication].keyWindow;
   
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:inView animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion){
                completion();
            }
        });
    });
   
}

+ (void)stopLoading:(MBProgressHUD *)hud
{
    [MBHudHelper stopLoading:hud message:nil];
}

+ (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg
{
    [MBHudHelper stopLoading:hud message:msg delay:0 completion:nil];
}

+ (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion
{
    if (hud && hud.superview){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *string = [msg stringByReplacingOccurrencesOfString:@" " withString:@""];
            if (string.length > 0){
                hud.label.text = msg;
                hud.mode = MBProgressHUDModeText;
            }
            
            [hud hideAnimated:YES afterDelay:seconds];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (completion)
                {
                    completion();
                }
            });
        });
    }
    
}


+ (void)tipMessage:(NSString *)msg
{
    [MBHudHelper tipMessage:msg delay:1];
}

+ (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds
{
    [MBHudHelper tipMessage:msg delay:seconds completion:nil];
    
}

+ (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion
{
    NSString *string = [msg stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (string.length == 0){
    
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
 
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = msg;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:seconds];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion)
            {
                completion();
            }
        });
    });
}


@end
