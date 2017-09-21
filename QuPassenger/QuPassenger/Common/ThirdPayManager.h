//
//  ThirdPayManager.h
//  FreshFood
//
//  Created by 朱青 on 2017/8/3.
//  Copyright © 2017年 FreshFood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface ThirdPayManager : NSObject

@property (copy, nonatomic) void (^paySuccessBlock)(void);
@property (copy, nonatomic) void (^payFailBlock)(void);

+ (ThirdPayManager *)shareManager;

- (void)registerThiryPay;
- (void)sendThirdPayWithReq:(id)payModel success:(void (^)(void))paySuccessBlock fail:(void (^)(void))payFailBlock;

@end
