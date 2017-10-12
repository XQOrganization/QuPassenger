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

        if ([response.code isEqualToString:@"1"]) {
            responseBlock(responseObject);
  
        }
        else if ([response.code isEqualToString:@"1001"]){
            //预留token过期处理

        }
        else{
            errorBlock(response.message);
        }
    } withFailureBlock:errorBlock progress:nil];
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
   
    [NetWorkEngine requestWithType:HttpRequestTypePost withUrlString:XQApiNameEnum(apiName) withParaments:muParams withSuccessBlock:^(NSDictionary *responseObject) {
        NSLog(@"返回数据:%@",responseObject);
        BaseResponse *response = [BaseResponse mj_objectWithKeyValues:responseObject];
        
        if ([response.code isEqualToString:@"1"]) {
            responseBlock(responseObject);
            
        }
        else if ([response.code isEqualToString:@"1001"]){
            //预留token过期处理

        }
        else{
            errorBlock(response.message);
        }
    } withFailureBlock:errorBlock progress:nil];
}

@end
