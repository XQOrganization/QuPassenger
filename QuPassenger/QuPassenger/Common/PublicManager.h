//
//  PublicManager.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/8/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import <Foundation/Foundation.h>

float HeightForString(NSString *value,float fontSize,float width);
float WidthForString(NSString *value,float fontSize,float height);

@interface PublicManager : NSObject

+ (NSDictionary *)getMainDataFromLocal;

+ (void)saveMainDataToLocalWithDictionary:(NSDictionary *)dictionary;

+ (void)removeUserLocalToken;

//判断是否是偶数
+ (BOOL)evenNumberWithNumber:(NSInteger)number;

/**
 *  自动消失的提示弹出框
 *
 *  @param message msg
 */
+(void)showMessage:(NSString *)message;
+(void)showMessage:(NSString *)message withEndBlock:(void(^)(void))endBlock;;

/**
 *  警告提示框
 *
 *  @param message msg
 */
+(void)showAlert:(NSString *)message;
+(void)showAlert:(NSString *)message withDoneBlock:(void(^)(void))doneBlock;

//画虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

//拨打电话
+ (void)callPhoneWithNumber:(NSString *)number;

//base64图片处理
+ (NSString *)base64ImageDataString:(UIImage *)photoImg;

@end
