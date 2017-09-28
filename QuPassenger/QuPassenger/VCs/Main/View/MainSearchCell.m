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
    
    self.startTextField.delegate = self;
    self.endTextField.delegate = self;
    
    self.isCurrentTop = YES;
}

- (IBAction)exchangeClickAction:(id)sender
{
    if (self.isCurrentTop) {
        
        [UIView animateWithDuration:0.2f animations:^{
            
            self.startBottomConstraint.constant = -49.5;
            self.endTopConstraint.constant = -49.5;
            [self.contentView layoutIfNeeded];
        }];
        
    }
    else{
        
        [UIView animateWithDuration:0.2f animations:^{
            
            self.startBottomConstraint.constant = 0.5;
            self.endTopConstraint.constant = 0.5;
            [self.contentView layoutIfNeeded];
        }];
    }
    self.isCurrentTop = !self.isCurrentTop;
}

- (IBAction)searchClickAction:(id)sender
{
    if (self.routeSearchBlock) {
        self.routeSearchBlock(self.startTextField.text, self.endTextField.text);
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.routeEditBlock) {
        self.routeEditBlock(self.startTextField.text, self.endTextField.text);
    }
    return NO;
}

@end
