//
//  MainSearchCell.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/25.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainSearchCell : UICollectionViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UITextField *startTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *endTopConstraint;

@property (assign, nonatomic) BOOL isCurrentTop;//当前位置在顶部

@property (copy, nonatomic) void (^routeSearchBlock)(NSString *start,NSString *end);
@property (copy, nonatomic) void (^routeEditBlock)(NSString *start,NSString *end,NSInteger from);//from://1.出发地进入，2.目的地进入

@end
