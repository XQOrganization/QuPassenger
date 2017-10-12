//
//  NetWorkRequestModel.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkRequestModel : NSObject

@end

@interface BaseRequest : NSObject

@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSString *channelNo;

@end

@interface BaseResponse : NSObject

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *code;

@end

@interface GetCodeReq : BaseRequest

@property (strong, nonatomic) NSString *phone;

@end

@interface GetCodeRsp : BaseResponse

@end

@interface CheckCodeReq : BaseRequest

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *device;

@end

@interface QuUserInfo : NSObject

@property (strong, nonatomic) NSString *memberID;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *weixinCode;
@property (strong, nonatomic) NSString *idCard;

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *headImg;
@property (strong, nonatomic) NSString *travelNum;
@property (strong, nonatomic) NSString *cancelNum;
@property (strong, nonatomic) NSString *status;

@property (strong, nonatomic) NSString *device;
@property (strong, nonatomic) NSString *upTime;
@property (strong, nonatomic) NSString *downTime;
@property (strong, nonatomic) NSString *linkName;
@property (strong, nonatomic) NSString *linkMobile;
@property (strong, nonatomic) NSString *balance;
@property (strong, nonatomic) NSString *dateOfBrith;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *sign;
@property (strong, nonatomic) NSString *dt;

@end

@interface CheckCodeRsp : BaseResponse

@property (strong, nonatomic) QuUserInfo *data;

@end

@interface MainReq : BaseRequest

@end

@interface MainRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *data_bottom;
@property (strong, nonatomic) NSArray *data_floor;
@property (strong, nonatomic) NSArray *data_xsqg;
@property (strong, nonatomic) NSArray *small_pic;

@end

@interface MainSmallModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *t_id;

@end

@interface MainBannerModel : NSObject

@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *t_id;
@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *name;

@end

@interface MainBuyModel : NSObject

@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *shang_date;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *xia_date;
@property (strong, nonatomic) NSString *start_surplus_time;
@property (strong, nonatomic) NSString *end_surplus_time;

@end

@interface MainFloorModel : NSObject

@property (strong, nonatomic) NSString *t_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSArray *toppic_data;
@property (strong, nonatomic) NSArray *goods_data;

@end
