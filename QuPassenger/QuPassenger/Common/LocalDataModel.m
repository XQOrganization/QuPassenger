//
//  LocalDataModel.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/8/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "LocalDataModel.h"

@implementation LocalDataModel

+ (NSMutableArray *)arrayForMainLeftCategory
{
    NSArray *nameArray = @[@"行程",@"钱包",@"客服",@"设置"];
    NSArray *signArray = @[@"main_xch_icon",@"main_bdrzh_icon",@"main_gywm_icon",@"main_szh_icon"];
    NSArray *lineArray = @[@"0",@"1",@"2",@"3"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:7];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.name = [nameArray objectAtIndex:i];
        firstModel.imageName = [signArray objectAtIndex:i];
        firstModel.sign = [lineArray[i] integerValue];
        [firstArray addObject:firstModel];
    }
    
    
    return firstArray;
}

@end
