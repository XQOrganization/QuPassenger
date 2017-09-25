//
//  MainBannerCell.h
//  FreshFood
//
//  Created by 朱青 on 2017/7/9.
//  Copyright © 2017年 FreshFood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface MainBannerCell : UICollectionViewCell<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
@property (copy, nonatomic) void (^mainBannerBlock)(MainBannerModel *itemModel);
@property (strong, nonatomic) NSArray *bannerArray;

- (void)addBannerWithArray:(NSArray*)array clickBlock:(void (^)(MainBannerModel *itemModel))clickBlock;

@end
