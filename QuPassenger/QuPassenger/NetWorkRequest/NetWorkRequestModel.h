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

@property (strong, nonatomic) NSString *token;

@end

@interface BaseResponse : NSObject

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *code;

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

@interface TimeBuyReq : BaseRequest

@end

@interface TimeBuyRsp : BaseResponse

@property (strong, nonatomic) NSString *e_date;
@property (strong, nonatomic) NSString *end_surplus_time;
@property (strong, nonatomic) NSString *s_date;
@property (strong, nonatomic) NSString *start_surplus_time;
@property (strong, nonatomic) NSArray *data;

@end

@interface TimeBuyModel : NSObject

@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *old_price;
@property (strong, nonatomic) NSString *tejia;
@property (strong, nonatomic) NSString *unit;

@end

@interface GoodsListReq : BaseRequest

@property (strong, nonatomic) NSString *ordery_id;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) NSString *keywords;
@property (strong, nonatomic) NSString *class_id;

@end

@interface GoodsListData : NSObject

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSString *nowpage;
@property (strong, nonatomic) NSString *pagesize;
@property (assign, nonatomic) NSInteger total;
@property (assign, nonatomic) NSInteger total_page;

@end

@interface GoodsListRsp : BaseResponse

@property (strong, nonatomic) GoodsListData *data;


@end


@interface GoodsListModel : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *oldprice;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *subtitle;

@end

@interface GoodsDetailReq : BaseRequest

@property (strong, nonatomic) NSString *goods_id;

@end

@interface GoodsDetailInfo : NSObject

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *no;
@property (strong, nonatomic) NSString *old_price;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *price1;
@property (strong, nonatomic) NSString *seler_num;
@property (strong, nonatomic) NSString *specifications;
@property (strong, nonatomic) NSString *storage;
@property (strong, nonatomic) NSString *t_id;
@property (strong, nonatomic) NSString *t_name;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *end_surplus_time;

@end

@interface GoodsDetailData : NSObject

@property (strong, nonatomic) NSArray *small_pics;
@property (strong, nonatomic) NSString *comment_mark;
@property (strong, nonatomic) NSString *comment_people;
@property (strong, nonatomic) NSArray *comment;
@property (strong, nonatomic) NSArray *traded_list;
@property (strong, nonatomic) NSArray *content_pics;
@property (strong, nonatomic) GoodsDetailInfo *info;

@end

@interface GoodsTradedModel : NSObject

@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *tags;
@property (strong, nonatomic) NSString *tags1;
@property (strong, nonatomic) NSString *tags2;

@end

@interface GoodsCommentModel : NSObject

@property (strong, nonatomic) NSString *date1;
@property (strong, nonatomic) NSString *mark;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSArray *picslist;
@property (strong, nonatomic) NSArray *taglist;
@property (strong, nonatomic) NSString *subject;

@end

@interface GoodsDetailRsp : BaseResponse

@property (strong, nonatomic) GoodsDetailData *data;


@end

@interface GoodsCollectStatusReq : BaseRequest

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface GoodsCollectStatusRsp : BaseResponse

@property (strong, nonatomic) NSString *is_collect;


@end

@interface GoodsAddCollectReq : BaseRequest

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *is_collect;
@property (strong, nonatomic) NSString *key;

@end

@interface CartNumberReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface CartNumberRsp : BaseResponse

@property (strong, nonatomic) NSString *cart_count_num;

@end

@interface AddCartReq : BaseRequest

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface AddHistoryReq : BaseRequest

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface CommentListReq : BaseRequest

@property (strong, nonatomic) NSString *goods_id;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) NSString *t_id;

@end

@interface CommentListData : NSObject

@property (strong, nonatomic) NSArray *data;
@property (assign, nonatomic) NSString *total;
@property (assign, nonatomic) NSInteger total_page;
@property (assign, nonatomic) NSString *nowpage;
@property (strong, nonatomic) NSString *pagesize;

@end

@interface CommentListRsp : BaseResponse

@property (strong, nonatomic) CommentListData *data;
@property (assign, nonatomic) NSString *best_num;
@property (strong, nonatomic) NSString *total_num;
@property (assign, nonatomic) NSString *middle_num;
@property (strong, nonatomic) NSString *lower_num;
@property (assign, nonatomic) NSString *show_num;

