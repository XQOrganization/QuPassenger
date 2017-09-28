//
//  RouteHistoryCell.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/28.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "RouteHistoryCell.h"

@implementation RouteHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.bgImageView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self showShadowColor];
}

@end
