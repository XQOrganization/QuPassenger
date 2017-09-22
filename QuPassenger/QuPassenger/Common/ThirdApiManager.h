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

- (void)registerThirdApi;
- (void)sendThirdPayWithReq:(id)payModel success:(void (^)(void))paySuccessBlock fail:(void (^)(void))payFailBlock;

@end
