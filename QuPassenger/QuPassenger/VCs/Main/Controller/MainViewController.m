//
//  MainViewController.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "MainViewController.h"
#import "MainChannelCell.h"
#import "MainBannerCell.h"
#import "MainSearchCell.h"
#import "MainBusRouteCell.h"
#import "MainRouteRecommandView.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"main_person_icon"] forState:UIControlStateNormal];
    [self setLeftBarItemWithButton:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"main_message_icon"] forState:UIControlStateNormal];
    [self setRightBarItemWithButton:rightBtn];
    
    self.title = @"苏州市";
    
    [self.mainCollectionView setBackgroundColor:HEXCOLOR(@"f6f6f6")];
    
    UINib *shareNib = [UINib nibWithNibName:@"MainBannerCell" bundle:nil];
    [self.mainCollectionView registerNib:shareNib forCellWithReuseIdentifier:@"MainBannerCell"];
    
    UINib *channelNib = [UINib nibWithNibName:@"MainChannelCell" bundle:nil];
    [self.mainCollectionView registerNib:channelNib forCellWithReuseIdentifier:@"MainChannelCell"];
    
    UINib *innerNib = [UINib nibWithNibName:@"MainSearchCell" bundle:nil];
    [self.mainCollectionView registerNib:innerNib forCellWithReuseIdentifier:@"MainSearchCell"];
    
    UINib *goodsNib = [UINib nibWithNibName:@"MainBusRouteCell" bundle:nil];
    [self.mainCollectionView registerNib:goodsNib forCellWithReuseIdentifier:@"MainBusRouteCell"];
  
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"MainRouteRecommandView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainRouteRecommandView"];

}

#pragma mark btnClickAction
- (void)leftBarButtonItemAction:(id)sender
{
    [self presentLoginWithComplection:nil];
}

- (void)rightBarButtonItemAction:(id)sender
{
    
}


#pragma mark UICollectionViewDatasource/UICollectionViewDelegate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSInteger count = 1;
    
    if (section == 0 || section == 1) {
        count = 1;
    }
    else if (section == 2){
        count = 2;
    }
    else{
        count = 3;
    }
    
    return count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 4;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    
    if (indexPath.section == 0) {
        static NSString *dIdentifier = @"MainBannerCell";
        MainBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dIdentifier forIndexPath:indexPath];
        
//        [cell addBannerWithArray:self.mainRsp.data clickBlock:^(MainBannerModel *itemModel) {
//            NSInteger eventId = [itemModel.t_id integerValue];
//            NSString *jumpId = itemModel.url;
//            [weakSelf jumpWithTid:eventId url:jumpId];
//        }];
        
        return cell;
    }
    else if (indexPath.section == 1){
        static NSString *aIdentifier = @"MainSearchCell";
        MainSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:aIdentifier forIndexPath:indexPath];
        
//        [cell addBannerWithArray:self.mainRsp.data_xsqg clickBlock:^(MainBuyModel *itemModel) {
//            TimeBuyVC *vc = [[TimeBuyVC alloc]initWithNibName:@"TimeBuyVC" bundle:nil];
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        }];
        
        return cell;
    }
    else if (indexPath.section == 2){
        static NSString *bIdentifier = @"MainChannelCell";
        MainChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bIdentifier forIndexPath:indexPath];
        
//        MainSmallModel *model = self.mainRsp.small_pic[indexPath.item];
//        [cell.channelLabel setText:model.name];
//        [cell.channelImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        
        return cell;
    }
    else {
        
        static NSString *cIdentifier = @"MainBusRouteCell";
        MainBusRouteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cIdentifier forIndexPath:indexPath];
        
//        MainBannerModel *model = [self.mainRsp.data_bottom objectAtIndex:indexPath.item];
//        
//        [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        
        return cell;
    }

    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 3) {
            
            MainRouteRecommandView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainRouteRecommandView" forIndexPath:indexPath];
            
            reusableview = headerView;
        }
        
        
    }
    
    return reusableview;
}

//pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_SIZE.width, ScreenWidthRatio * 120);
    }
    else if (indexPath.section == 1){
  
        return CGSizeMake(SCREEN_SIZE.width, 100);
        
        
    }
    else if (indexPath.section == 2){

        NSInteger count = 2;//暂时只有2个
        return CGSizeMake((SCREEN_SIZE.width - (count + 1) * 10)/count, 90);
    }
    else {
        
        //最后一个
        return CGSizeMake(SCREEN_SIZE.width - 20, 138);
    }
    
    return CGSizeMake(0, 0);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2 || section == 3){
        
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 3) {
        return 10;
    }
    return 0;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 3) {
        return CGSizeMake(SCREEN_SIZE.width, 20);
    }
    
    return CGSizeMake(0, 0);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
