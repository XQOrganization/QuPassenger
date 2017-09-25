//
//  MainSearchCell.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/25.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "MainSearchCell.h"

@implementation MainSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.searchBtn setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    
    self.startTextField.borderStyle = UITextBorderStyleNone;
    self.endTextField.borderStyle = UITextBorderStyleNone;
}

@end
