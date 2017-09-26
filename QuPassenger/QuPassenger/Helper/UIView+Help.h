//
//  UIView+Help.h
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Help)

//展示圆角 线 颜色
- (void)setCornerRadius:(CGFloat)radius AndBorder:(CGFloat)borderWidth borderColor:(UIColor *)color;

//展示阴影
- (void)showShadowColor;

@end
