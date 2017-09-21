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
    Get_token,          //token获取
    
};
NSString *XQApiNameEnum(XQApiName name);

@interface NetWorkRequestDefine : NSObject

@end
