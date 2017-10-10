//
//  TicketChooseCell.h
//  QuPassenger
//
//  Created by 朱青 on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketChooseCell : UITableViewCell

@property (copy, nonatomic) void (^ticketAddBlock) (void);
@property (copy, nonatomic) void (^ticketSubBlock) (void);

@end
