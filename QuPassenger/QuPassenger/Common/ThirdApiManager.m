//
//  ThirdApiManager.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/22.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "ThirdApiManager.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//微信SDK头文件
#import "WXApi.h"
#import "UMMobClick/MobClick.h"

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
    //tentcent map
    [QMapServices sharedServices].apiKey = @"EGOBZ-LH43U-YATVV-BJQSB-XIFCH-47FNS";
    [[QMSSearchServices sharedServices] setApiKey:@"EGOBZ-LH43U-YATVV-BJQSB-XIFCH-47FNS"];
    
    //Umeng
    UMConfigInstance.appKey = @"59c4baffc62dca631400014d";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK
    
    //ShareSdk
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeWechat)]
                             onImport:^(SSDKPlatformType platformType) {
                                 
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeWechat:
                                         //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                                         [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                                         break;
                                    default:
                                         break;
                                 }
                             }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                          
                          switch (platformType)
                          {
                              case SSDKPlatformTypeWechat:
                                  [appInfo SSDKSetupWeChatByAppId:@"wx369d283e29d7eb9a"
                                                        appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                                  break;
                              default:
                                  break;
                          }
                      }];

}

- (void)getThirdUserInfoCompletion:(void (^)(NSString *uid))userBlock
{
    if ([ShareSDK hasAuthorized:SSDKPlatformTypeWechat]) {
        [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    }
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        
        if (state == SSDKResponseStateSuccess){
            
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",user.credential);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickname=%@",user.nickname);
            if (userBlock) {
                userBlock(user.uid);
            }
        }
        else{
            NSLog(@"%@",error);
        }
    }];
}

- (void)sendThirdPayWithReq:(id)payModel success:(void (^)(void))paySuccessBlock fail:(void (^)(void))payFailBlock
{
    self.thirdPaySuccessBlock = paySuccessBlock;
    self.thirdPayFailBlock = payFailBlock;
    
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
