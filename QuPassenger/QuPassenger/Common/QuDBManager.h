//
//  QuDBManager.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/30.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>

@interface QuDBManager : NSObject

@property (strong, nonatomic) FMDatabase *db;
@property (strong, nonatomic) NSString *dbPath;
@property (strong, nonatomic) FMDatabaseQueue *queue;

+ (QuDBManager *)shareDataManger;

//获取可支持的城市
- (NSMutableArray *)getTheCityAreaCodeWithProvinceCode:(NSString *)provinceCode;

@end