@end

@interface CartListReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface CartGoodsModel : NSObject

@property (strong, nonatomic) NSString *check;
@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *unit;
@property (assign, nonatomic) BOOL editSelect;

@end

@interface CartExchangeItemModel : NSObject

@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *price;

@end

@interface CartExchangeModel : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSArray *check_hg_data;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *t_name;

@end

@interface CartListRsp : BaseResponse

@property (strong, nonatomic) NSString *total_money;
@property (strong, nonatomic) NSString *total_now_money;
@property (strong, nonatomic) NSString *total_num;
@property (strong, nonatomic) NSString *total_jian;
@property (strong, nonatomic) NSArray *huangou_list;
@property (strong, nonatomic) NSArray *goods_list;

@end

@interface EditCartReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *goods_num;
@property (strong, nonatomic) NSString *key;

@end

@interface SelectGoodsCartReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *key;

@end

@interface SelectAllCartReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *goods_ids;
@property (strong, nonatomic) NSString *check_change_status;
@property (strong, nonatomic) NSString *key;

@end

@interface CartCollectReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *goods_ids;
@property (strong, nonatomic) NSString *key;

@end

@interface CartDeleteReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *goods_ids;
@property (strong, nonatomic) NSString *key;

@end

@interface CartLikeReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface CartLikeModel : NSObject

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *pic;

@end

@interface CartLikeRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;

@end

@interface ExchangeListReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *huan_id;
@property (strong, nonatomic) NSString *key;

@end

@interface ExchangeListModel : NSObject

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *check;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *old_price;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *tag;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *no_id;

@end

@interface ExchangeListRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSString *total_check;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *total;
@property (strong, nonatomic) NSString *is_chlick;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *t_name;

@end

@interface SelectExchangeReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *tradedids;
@property (strong, nonatomic) NSString *huan_id;
@property (strong, nonatomic) NSString *key;


@end

@interface HistoryListReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) NSString *key;

@end

@interface HistoryListModel : NSObject

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *no;
@property (strong, nonatomic) NSString *unit;


@end

@interface HistoryListData : NSObject

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSString *nowpage;
@property (strong, nonatomic) NSString *pagesize;
@property (assign, nonatomic) NSInteger total;
@property (assign, nonatomic) NSInteger total_page;

@end

@interface HistoryListRsp : BaseResponse

@property (strong, nonatomic) HistoryListData *data;

@end

@interface ClearHistoryReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;


@end

@interface CouponListReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) NSString *key;
@property (assign, nonatomic) NSString *tid;

@end

@interface CouponListModel : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *date1;
@property (strong, nonatomic) NSString *e_date;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *money_s;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *s_date;
@property (strong, nonatomic) NSString *state;


@end

@interface CouponListData : NSObject

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSString *nowpage;
@property (strong, nonatomic) NSString *pagesize;
@property (assign, nonatomic) NSInteger total;
@property (assign, nonatomic) NSInteger total_page;

@end

@interface CouponListRsp : BaseResponse

@property (strong, nonatomic) CouponListData *data;

@end

@interface OrderListReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) NSString *key;
@property (assign, nonatomic) NSString *t_id;
@property (assign, nonatomic) NSString *date_jg;

@end

@interface OrderGoodsListModel : NSObject

@property (strong, nonatomic) NSString *pic;


@end

@interface OrderListModel : NSObject

@property (strong, nonatomic) NSString *no;
@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *date1;
@property (strong, nonatomic) NSString *qu_date;
@property (strong, nonatomic) NSArray *goods;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *state_name;


@end

@interface OrderListData : NSObject

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSString *nowpage;
@property (strong, nonatomic) NSString *pagesize;
@property (assign, nonatomic) NSInteger total;
@property (assign, nonatomic) NSInteger total_page;

@end

@interface OrderListRsp : BaseResponse

@property (strong, nonatomic) OrderListData *data;

@end

@interface OrderDetailReq : BaseRequest

