//
//  BasicVC.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/1.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicVC : UIViewController

+ (BaseNavigationController *)navigationControllerContainSelf;
- (void)presentLoginWithComplection:(void(^)(void))complectionBlock;

/**
 添加NAV 左右按钮
 
 @param left title或image
 @param right title或image
 */
- (void)setBarItemWithLeftButton:(NSObject *)left rightButton:(NSObject *)right;
- (void)leftBarButtonItemAction:(id)sender;
- (void)rightBarButtonItemAction:(id)sender;

- (void)jumpWithTid:(NSInteger)eventId url:(NSString *)params;



@end
