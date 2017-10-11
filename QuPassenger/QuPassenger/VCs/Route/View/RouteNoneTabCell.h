//
//  RouteNoneTabCell.h
//  QuPassenger
//
//  Created by 朱青 on 2017/10/11.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteNoneTabCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;
@property (copy, nonatomic) void (^routeApplyBlock)(void);

@end
