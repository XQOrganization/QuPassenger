//
//  RouteNoneTabCell.m
//  QuPassenger
//
//  Created by 朱青 on 2017/10/11.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "RouteNoneTabCell.h"

@implementation RouteNoneTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.applyBtn setCornerRadius:4.0f AndBorder:0.5f borderColor:HEXCOLOR(@"404040")];
    [self.bgImageView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self showShadowColor];
}

- (IBAction)applyClickAction:(id)sender
{
    if (self.routeApplyBlock) {
        self.routeApplyBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
