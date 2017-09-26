//
//  JourneyViewController.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/26.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "JourneyViewController.h"
#import "JourneyListCell.h"

@interface JourneyViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *journeyCollectionView;

@end

@implementation JourneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    self.quNavBar.title = @"行程";
    
    [self.journeyCollectionView setBackgroundColor:HEXCOLOR(@"f6f6f6")];
    [self.journeyCollectionView setAlwaysBounceVertical:YES];
    
    UINib *goodsNib = [UINib nibWithNibName:@"JourneyListCell" bundle:nil];
    [self.journeyCollectionView registerNib:goodsNib forCellWithReuseIdentifier:@"JourneyListCell"];
}

#pragma mark UICollectionViewDatasource/UICollectionViewDelegate
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return 3;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cIdentifier = @"JourneyListCell";
    JourneyListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cIdentifier forIndexPath:indexPath];
    
    //        MainBannerModel *model = [self.mainRsp.data_bottom objectAtIndex:indexPath.item];
    //
    //        [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"5"];
    
    NSAttributedString *tempAttributeString = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    [attributeString appendAttributedString:tempAttributeString];
    
    cell.priceLabel.attributedText = attributeString;
 
    return cell;

}

//pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return CGSizeMake(SCREEN_SIZE.width - 20, 138);

}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    return UIEdgeInsetsMake(10, 10, 10, 10);
 
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
 
    return 10;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self showLeftView];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
