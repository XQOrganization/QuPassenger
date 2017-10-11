//
//  MyWalletTableViewCell.h
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/9.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWalletTableViewCell : UITableViewCell
@property(nonatomic,copy)void (^picBlock) (NSInteger pic);
@property(nonatomic,copy)void (^PayTypeBlock) (NSInteger payType);
@property (weak, nonatomic) IBOutlet UITextField *ibEnteramountTf;
@property (weak, nonatomic) IBOutlet UIButton *ibGoPayBtn;
@end
