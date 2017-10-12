//
//  PublicManager.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/8/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuCityModel.h"

float HeightForString(NSString *value,float fontSize,float width);
float WidthForString(NSString *value,float fontSize,float height);

@interface PublicManager : NSObject

@property (strong, nonatomic) QuCityModel *cityModel;

+ (PublicManager *)shareManager;

//+ (NSDictionary *)getMainDataFromLocal;
//
//+ (void)saveMainDataToLocalWithDictionary:(NSDictionary *)dictionary;
//
//+ (void)removeUserLocalToken;
//获取设备号
+ (NSString *)getDeviceId;

//判断是否是偶数
+ (BOOL)evenNumberWithNumber:(NSInteger)number;


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

+ (NSString *)getFullPinyinString:(NSString *)str;
+ (NSString *)getFirsrPingyinString:(NSString *)str;

@end
