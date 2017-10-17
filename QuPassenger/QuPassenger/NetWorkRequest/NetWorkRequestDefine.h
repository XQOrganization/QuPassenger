//
//  NetWorkRequestDefine.h
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <Foundation/Foundation.h>

//接口名
typedef NS_ENUM(NSInteger,XQApiName) {
    getCode,          //获取验证码
    checkCode,        //验证码登录
    bindWeChat,       //微信登录
    checkWeChatCode,       //微信绑定手机号
    autoLand,       //自动登录
    getCity,        //获取城市
    openCityData,   //首页
    siteMatch,//获取附近站点
    getFighting,//匹配线路获取班次
    
};
NSString *XQApiNameEnum(XQApiName name);

@interface NetWorkRequestDefine : NSObject

@end
