//
//  AccountInfo.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/21.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "AccountInfo.h"

@implementation AccountInfo

+ (AccountInfo *)shareRsp
{
    static dispatch_once_t pred;
    static AccountInfo *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[self alloc]init];
        shared.isLogin = YES;
        
    });
    return shared;
}


@end
