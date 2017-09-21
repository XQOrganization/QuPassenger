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

        self.token = ACCOUNTINFO.token;


    }
    return self;
    
}

@end

@implementation BaseResponse

- (id)valueForUndefinedKey:(NSString *)key;
{
    return @"";
}


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

@implementation TimeBuyReq



@end

@implementation TimeBuyRsp

- (id)init{
    if (self = [super init]) {
        [TimeBuyRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"TimeBuyModel"};
        }];
    }
    return self;
}

@end

@implementation TimeBuyModel



@end

@implementation GoodsListReq



@end

@implementation GoodsListRsp



@end

@implementation GoodsListData

- (id)init{
    if (self = [super init]) {
        [GoodsListData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"GoodsListModel"};
        }];
    }
    return self;
}

@end

@implementation GoodsListModel



@end

@implementation GoodsDetailReq



@end

@implementation GoodsDetailInfo



@end

@implementation GoodsTradedModel



@end

@implementation GoodsCommentModel



@end

@implementation GoodsDetailData

- (id)init{
    if (self = [super init]) {
        [GoodsDetailData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"traded_list" : @"GoodsTradedModel",
                     @"comment" : @"GoodsCommentModel"};
        }];
    }
    return self;
}

@end

@implementation GoodsDetailRsp



@end

@implementation GoodsCollectStatusReq



@end

@implementation GoodsCollectStatusRsp



@end

@implementation GoodsAddCollectReq



@end

@implementation CartNumberReq



@end

@implementation CartNumberRsp



@end

@implementation AddCartReq



@end

@implementation AddHistoryReq



@end

@implementation CommentListReq

@end

@implementation CommentListData

- (id)init{
    if (self = [super init]) {
        [CommentListData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"GoodsCommentModel"};
        }];
    }
    return self;
}

@end

@implementation CommentListRsp

@end

@implementation CartListReq

@end

@implementation CartGoodsModel

@end

@implementation CartExchangeItemModel

@end

@implementation CartExchangeModel

- (id)init{
    if (self = [super init]) {
        [CartExchangeModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"check_hg_data" : @"CartExchangeItemModel"};
        }];
    }
    return self;
}


@end

@implementation CartListRsp

- (id)init{
    if (self = [super init]) {
        [CartListRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods_list" : @"CartGoodsModel",
                     @"huangou_list" : @"CartExchangeModel"};
        }];
    }
    return self;
}

@end

@implementation EditCartReq

@end

@implementation SelectGoodsCartReq

@end

@implementation SelectAllCartReq

@end

@implementation CartCollectReq

@end

@implementation CartDeleteReq

@end

@implementation CartLikeReq

@end

@implementation CartLikeModel

@end
@implementation CartLikeRsp

- (id)init{
    if (self = [super init]) {
        [CartLikeRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"CartLikeModel"};
        }];
    }
    return self;
}

@end

@implementation ExchangeListReq

@end

@implementation ExchangeListModel

@end
@implementation ExchangeListRsp

- (id)init{
    if (self = [super init]) {
        [ExchangeListRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"ExchangeListModel"};
        }];
    }
    return self;
}

@end

@implementation SelectExchangeReq

@end

@implementation HistoryListReq

@end

@implementation HistoryListModel

@end

@implementation HistoryListData


- (id)init{
    if (self = [super init]) {
        [HistoryListData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"HistoryListModel"};
        }];
    }
    return self;
}

@end

@implementation HistoryListRsp


@end

@implementation ClearHistoryReq


@end

@implementation CouponListReq

@end

@implementation CouponListModel

@end

@implementation CouponListData


- (id)init{
    if (self = [super init]) {
        [CouponListData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"CouponListModel"};
        }];
    }
    return self;
}

@end

@implementation CouponListRsp


@end

@implementation OrderListReq

@end

@implementation OrderGoodsListModel

@end

@implementation OrderListModel

- (id)init{
    if (self = [super init]) {
        [OrderListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods" : @"OrderGoodsListModel"};
        }];
    }
    return self;
}

@end

@implementation OrderListData


- (id)init{
    if (self = [super init]) {
        [OrderListData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"OrderListModel"};
        }];
    }
    return self;
}

