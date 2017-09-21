//
//  LocalDataModel.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/8/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "LocalDataModel.h"



@implementation UserLineModel

@end

@implementation LocalDataModel

+ (NSMutableArray *)arrayForOrderPriceData
{
    NSArray *nameArray = @[@"商品总金额",@"促销优惠",@"商品结算金额",@"优惠券抵扣",@"积分抵扣",@"订单运费",@"订单冻结金额",@"订单结算金额"];
    NSArray *priceArray = @[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0"];
    NSArray *priceColorArray = @[@"999999",@"ff0000",@"ff0000",@"ff0000",@"ff0000",@"ff0000",@"999999",@"ff0000"];
    NSArray *titleColorArray = @[@"999999",@"999999",@"666666",@"999999",@"999999",@"999999",@"999999",@"666666"];
    NSArray *lineArray = @[@"0",@"0",@"0",@"0",@"0",@"1",@"0",@"0"];
   
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:8];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.title = [nameArray objectAtIndex:i];
        firstModel.price = [priceArray objectAtIndex:i];
        firstModel.titleColorString = [titleColorArray objectAtIndex:i];
        firstModel.priceColorString = [priceColorArray objectAtIndex:i];
        firstModel.bottomLine = [lineArray[i] integerValue];
        [firstArray addObject:firstModel];
    }
    
    
    return firstArray;
    
}

//商品详情数据
+ (NSMutableArray *)arrayForGoodsDetailData
{
    NSArray *nameArray = @[@"商品编号：",@"商品规格：",@"商品产地：",@"商品品牌：",@"商品存储："];
    NSArray *priceArray = @[@"",@"",@"",@"",@""];
    NSArray *priceColorArray = @[@"333333",@"333333",@"333333",@"333333",@"333333"];
    NSArray *titleColorArray = @[@"999999",@"999999",@"999999",@"999999",@"999999"];
    NSArray *lineArray = @[@"0",@"0",@"0",@"0",@"0",@"1",@"0",@"0"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:8];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.title = [nameArray objectAtIndex:i];
        firstModel.price = [priceArray objectAtIndex:i];
        firstModel.titleColorString = [titleColorArray objectAtIndex:i];
        firstModel.priceColorString = [priceColorArray objectAtIndex:i];
        firstModel.bottomLine = [lineArray[i] integerValue];
        [firstArray addObject:firstModel];
    }
    return firstArray;

}

+ (NSMutableArray *)arrayForOrderSignData
{
    NSArray *nameArray = @[@"很赞",@"还会买",@"推荐",@"一般般",@"还可以",@"+"];
    NSArray *lineArray = @[@"0",@"0",@"0",@"0",@"0",@"0"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:8];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.title = [nameArray objectAtIndex:i];

        firstModel.bottomLine = [lineArray[i] integerValue];
        [firstArray addObject:firstModel];
    }
    return firstArray;
}

+ (NSMutableArray *)arrayForCreateOrderPriceData;
{
    NSArray *nameArray = @[@"商品金额",@"优惠券折扣",@"积分折扣",@"其他优惠",@"订单运费",@"备注信息"];
    NSArray *priceArray = @[@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@""];
    NSArray *priceColorArray = @[@"ff0000",@"ff0000",@"ff0000",@"ff0000",@"ff0000",@"ff0000"];
    NSArray *titleColorArray = @[@"666666",@"666666",@"666666",@"666666",@"666666",@"666666"];
    NSArray *lineArray = @[@"0",@"0",@"0",@"0",@"0",@"0"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:8];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.title = [nameArray objectAtIndex:i];
        firstModel.price = [priceArray objectAtIndex:i];
        firstModel.titleColorString = [titleColorArray objectAtIndex:i];
        firstModel.priceColorString = [priceColorArray objectAtIndex:i];
        firstModel.bottomLine = [lineArray[i] integerValue];
        [firstArray addObject:firstModel];
    }
    
    
    return firstArray;
}

+ (NSMutableArray *)arrayForMainRecharge
{
    NSArray *firstNameArray = @[@"100",@"300",@"500",@"1000"];
    NSArray *firstImageArray = @[@"100",@"300",@"500",@"1000"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:4];
    
    for (NSInteger i = 0; i < firstNameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.title = [firstNameArray objectAtIndex:i];
        firstModel.price = firstImageArray[i];
        [firstArray addObject:firstModel];
    }
    
    return firstArray;

}

+ (NSMutableArray *)arrayForGeneralInvoice
{
    NSArray *nameArray = @[@"发票金额"];
    NSArray *priceArray = @[@"0"];
    NSArray *lineArray = @[@"1"];
    NSArray *signArray = @[@"fpje"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:1];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.title = [nameArray objectAtIndex:i];
        firstModel.price = [priceArray objectAtIndex:i];
        firstModel.sign = [signArray objectAtIndex:i];
        firstModel.bottomLine = [lineArray[i] integerValue];
        [firstArray addObject:firstModel];
    }
    
    
    return firstArray;
}

