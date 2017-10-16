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
        case getCode:return @"code/getCode";
            break;
        case checkCode:return @"code/checkCode";
            break;
        case bindWeChat:return @"code/bindWeChat";
            break;
        case checkWeChatCode:return @"code/checkWeChatCode";
            break;
        case autoLand:return @"code/autoLand";
            break;
        case getCity:return @"city/getCity";
            break;
        case openCityData:return @"city/openCityData";
            break;
        default:return @"";
            break;
    }
}

@implementation NetWorkRequestDefine

@end
