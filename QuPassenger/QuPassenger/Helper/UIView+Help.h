//
//  UIView+Help.h
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Help)

@property (assign, nonatomic) CGFloat qu_x;
@property (assign, nonatomic) CGFloat qu_y;
@property (assign, nonatomic) CGFloat qu_w;
@property (assign, nonatomic) CGFloat qu_h;
@property (assign, nonatomic) CGSize qu_size;
@property (assign, nonatomic) CGPoint qu_origin;

- (UIViewController *)qu_viewController;

//展示圆角 线 颜色
- (void)setCornerRadius:(CGFloat)radius AndBorder:(CGFloat)borderWidth borderColor:(UIColor *)color;

//展示阴影
- (void)showShadowColor;

@end
