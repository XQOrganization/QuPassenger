//
//  BaseNetWorkRequest.m
//  FreshFood
//
//  Created by 朱青 on 2017/7/24.
//  Copyright © 2017年 FreshFood. All rights reserved.
//

#import "NetWorkReqManager.h"

@implementation NetWorkReqManager

- (instancetype)initWithApiName:(XQApiName)apiName params:(id)params
{
    _apiName = apiName;
    _params = params;
    _tokenRequestCount = 1;
    return [self init];
}

- (void)postRequestWithResponse:(requestSuccess)responseBlock errorResponse:(requestFailure)errorBlock
{
    NSMutableDictionary *muParams;
    if (self.params) {
        if ([self.params isKindOfClass:[NSDictionary class]]) {
            muParams = [NSMutableDictionary dictionaryWithDictionary:self.params];
        }
        else{
            NSDictionary *dic = [self.params mj_keyValues];
            muParams = [NSMutableDictionary dictionaryWithDictionary:dic];
        }
    }
    else{
        muParams = [NSMutableDictionary new];
    }
    [muParams setObject:XQApiNameEnum(self.apiName) forKey:@"F_type"];
    if (ACCOUNTINFO.token.length > 0) {
        [muParams setObject:ACCOUNTINFO.token forKey:@"token"];
    }
    [NetWorkEngine requestWithType:HttpRequestTypePost withUrlString:@"" withParaments:muParams withSuccessBlock:^(NSDictionary *responseObject) {
        NSLog(@"返回数据:%@",responseObject);
        BaseResponse *response = [BaseResponse mj_objectWithKeyValues:responseObject];

        if ([response.code isEqualToString:@"1000"]) {
            responseBlock(responseObject);
  
        }
        else if ([response.code isEqualToString:@"1001"]){
            ACCOUNTINFO.token = @"";
            [NetWorkReqManager getTokenRequestWithResponse:^(NSDictionary *responseObject) {
                //重新获取token后需要重新请求一次接口
                [self postRequestWithResponse:responseBlock errorResponse:errorBlock];
            }];
        }
        else{
            errorBlock(response.message);
        }
    } withFailureBlock:errorBlock progress:nil];
}

//获取token
+ (void)getTokenRequestWithResponse:(requestSuccess)responseBlock{
    
    if (ACCOUNTINFO.token.length > 0) {
        responseBlock(@{@"token":ACCOUNTINFO.token});
    }
    else{
 
        [NetWorkEngine requestWithType:HttpRequestTypePost withUrlString:@"" withParaments:@{@"secret":@"9417cb1c5b9280d778a2b513fbc236ef",@"appid":@"shop215500",@"F_type":@"Get_token"} withSuccessBlock:^(NSDictionary *responseObject) {
            
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:responseObject];
            if ([response.code isEqualToString:@"1000"]) {
                NSString *toke = responseObject[@"token"];
                ACCOUNTINFO.token = toke;
                if (responseBlock) {
                    responseBlock(responseObject);
                }
            }
         
        } withFailureBlock:^(NSString *error) {
            //token 获取失败处理
            
        } progress:nil];
    }
}


+ (void)requestDataWithApiName:(XQApiName)apiName params:(id)params response:(requestSuccess)responseBlock errorResponse:(requestFailure)errorBlock
{
    NSMutableDictionary *muParams;
    if (params) {
        if ([params isKindOfClass:[NSDictionary class]]) {
            muParams = [NSMutableDictionary dictionaryWithDictionary:params];
        }
        else{
            NSDictionary *dic = [params mj_keyValues];
            muParams = [NSMutableDictionary dictionaryWithDictionary:dic];
        }
    }
    else{
        muParams = [NSMutableDictionary new];
    }
    [muParams setObject:XQApiNameEnum(apiName) forKey:@"F_type"];
    if (ACCOUNTINFO.token.length > 0) {
        [muParams setObject:ACCOUNTINFO.token forKey:@"token"];
    }
    [NetWorkEngine requestWithType:HttpRequestTypePost withUrlString:@"" withParaments:muParams withSuccessBlock:responseBlock withFailureBlock:errorBlock progress:nil];
}

@end
