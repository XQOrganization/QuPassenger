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

@property (strong, nonatomic) NSString *versionNo;
@property (strong, nonatomic) NSString *channelNo;
@property (strong, nonatomic) NSString *device;

@end

@interface BaseResponse : NSObject

@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) NSInteger code;

@end

//获取验证码
@interface GetCodeReq : BaseRequest

@property (strong, nonatomic) NSString *phone;
@property (assign, nonatomic) NSInteger type; //1:手机登陆 type 2:微信绑定

@end

//验证码登录
@interface CheckCodeReq : BaseRequest

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *code;


@end

@interface QuUserInfo : NSObject

@property (strong, nonatomic) NSString *memberID;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *weixinCode;
@property (strong, nonatomic) NSString *idCard;

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *phoneCode;
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

//微信登录
@interface BindWeChatReq : BaseRequest

@property (strong, nonatomic) NSString *winXinKey;
@property (strong, nonatomic) NSString *phone;

@end

@interface BindWeChatRsp : BaseResponse

@property (strong, nonatomic) QuUserInfo *data;

@end

//微信绑定手机号
@interface CheckWeChatCodeReq : BaseRequest

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *winXinKey;
@property (strong, nonatomic) NSString *nick;
@property (strong, nonatomic) NSString *headImage;
@property (strong, nonatomic) NSString *code;

@end

@interface CheckWeChatCodeRsp : BaseResponse

@property (strong, nonatomic) QuUserInfo *data;

@end

//自动登录
@interface AutoLoginReq : BaseRequest

@property (strong, nonatomic) NSString *userId;

@end

@interface AutoLoginRsp : BaseResponse

@property (strong, nonatomic) QuUserInfo *data;

@end

//获取城市
@interface GetCityReq : BaseRequest

@end

@interface GetCityRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *data1;

@end

@interface MainReq : BaseRequest

@property (strong, nonatomic) NSString *cityCode;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *lat;

@end

@interface MainRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *data1;
@property (assign, nonatomic) NSInteger isOpen;


@end

@interface MainBannerModel : NSObject

@property (strong, nonatomic) NSString *bannerUrl;

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

//MARK:-----检索附近地址
@interface SiteMatchReq : BaseRequest

@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *cityCode;
@property (strong, nonatomic) NSArray *searchStr;

@end
