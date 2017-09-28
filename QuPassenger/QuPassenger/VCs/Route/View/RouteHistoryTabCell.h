//
//  RouteHistoryTabCell.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/28.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteHistoryTabCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end
