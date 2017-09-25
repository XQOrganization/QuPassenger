//
//  UIView+Help.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "UIView+Help.h"

@implementation UIView (Help)

- (void)setCornerRadius:(CGFloat)radius AndBorder:(CGFloat)borderWidth borderColor:(UIColor *)color
{
    if (radius > 0) {
        [self.layer setCornerRadius:radius];
    }
    if (borderWidth > 0) {
        [self.layer setBorderWidth:borderWidth];
        [self.layer setBorderColor:color.CGColor];
    }
}

- (void)showShadowColor
{
    
    self.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 1.0;
    self.layer.masksToBounds = NO;
}

@end