+ (NSMutableArray *)arrayForSpecialInvoice
{
    NSArray *nameArray = @[@"单位名称*",@"纳税人编号",@"单位地址",@"单位电话",@"开户银行",@"银行账号",@"发票金额"];
    NSArray *priceArray = @[@"请填写单位名称",@"纳税人识别号或统一社会信用代码",@"公司注册地址",@"区号+固定电话",@"公司开户银行",@"公司开户银行账号",@"0"];
    NSArray *signArray = @[@"dwmc",@"nsrbh",@"dwdz",@"dwdh",@"khyy",@"yhzz",@"fpje"];
    NSArray *lineArray = @[@"0",@"0",@"0",@"0",@"0",@"0",@"1"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:7];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.title = [nameArray objectAtIndex:i];
        firstModel.price = [priceArray objectAtIndex:i];
        firstModel.sign = [signArray objectAtIndex:i];
        firstModel.bottomLine = [lineArray[i] integerValue];
        [firstArray addObject:firstModel];
    }
    
    
    return firstArray;
}


+ (NSMutableDictionary *)userLineMaterialDic
{
    NSMutableDictionary *userLineMaterialDic = [NSMutableDictionary new];
    UserLineModel *model = [UserLineModel new];
    model.icon = @"user_cell_order_icon";
    model.title = @"我的订单";
    model.subTitle = @"查看全部订单";
    [userLineMaterialDic setObject:model forKey:@"1"];
    
    model = [UserLineModel new];
    model.icon = @"user_cell_account_icon";
    model.title = @"我的资产";
    model.subTitle = @"查看余额明细";
    [userLineMaterialDic setObject:model forKey:@"3"];
    
    UserLineModel *model1 = [UserLineModel new];
    model1.icon = @"user_cell_set_icon";
    model1.title = @"账号设置";
    model1.subTitle = @"头像、昵称、密码修改";
    
    UserLineModel *model2 = [UserLineModel new];
    model2.icon = @"user_cell_adress_icon";
    model2.title = @"收货地址";
    model2.subTitle = @"自提点、收货地址管理";
    
    UserLineModel *model3 = [UserLineModel new];
    model3.icon = @"user_cell_receipt_icon";
    model3.title = @"发票申请";
    model3.subTitle = @"购物发票申请";
    [userLineMaterialDic setObject:@[model1,model2,model3] forKey:@"6"];
    
    model1 = [UserLineModel new];
    model1.icon = @"user_cell_service_icon";
    model1.title = @"在线客服";
    model1.subTitle = @"让我们心与心的交流";
    
    model2 = [UserLineModel new];
    model2.icon = @"user_cell_info_icon";
    model2.title = @"关于我们";
    model2.subTitle = @"关于蔬绿生鲜";
    
    [userLineMaterialDic setObject:@[model1,model2] forKey:@"7"];
    return userLineMaterialDic;
}

+ (NSMutableDictionary *)userIconMaterialDic
{
    NSMutableDictionary *userIconMaterialDic = [NSMutableDictionary new];
    UserLineModel *model1 = [UserLineModel new];
    model1.icon = @"user_cell_delivery_icon";
    model1.title = @"待配送";
    model1.badgeKey = @"dps";
    
    UserLineModel *model2 = [UserLineModel new];
    model2.icon = @"user_cell_pickup_icon";
    model2.title = @"待自提";
    model2.badgeKey = @"dzt";
    
    UserLineModel *model3 = [UserLineModel new];
    model3.icon = @"user_cell_comment_icon";
    model3.title = @"待评价";
    model3.badgeKey = @"dpj";
    
    UserLineModel *model4 = [UserLineModel new];
    model4.icon = @"user_cell_return_icon";
    model4.title = @"轻松退";
    model4.badgeKey = @"qst";
    [userIconMaterialDic setObject:@[model1,model2,model3,model4] forKey:@"2"];
    
    model1 = [UserLineModel new];
    model1.icon = @"user_cell_coupon_icon";
    model1.title = @"优惠券";
    model1.badgeKey = @"yhq";
    
    model2 = [UserLineModel new];
    model2.icon = @"user_cell_points_icon";
    model2.title = @"积分";
    model2.badgeKey = @"";
    
    model3 = [UserLineModel new];
    model3.icon = @"user_cell_balance_icon";
    model3.title = @"余额";
    model3.badgeKey = @"";
    
    model4 = [UserLineModel new];
    model4.icon = @"user_cell_recharge_icon";
    model4.title = @"充值";
    model4.badgeKey = @"";
    
    [userIconMaterialDic setObject:@[model1,model2,model3,model4] forKey:@"5"];
    
    return userIconMaterialDic;
}

@end
