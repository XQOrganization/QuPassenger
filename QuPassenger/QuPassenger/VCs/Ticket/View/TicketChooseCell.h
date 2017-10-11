//
//  TicketChooseCell.h
//  QuPassenger
//
//  Created by 朱青 on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketChooseCell : UITableViewCell

@property (copy, nonatomic) void (^ticketAddBlock) (UILabel *label);
@property (copy, nonatomic) void (^ticketSubBlock) (UILabel *label);

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
