//
//  ThirdApiManager.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/22.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "ThirdApiManager.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
////微信SDK头文件
//#import "WXApi.h"

@implementation ThirdApiManager

+ (ThirdApiManager *)shareManager
{
    static dispatch_once_t pred;
    static ThirdApiManager *shared = nil;
    dispatch_once(&pred, ^{
        
        shared = [[self alloc]init];
    });
    return shared;
}

- (void)registerThirdApi
{
    
//    [ShareSDK registerApp:@"" activePlatforms:@[@(SSDKPlatformTypeWechat)]
//                             onImport:^(SSDKPlatformType platformType) {
//                                 
//                                 switch (platformType)
//                                 {
//                                     case SSDKPlatformTypeWechat:
//                                         //                             [ShareSDKConnector connectWeChat:[WXApi class]];
//                                         [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
//                                         break;
//                                    default:
//                                         break;
//                                 }
//                             }
//                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//                          
//                          switch (platformType)
//                          {
//                              case SSDKPlatformTypeWechat:
//                                  [appInfo SSDKSetupWeChatByAppId:@"wx3656e76d96da3696"
//                                                        appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
//                                  break;
//                              default:
//                                  break;
//                          }
//                      }];

}

- (void)sendThirdPayWithReq:(id)payModel success:(void (^)(void))paySuccessBlock fail:(void (^)(void))payFailBlock
{
    self.thirdPaySuccessBlock = paySuccessBlock;
    self.thirdPayFailBlock = payFailBlock;
    
    WXPayModel *pay = (WXPayModel *)payModel;
    
//    PayReq *request = [[PayReq alloc]init];
//    request.partnerId = pay.partnerid;
//    request.prepayId = pay.prepayid;
//    request.package = pay.package;
//    request.nonceStr = pay.noncestr;
//    request.timeStamp = pay.timestamp;
//    request.sign = pay.sign;
//    [WXApi sendReq:request];
}


@end
