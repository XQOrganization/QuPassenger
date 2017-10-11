//
//  CouponListCell.h
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *couponPiclab;
@property (weak, nonatomic) IBOutlet UILabel *couponRouteLab;//路线
@property (weak, nonatomic) IBOutlet UILabel *couponRuleLab;//满多少使用
@property (weak, nonatomic) IBOutlet UILabel *ouponValidityLab;//有效期
@property (weak, nonatomic) IBOutlet UIButton *isChooseCouponBtn;


@end
