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
#import "MainLeftCateCell.h"
#import "MainRouteRecommandView.h"
#import "WXRegistViewController.h"
#import "JourneyViewController.h"
#import "RouteSearchVC.h"

#define CATEGORYWIDTH 188

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *leftHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UILabel *leftNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftHeadImageView;
@property (strong, nonatomic) UIButton *bgBlackBtn;
@property (strong, nonatomic) NSArray *leftArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    self.quNavBar.title = @"苏州市";

    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"main_person_icon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.quNavBar.leftView = leftBtn;
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"main_message_icon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.quNavBar.rightView = rightBtn;
    
    UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blackBtn setFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    blackBtn.alpha = 0.0f;
    [blackBtn addTarget:self action:@selector(categoryBackAction:) forControlEvents:UIControlEventTouchUpInside];
    blackBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackBtn];
    self.bgBlackBtn = blackBtn;
    
    //添加侧边栏
    [self.leftView setFrame:CGRectMake(-CATEGORYWIDTH,0,CATEGORYWIDTH,SCREEN_HEIGHT)];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.leftView addGestureRecognizer:panGesture];
    [self.view addSubview:self.leftView];
    
    
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
    
    [self.leftTableView registerNib:[UINib nibWithNibName:@"MainLeftCateCell" bundle:nil] forCellReuseIdentifier:@"MainLeftCateCell"];

    NSArray *array = [LocalDataModel arrayForMainLeftCategory];
    self.leftArray = array;
    
    [self.leftHeadImageView setCornerRadius:self.leftHeadImageView.mj_w/2 AndBorder:0 borderColor:nil];

    
    [[QuLocationManager shareManager]startUpdatingLocation];
 
}

#pragma mark gestureRecognizer
- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:gesture.view];;
    
    switch (gesture.state){
            
        case UIGestureRecognizerStateBegan:{
            
            [self.leftView setFrame:CGRectMake(0, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
            self.bgBlackBtn.alpha = 0.3f;
        }
            
            break;
            
        case UIGestureRecognizerStateChanged:{
            
            if(translation.x > 0){
                
                [self.leftView setFrame:CGRectMake(0, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
                self.bgBlackBtn.alpha = 0.3f;
                
            }
            else if(translation.x < 0){
                
                [self.leftView setFrame:CGRectMake(translation.x, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
                self.bgBlackBtn.alpha = 0.3f;
                
            }
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            
            if (self.leftView.frame.origin.x < -90){
                
                [UIView animateWithDuration:0.2 animations:^(){
                    [self.leftView setFrame:CGRectMake(-CATEGORYWIDTH, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
                     
                    self.bgBlackBtn.alpha = 0.0f;
                    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
                     
                }completion:^(BOOL finished){
                     
                }];
            }
            else{
                
                [UIView animateWithDuration:0.2 animations:^(){
                     [self.leftView setFrame:CGRectMake(0, 0, CATEGORYWIDTH, SCREEN_HEIGHT)];
                     
                     self.bgBlackBtn.alpha = 0.3f;
                     
                }completion:^(BOOL finished){
                     
                }];
            }
            
            [gesture setTranslation:CGPointMake(0, 0) inView:self.leftView];
            
            break;
        }
        default:
            break;
    }
    
}

#pragma mark btnClickAction
- (void)leftBarButtonItemAction:(id)sender
{
    if (!ACCOUNTINFO.isLogin) {
        [self presentLoginWithComplection:nil];
        return;
    }
    [self showLeftView];
}

- (void)rightBarButtonItemAction:(id)sender
{
    
}

- (void)categoryBackAction:(UIButton *)sender
{
    [self dismissLeftView];
}

- (void)showLeftView
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        
        self.leftView.frame = CGRectMake(0, 0, CATEGORYWIDTH, SCREEN_HEIGHT);
        self.bgBlackBtn.alpha = 0.3f;
        
    } completion:^(BOOL finished){
        
    }];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)dismissLeftView
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        
        self.leftView.frame = CGRectMake(-CATEGORYWIDTH, 0, CATEGORYWIDTH, SCREEN_HEIGHT);
        self.bgBlackBtn.alpha = 0.0f;
        
    } completion:^(BOOL finished){
         
    }];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.leftArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainLeftCateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainLeftCateCell"];
    
    LocalDataModel *listModel = self.leftArray[indexPath.row];
    cell.cateLabel.text = listModel.name;
    [cell.cateImageView setImage:[UIImage imageNamed:listModel.imageName]];
    

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LocalDataModel *model = self.leftArray[indexPath.row];
    
    switch (model.sign) {
        case 0:{
            //行程
            if (!ACCOUNTINFO.isLogin) {
                [self presentLoginWithComplection:nil];
                return;
            }
            JourneyViewController *vc = [[JourneyViewController alloc]initWithNibName:@"JourneyViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
           
        }
            break;
            
        case 1:{
            //绑定认证
            if (!ACCOUNTINFO.isLogin) {
                [self presentLoginWithComplection:nil];
                return;
            }
        
            WXRegistViewController *vc = [[WXRegistViewController alloc]initWithNibName:@"WXRegistViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2:{
            //关于我们
            
        }
            break;
            
        case 3:{
            //设置
     
        }
            break;
            
        default:
            break;
    }

//    [self categoryBackAction:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        
        cell.routeSearchBlock = ^(NSString *start, NSString *end) {
            
            RouteSearchVC *vc = [[RouteSearchVC alloc]initWithNibName:@"RouteSearchVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        cell.routeEditBlock  = ^(NSString *start, NSString *end,NSInteger from) {
            
            RouteSearchVC *vc = [[RouteSearchVC alloc]initWithNibName:@"RouteSearchVC" bundle:nil];
            vc.from = from;
            [self.navigationController pushViewController:vc animated:YES];
        };
        
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
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"5"];
        
        NSAttributedString *tempAttributeString = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        [attributeString appendAttributedString:tempAttributeString];
        
        cell.priceLabel.attributedText = attributeString;
        
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
//    [self showLeftView];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
