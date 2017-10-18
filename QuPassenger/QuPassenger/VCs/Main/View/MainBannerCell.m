//
//  MainBannerCell.m
//  FreshFood
//
//  Created by 朱青 on 2017/7/9.
//  Copyright © 2017年 FreshFood. All rights reserved.
//

#import "MainBannerCell.h"

@implementation MainBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 0.375 * SCREEN_SIZE.width)];
    
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.currentPageDotColor = HEXCOLOR(@"00a653"); // 自定义分页控件小圆标颜色
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self addSubview:cycleScrollView];
    
    self.cycleScrollView = cycleScrollView;
}

- (void)addBannerWithArray:(NSArray*)array clickBlock:(void (^)(MainBannerModel *itemModel))clickBlock
{
    if (self.bannerArray != array) {
        self.mainBannerBlock = clickBlock;
        self.bannerArray = array;
        
        NSMutableArray *adImgAry = [[NSMutableArray alloc]initWithCapacity:0];
        if (array.count>0) {
            for (MainBannerModel *model in array) {
                [adImgAry addObject:model.bannerUrl];
            }
        }
        
        if (adImgAry.count > 0) {
            self.cycleScrollView.imageURLStringsGroup = adImgAry;
        }
    }
    
    
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.mainBannerBlock) {
        self.mainBannerBlock([self.bannerArray objectAtIndex:index]);
    }
}


@end
