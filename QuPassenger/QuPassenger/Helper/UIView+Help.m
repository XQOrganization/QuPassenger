//
//  UIView+Help.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "UIView+Help.h"

@implementation UIView (Help)

- (void)setQu_x:(CGFloat)qu_x
{
    CGRect frame = self.frame;
    frame.origin.x = qu_x;
    self.frame = frame;
}

- (CGFloat)qu_x
{
    return self.frame.origin.x;
}

- (void)setQu_y:(CGFloat)qu_y
{
    CGRect frame = self.frame;
    frame.origin.y = qu_y;
    self.frame = frame;
}

- (CGFloat)qu_y
{
    return self.frame.origin.y;
}

- (void)setQu_w:(CGFloat)qu_w
{
    CGRect frame = self.frame;
    frame.size.width = qu_w;
    self.frame = frame;
}

- (CGFloat)qu_w
{
    return self.frame.size.width;
}

- (void)setQu_h:(CGFloat)qu_h
{
    CGRect frame = self.frame;
    frame.size.height = qu_h;
    self.frame = frame;
}

- (CGFloat)qu_h
{
    return self.frame.size.height;
}

- (void)setQu_size:(CGSize)qu_size
{
    CGRect frame = self.frame;
    frame.size = qu_size;
    self.frame = frame;
}

- (CGSize)qu_size
{
    return self.frame.size;
}

- (void)setQu_origin:(CGPoint)qu_origin
{
    CGRect frame = self.frame;
    frame.origin = qu_origin;
    self.frame = frame;
}

- (CGPoint)qu_origin
{
    return self.frame.origin;
}

- (UIViewController *)qu_viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

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