@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface OrderDetailGoodsModel : NSObject

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *total_money;
@property (strong, nonatomic) NSString *unit;

@end

@interface OrderDetailData : NSObject

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *address_name;
@property (strong, nonatomic) NSString *address_qu;
@property (strong, nonatomic) NSString *address_zheng;
@property (strong, nonatomic) NSString *dongjie_money;
@property (strong, nonatomic) NSArray *goods;
@property (strong, nonatomic) NSString *goods_total_js_money;
@property (strong, nonatomic) NSString *goods_total_money;
@property (strong, nonatomic) NSString *jf_money;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *no;
@property (strong, nonatomic) NSString *preferential_total_money;
@property (strong, nonatomic) NSString *quan_money;
@property (strong, nonatomic) NSString *ship_money;
@property (strong, nonatomic) NSString *state;
@property (assign, nonatomic) NSInteger to_do;
@property (strong, nonatomic) NSString *to_do_name;
@property (assign, nonatomic) NSInteger psfs;

@end

@interface OrderDetailRsp : BaseResponse

@property (strong, nonatomic) OrderDetailData *data;

@end

@interface RefundOrderListReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface RefundOrderGoodsModel : NSObject

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *sx_order_id;


@end

@interface RefundOrderListModel : NSObject

@property (strong, nonatomic) NSString *no;
@property (strong, nonatomic) NSArray *data;

@end

@interface RefundOrderListRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;

@end

@interface HaveCommentListReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface HaveCommentGoodsModel : NSObject

@property (strong, nonatomic) NSString *goods_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *sx_order_id;


@end

@interface HaveCommentListModel : NSObject

@property (strong, nonatomic) NSString *no;
@property (strong, nonatomic) NSArray *data;

@end

@interface HaveCommentListRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;

@end

@interface CommitCommentReq : BaseRequest

@property (strong, nonatomic) NSString *base_64_str;
@property (strong, nonatomic) NSString *productid;
@property (strong, nonatomic) NSString *orderid;
@property (strong, nonatomic) NSString *goals;
@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *tag;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *comment_content;

@end

@interface ActivityListReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) NSString *key;

@end

@interface ActivityListModel : NSObject

@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *t_id;
@property (strong, nonatomic) NSString *url;

@end

@interface ActivityListData : NSObject

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSString *nowpage;
@property (strong, nonatomic) NSString *pagesize;
@property (assign, nonatomic) NSInteger total;
@property (assign, nonatomic) NSInteger total_page;

@end

@interface ActivityListRsp : BaseResponse

@property (strong, nonatomic) ActivityListData *data;

@end

@interface CheckOrderReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface CheckOrderGoodsModel : NSObject

@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *unit;

@end

@interface CheckOrderPayWayModel : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *name;

@end

@interface CheckOrderData : NSObject

@property (strong, nonatomic) NSString *account_money;
@property (strong, nonatomic) NSString *address_qu;
@property (strong, nonatomic) NSString *address_zheng;
@property (strong, nonatomic) NSString *address_address;
@property (strong, nonatomic) NSString *address_id;
@property (strong, nonatomic) NSString *address_name;
@property (strong, nonatomic) NSString *address_more;
@property (strong, nonatomic) NSString *about;
@property (strong, nonatomic) NSArray *goods;
@property (strong, nonatomic) NSArray *psfs_all;
@property (strong, nonatomic) NSString *is_xiaopiao;
@property (strong, nonatomic) NSString *jifen_money;
@property (strong, nonatomic) NSString *jifen_name;
@property (strong, nonatomic) NSString *jifen_total_num;
@property (strong, nonatomic) NSString *pay_money;
@property (assign, nonatomic) NSInteger pay_type;
@property (strong, nonatomic) NSString *psfs_name;
@property (strong, nonatomic) NSString *quan_money;
@property (strong, nonatomic) NSString *other_money;
@property (strong, nonatomic) NSString *quan_id;
@property (strong, nonatomic) NSString *quan_name;
@property (strong, nonatomic) NSString *quan_total_num;
@property (strong, nonatomic) NSString *ship_money;
@property (strong, nonatomic) NSString *shippingtime;
@property (strong, nonatomic) NSString *shippingtime_id;
@property (strong, nonatomic) NSString *shippingtime_name;
@property (strong, nonatomic) NSString *total_money;
@property (strong, nonatomic) NSString *total_num;
@property (strong, nonatomic) NSString *about1;
@property (assign, nonatomic) NSInteger psfs;

