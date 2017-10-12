//
//  LgoinAPI.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/12.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "LgoinAPI.h"
#import <AFNetworking.h>
@implementation LgoinAPI
+ (void)loginGetCode:(NSString *)phone success:(void(^)(NSString *message))success falie:(void(^)(NSString *message))falie{
    AFHTTPSessionManager *mangager = [AFHTTPSessionManager manager];
    NSString *url =[NSString stringWithFormat:@"http://192.168.1.122:8081/api/code/getCode?phone=%@",phone];
 
    [mangager GET:url parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falie(error.debugDescription);
        
    }];
    
    
}
@end
