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
        case Get_token:return @"Get_token";
            break;
        default:return @"";
            break;
    }
}

@implementation NetWorkRequestDefine

@end
