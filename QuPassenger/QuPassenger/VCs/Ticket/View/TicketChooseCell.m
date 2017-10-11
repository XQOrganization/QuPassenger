//
//  TicketChooseCell.m
//  QuPassenger
//
//  Created by 朱青 on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "TicketChooseCell.h"

@implementation TicketChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addClickAction:(id)sender
{
    if (self.ticketAddBlock) {
        self.ticketAddBlock(self.countLabel);
    }
}

- (IBAction)subClickAction:(id)sender
{
    if (self.ticketSubBlock) {
        self.ticketSubBlock(self.countLabel);
    }
}


@end
