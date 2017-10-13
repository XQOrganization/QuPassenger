//
//  QuDBManager.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/30.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "QuDBManager.h"
#import "QuCityModel.h"

#define CITY_SELECT_DB @"City.db"

#define CITY_SELECT_TABLE @"CityChangeInfo"
#define PROVINCE_SELECT_TABLE @"ProvinceCodeInfo"
#define DBVERSION_Table @"DBVersionInfo"

@implementation QuDBManager

+ (QuDBManager *)shareDataManger
{
    static dispatch_once_t onceToken;
    static QuDBManager *dataManger;
    
    dispatch_once(&onceToken, ^{
        dataManger = [[QuDBManager alloc] init];
        
    });
    
    return dataManger;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        [self initDataBase];
    }
    
    return self;
}

- (void)initDataBase{
    if (!_db) {
        _db = nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSString *fileDB = CITY_SELECT_DB;
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *pathAry = [fileDB componentsSeparatedByString:@"."];
    
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:[pathAry objectAtIndex:0] ofType:[pathAry objectAtIndex:1]];
    self.dbPath = [documentPath stringByAppendingPathComponent:fileDB];
    NSString *dbVersion = [self getDBVerisonFromSourceDBPath:self.dbPath];
    NSString *bundleDbVersion = [self getDBVerisonFromBundleDBPath:CITY_SELECT_DB];
    
    if (![dbVersion isEqualToString:bundleDbVersion]) {
        
        
        if (![fileManager removeItemAtPath:_dbPath error:&error]) {
            NSLog(@"%@",[error localizedDescription])
            ;
            
        }
        else{
            if (![fileManager copyItemAtPath:sourcePath toPath:_dbPath error:&error]) {
                NSLog(@"%@",[error localizedDescription]);
                
            }
            else{
                
                _db = [FMDatabase databaseWithPath:_dbPath];
                
                
            }
            NSLog(@"database copy.....");
            
        }
        
    }
    if (!_queue) {
        _queue = [[FMDatabaseQueue alloc]initWithPath:_dbPath];
    }
 
}

#pragma 获取document数据库的版本号
- (NSString *)getDBVerisonFromSourceDBPath:(NSString *)sourcePath{
    @synchronized(self){
        _db = [FMDatabase databaseWithPath:sourcePath];
        
        if (![_db open]){
            NSLog(@"==<open database error!>==");
        }
        NSString *dbVersion= @"";
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ",DBVERSION_Table];
        FMResultSet *rs = [_db executeQuery:sql];
        while ([rs next]) {
            dbVersion = [rs stringForColumn:@"dbVersion"];//region_code
        }
        [rs close];
        [self.db close];
        return dbVersion;
    }
}
#pragma 获取bundle数据库的版本号
- (NSString *)getDBVerisonFromBundleDBPath:(NSString *)fileDB{
    @synchronized(self){
        NSArray *pathAry = [fileDB componentsSeparatedByString:@"."];
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:[pathAry objectAtIndex:0] ofType:[pathAry objectAtIndex:1]];
        _db = [FMDatabase databaseWithPath:sourcePath];
        
        if (![_db open]){
            NSLog(@"==<open database error!>==");
        }
        
        NSString *dbVersion= @"";
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ",DBVERSION_Table];
        
        FMResultSet *rs = [_db executeQuery:sql];
        while ([rs next]) {
            dbVersion = [rs stringForColumn:@"dbVersion"];//region_code
        }
        [rs close];
        [self.db close];
        return dbVersion;
    }
}

#pragma mark CITY_SELECT_TABLE
- (NSMutableArray *)getTheCityAreaCodeWithProvinceCode:(NSString *)provinceCode
{
    @synchronized(self){
        [self.db open];
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE isshow ='1' AND level='1' ORDER BY name_spell ASC",CITY_SELECT_TABLE];
        if (provinceCode.length > 0) {
            sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE isshow ='1' AND level='1' AND parent_region = '%@'",CITY_SELECT_TABLE,provinceCode];
        }
        
        [self.queue inDatabase:^(FMDatabase *db){
            FMResultSet *rs = [db executeQuery:sql];
            while ([rs next]) {
                QuCityModel *model = [[QuCityModel alloc]init];
                model.cityName   = [rs stringForColumn:@"city_name"];
                model.provinceCode = [rs stringForColumn:@"parent_region"];
                model.cityCode = [rs stringForColumn:@"region_code"];
           
                [dataArray addObject:model];
            }
            [rs close];
        }];
        [self.db close];

        return dataArray;
    }
}

- (NSString *)getTheProvinceCodeWithCityName:(NSString *)cityName
{
    @synchronized(self){
        [self.db open];
        __block NSString *provinceCode= @"";
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE city_name='%@'",CITY_SELECT_TABLE,cityName];
        [self.queue inDatabase:^(FMDatabase *db){
            FMResultSet *rs = [db executeQuery:sql];
            while ([rs next]) {
                provinceCode = [rs stringForColumn:@"parent_region"];//region_code
            }
            [rs close];
        }];
        [self.db close];
        return provinceCode;
    }
}

- (NSString *)getTheCityCodeWithCityName:(NSString *) cityName
{
    @synchronized(self){
        [self.db open];
        __block NSString *provinceCode= @"";
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE city_name='%@'",CITY_SELECT_TABLE,cityName];
        [self.queue inDatabase:^(FMDatabase *db){
            FMResultSet *rs = [db executeQuery:sql];
            while ([rs next]) {
                provinceCode = [rs stringForColumn:@"region_code"];//region_code
            }
            [rs close];
        }];
        [self.db close];
        return provinceCode;
    }
    
}

@end