@end

@interface CheckOrderRsp : BaseResponse

@property (strong, nonatomic) CheckOrderData *data;

@end

@interface SendTimeReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface SendTimeModel : NSObject

@property (strong, nonatomic) NSString *Ids;
@property (strong, nonatomic) NSString *h;
@property (strong, nonatomic) NSString *month;
@property (strong, nonatomic) NSString *t;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *is_check;

@end

@interface SendTimeRsp : BaseResponse

@property (strong, nonatomic) NSMutableArray *data;

@end

@interface SetSendTimeReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *Ids;

@end

@interface SetSendWayReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *psfs;

@end

@interface ChooseAddressReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *my_address_id;

@end

@interface SelectAreaReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface SelectAreaModel : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *address_class_id;
@property (strong, nonatomic) NSString *num;
@property (assign, nonatomic) BOOL isSelect;

@end

@interface SelectAreaRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;

@end

@interface SelectTownReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *address_class_id;

@end

@interface CreateOrderGoodsDetailReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface CreateOrderGoodsDetailModel : NSObject

@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *unit;

@end

@interface CreateOrderGoodsDetailRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;

@end

@interface SetPayWayReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *pay_type;

@end

@interface SetBillReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *is_xiaopiao;

@end

@interface SendScoreReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *point;

@end

@interface WXPayModel : NSObject

@property (strong, nonatomic) NSString *appid;
@property (strong, nonatomic) NSString *noncestr;
@property (strong, nonatomic) NSString *package;
@property (strong, nonatomic) NSString *partnerid;
@property (strong, nonatomic) NSString *prepayid;
@property (strong, nonatomic) NSString *sign;
@property (assign, nonatomic) UInt32 timestamp;

@end

@interface MainRechargeReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *money;

@end

@interface MainRechargeRsp : BaseResponse

@property (strong, nonatomic) WXPayModel *data;

@end

@interface OrderSubmitPayReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (assign, nonatomic) NSInteger psfs;
@property (strong, nonatomic) NSString *address_id;
@property (strong, nonatomic) NSString *address_qu;
@property (strong, nonatomic) NSString *address_zheng;
@property (strong, nonatomic) NSString *address_more;

@end

@interface OrderWXPayRsp : BaseResponse

@property (strong, nonatomic) WXPayModel *data;

@end

@interface ContinuePayReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *order_id;

@end

@interface ContinuePayRsp : BaseResponse

@property (strong, nonatomic) WXPayModel *data;

@end

@interface CancelOrderReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *order_id;

@end

@interface SignMemberReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface InvoiceMoneyReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface InvoiceMoneyRsp : BaseResponse

@property (strong, nonatomic) NSString *money;

@end

@interface InvoiceSubmitReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *money;
@property (strong, nonatomic) NSString *t_id;
@property (strong, nonatomic) NSString *invoice_list_id;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *tax_num;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *tel;

@property (strong, nonatomic) NSString *card;
@property (strong, nonatomic) NSString *bank;


@end

@interface SpecialApplyReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;

@end

@interface SpecialApplyModel : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *is_check;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *state_name;


@end

@interface SpecialApplyRsp : BaseResponse

@property (strong, nonatomic) NSMutableArray *data;

@end


@interface FormBoardDownloadReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *email_box;

@end

@interface ChooseCompanyReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *invoice_list_id;

@end

@interface 	SendInvoiceAppliactionReq : BaseRequest

@property (strong, nonatomic) NSString *member_id;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *company_tel;
@property (strong, nonatomic) NSString *tax_no;
@property (strong, nonatomic) NSString *bank;
@property (strong, nonatomic) NSString *card;
@property (strong, nonatomic) NSString *pic1;
@property (strong, nonatomic) NSString *pic2;
@property (strong, nonatomic) NSString *pic3;
@end
