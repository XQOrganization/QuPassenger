//
//  LocalDataModel.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/8/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLineModel : NSObject

@property (nonatomic, retain)NSString *icon;
@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *subTitle;

@property (nonatomic, retain)NSString *badgeKey;

@end

@interface LocalDataModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *titleColorString;
@property (strong, nonatomic) NSString *priceColorString;
@property (assign, nonatomic) NSInteger bottomLine;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat width;
@property (strong, nonatomic) NSString *sign;

//订单结算数据
+ (NSMutableArray *)arrayForOrderPriceData;

//商品详情数据
+ (NSMutableArray *)arrayForGoodsDetailData;

//订单标签
+ (NSMutableArray *)arrayForOrderSignData;

//切换的订单类型
+ (NSMutableArray *)arrayForCreateOrderPriceData;

//充值模块
+ (NSMutableArray *)arrayForMainRecharge;

//个人中心模块
+ (NSMutableDictionary *)userLineMaterialDic;
+ (NSMutableDictionary *)userIconMaterialDic;

//普票申请模块
+ (NSMutableArray *)arrayForGeneralInvoice;
//专票申请模块
+ (NSMutableArray *)arrayForSpecialInvoice;

@end
