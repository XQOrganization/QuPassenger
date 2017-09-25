//
//  MainSearchCell.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/25.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainSearchCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *startTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTextField;

@end
