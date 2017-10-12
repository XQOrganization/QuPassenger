//
//  LgoinAPI.h
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/12.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LgoinAPI : NSObject
+ (void)loginGetCode:(NSString *)phone success:(void(^)(NSString *message))success falie:(void(^)(NSString *message))falie;

@end
