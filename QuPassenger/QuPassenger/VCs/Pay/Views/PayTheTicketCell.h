//
//  PayTheTicketCell.h
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayTheTicketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ibPayPicLab;
@property (weak, nonatomic) IBOutlet UIImageView *ibPayTypeIConImg;
@property (weak, nonatomic) IBOutlet UILabel *ibPayTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *ibBalanceLab;
@property (weak, nonatomic) IBOutlet UIButton *ibChoosePayTypeBtn;
@property (weak, nonatomic) IBOutlet UILabel *ibCouponsLab;

@end