@end

@implementation OrderListRsp


@end

@implementation OrderDetailReq


@end

@implementation OrderDetailGoodsModel


@end

@implementation OrderDetailData

- (id)init{
    if (self = [super init]) {
        [OrderDetailData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods" : @"OrderDetailGoodsModel"};
        }];
    }
    return self;
}

@end

@implementation OrderDetailRsp


@end

@implementation RefundOrderListReq

@end

@implementation RefundOrderGoodsModel

@end

@implementation RefundOrderListModel

- (id)init{
    if (self = [super init]) {
        [RefundOrderListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"RefundOrderGoodsModel"};
        }];
    }
    return self;
}

@end

@implementation RefundOrderListRsp

- (id)init{
    if (self = [super init]) {
        [RefundOrderListRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"RefundOrderListModel"};
        }];
    }
    return self;
}


@end

@implementation HaveCommentListReq

@end

@implementation HaveCommentGoodsModel

@end

@implementation HaveCommentListModel

- (id)init{
    if (self = [super init]) {
        [HaveCommentListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"HaveCommentGoodsModel"};
        }];
    }
    return self;
}

@end

@implementation HaveCommentListRsp

- (id)init{
    if (self = [super init]) {
        [HaveCommentListRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"HaveCommentListModel"};
        }];
    }
    return self;
}


@end

@implementation CommitCommentReq

@end

@implementation ActivityListReq

@end

@implementation ActivityListModel

@end

@implementation ActivityListData


- (id)init{
    if (self = [super init]) {
        [ActivityListData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"ActivityListModel"};
        }];
    }
    return self;
}

@end

@implementation ActivityListRsp


@end

@implementation CheckOrderReq


@end

@implementation CheckOrderGoodsModel


@end

@implementation CheckOrderPayWayModel


@end

@implementation CheckOrderData

- (id)init{
    if (self = [super init]) {
        [CheckOrderData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods" : @"CheckOrderGoodsModel",
                     @"psfs_all" : @"CheckOrderPayWayModel"};
        }];
    }
    return self;
}

@end

@implementation CheckOrderRsp


@end

@implementation SendTimeReq

@end

@implementation SendTimeModel

@end

@implementation SendTimeRsp

- (id)init{
    if (self = [super init]) {
        [SendTimeRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"SendTimeModel"};
        }];
    }
    return self;
}

@end

@implementation SetSendTimeReq

@end

@implementation SetSendWayReq

@end

@implementation ChooseAddressReq

@end

@implementation SelectAreaReq

@end

@implementation SelectAreaModel

@end

@implementation SelectAreaRsp

- (id)init{
    if (self = [super init]) {
        [SelectAreaRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"SelectAreaModel"};
        }];
    }
    return self;
}

@end

@implementation SelectTownReq

@end

@implementation CreateOrderGoodsDetailReq

@end

@implementation CreateOrderGoodsDetailModel

@end

@implementation CreateOrderGoodsDetailRsp

- (id)init{
    if (self = [super init]) {
        [CreateOrderGoodsDetailRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"CreateOrderGoodsDetailModel"};
        }];
    }
    return self;
}

@end

@implementation SetPayWayReq

@end

@implementation SetBillReq

@end

@implementation SendScoreReq

@end

@implementation WXPayModel

@end

@implementation MainRechargeReq

@end

@implementation MainRechargeRsp

@end

@implementation OrderSubmitPayReq

@end

@implementation OrderWXPayRsp

@end

@implementation ContinuePayReq

@end

@implementation ContinuePayRsp

@end

@implementation CancelOrderReq

@end

@implementation SignMemberReq

@end

@implementation InvoiceMoneyReq

@end

@implementation InvoiceMoneyRsp

@end

@implementation InvoiceSubmitReq

@end

@implementation SpecialApplyReq

@end

@implementation SpecialApplyModel

@end

@implementation SpecialApplyRsp

- (id)init{
    if (self = [super init]) {
        [SpecialApplyRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"SpecialApplyModel"};
        }];
    }
    return self;
}

@end

@implementation FormBoardDownloadReq

@end

@implementation ChooseCompanyReq

@end

@implementation SendInvoiceAppliactionReq

@end
