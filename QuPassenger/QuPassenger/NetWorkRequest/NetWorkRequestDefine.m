//
//  NetWorkRequestDefine.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "NetWorkRequestDefine.h"

NSString *XQApiNameEnum(XQApiName name)
{
    switch (name) {
        case getCode:return @"getCode";
            break;
        case checkCode:return @"checkCode";
            break;
        default:return @"";
            break;
    }
}

@implementation NetWorkRequestDefine

@end
