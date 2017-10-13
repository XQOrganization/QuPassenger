//
//  NetWorkRequestModel.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "NetWorkRequestModel.h"

@implementation NetWorkRequestModel

@end

@implementation BaseRequest

- (id)init
{
    if (self = [super init]) {

        self.versionNo = CLIENT_VERSION;
        self.channelNo = @"iOS";
        self.device = [PublicManager getDeviceId];

    }
    return self;
    
}

@end

@implementation BaseResponse

@end

@implementation GetCodeReq


@end

@implementation CheckCodeReq


@end

@implementation QuUserInfo


@end

@implementation CheckCodeRsp


@end

@implementation BindWeChatReq


@end

@implementation BindWeChatRsp


@end

@implementation CheckWeChatCodeReq


@end

@implementation CheckWeChatCodeRsp


@end

@implementation MainReq

@end

@implementation MainRsp

- (id)init{
    if (self = [super init]) {
        [MainRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"MainBannerModel",
                     @"data_bottom" : @"MainBannerModel",
                     @"data_floor" : @"MainFloorModel",
                     @"data_xsqg" : @"MainBuyModel",
                     @"small_pic" : @"MainSmallModel"};
        }];
    }
    return self;
}

@end

@implementation MainSmallModel



@end

@implementation MainBannerModel



@end

@implementation MainBuyModel



@end

@implementation MainFloorModel

- (id)init{
    if (self = [super init]) {
        [MainFloorModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"toppic_data" : @"MainBannerModel",
                     @"goods_data" : @"MainBannerModel"};
        }];
    }
    return self;
}

@end
