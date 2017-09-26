//
//  JourneyListCell.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/26.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "JourneyListCell.h"

@implementation JourneyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.firstView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.thirdView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    
    [self showShadowColor];
}

@end
