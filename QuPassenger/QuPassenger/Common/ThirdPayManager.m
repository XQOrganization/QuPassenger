//
//  ThirdPayManager.m
//  FreshFood
//
//  Created by 朱青 on 2017/8/3.
//  Copyright © 2017年 FreshFood. All rights reserved.
//

#import "ThirdPayManager.h"

@implementation ThirdPayManager

+ (ThirdPayManager *)shareManager
{
    static dispatch_once_t pred;
    static ThirdPayManager *shared = nil;
    dispatch_once(&pred, ^{
   
        shared = [[self alloc]init];
    });
    return shared;
}

- (void)registerThiryPay
{
    [WXApi registerApp:@"wx3656e76d96da3696"];
}

- (void)sendThirdPayWithReq:(id)payModel success:(void (^)(void))paySuccessBlock fail:(void (^)(void))payFailBlock
{
    self.paySuccessBlock = paySuccessBlock;
    self.payFailBlock = payFailBlock;
    
    WXPayModel *pay = (WXPayModel *)payModel;
    
    PayReq *request = [[PayReq alloc]init];
    request.partnerId = pay.partnerid;
    request.prepayId = pay.prepayid;
    request.package = pay.package;
    request.nonceStr = pay.noncestr;
    request.timeStamp = pay.timestamp;
    request.sign = pay.sign;
    [WXApi sendReq:request];
}

@end
