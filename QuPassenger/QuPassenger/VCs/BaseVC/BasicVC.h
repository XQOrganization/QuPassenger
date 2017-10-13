//
//  BasicVC.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/1.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuNavigationBar.h"

@interface BasicVC : UIViewController

@property (strong, nonatomic) QuNavigationBar *quNavBar;

+ (BaseNavigationController *)navigationControllerContainSelf;
- (void)presentLoginWithComplection:(void(^)(void))complectionBlock;


- (void)setLeftBarItemWithButton:(UIButton *)btn;
- (void)setRightBarItemWithButton:(UIButton *)btn;

- (void)jumpWithEventd:(NSInteger)eventId params:(NSString *)params;



@end
