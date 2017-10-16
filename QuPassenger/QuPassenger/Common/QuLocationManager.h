//
//  QuLocationManager.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/28.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentLBS/TencentLBS.h>

@interface QuLocationManager : NSObject

@property (strong, nonatomic) TencentLBSLocation *lbsLocation;
@property (copy, nonatomic) void(^locationSuccessBlock)(TencentLBSLocation *lbsLocation);
@property (copy, nonatomic) void(^locationFailBlock)(void);

@property (strong, nonatomic) QuCityModel *locationCityModel;
@property (assign, nonatomic) BOOL isLocating;//正在定位中
@property (strong, nonatomic) NSString *latitude;//纬度
@property (strong, nonatomic) NSString *longitude;//经度

+ (QuLocationManager *)shareManager;

- (void)startUpdatingLocationWithSuccess:(void(^)(TencentLBSLocation *lbsLocation))successBlock fail:(void(^)(void))failBlock;

@end
