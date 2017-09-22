//
//  ThirdApiManager.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/22.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdApiManager : NSObject

@property (copy, nonatomic) void (^thirdPaySuccessBlock)(void);
@property (copy, nonatomic) void (^thirdPayFailBlock)(void);

+ (ThirdApiManager *)shareManager;

//注册第三方key
- (void)registerThirdApi;

//发送第三方支付
- (void)sendThirdPayWithReq:(id)payModel success:(void (^)(void))paySuccessBlock fail:(void (^)(void))payFailBlock;

//第三方授权登录
- (void)getThirdUserInfoCompletion:(void (^)(NSString *uid))userBlock;

@end
