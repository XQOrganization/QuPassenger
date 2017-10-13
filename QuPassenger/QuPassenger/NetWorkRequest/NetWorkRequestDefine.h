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
    
};
NSString *XQApiNameEnum(XQApiName name);

@interface NetWorkRequestDefine : NSObject

@end
