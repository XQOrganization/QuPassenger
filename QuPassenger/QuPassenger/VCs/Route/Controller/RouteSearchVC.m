//
//  RouteSearchVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/26.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "RouteSearchVC.h"
#import "RouteHistoryCell.h"
#import "RouteBusCell.h"

@interface RouteSearchVC ()<QMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *startTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTextField;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *routeCollectionView;

@property (strong, nonatomic) QMapView *mapView;
@property (assign, nonatomic) BOOL isLocationSuccess;//是否定位成功

@end

@implementation RouteSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMapView];
    
    [self.searchView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.searchView showShadowColor];
    
    if (self.from == 1) {
        [self.topBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
        [self.bottomBtn setImage:[UIImage imageNamed:@"route_red_icon"] forState:UIControlStateNormal];
    }
    else{
        [self.topBtn setImage:[UIImage imageNamed:@"route_green_icon"] forState:UIControlStateNormal];
        [self.bottomBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
    }
    self.startTextField.borderStyle = UITextBorderStyleNone;
    self.endTextField.borderStyle = UITextBorderStyleNone;
    
    UINib *shareNib = [UINib nibWithNibName:@"RouteHistoryCell" bundle:nil];
    [self.routeCollectionView registerNib:shareNib forCellWithReuseIdentifier:@"RouteHistoryCell"];
}

- (void)initMapView
{
    CGRect frame = self.view.frame;
    QMapView *mapView = [[QMapView alloc] initWithFrame:frame];
    self.mapView = mapView;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
//    self.mapView.userTrackingMode = QUserTrackingModeFollow;
    [self.mapView setZoomLevel:15.01 animated:YES];
    [self.view insertSubview:self.mapView atIndex:0];
}

#pragma mark QMapViewDelegate
- (void)mapViewWillStartLocatingUser:(QMapView *)mapView
{
    //获取开始定位的状态
}

- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
    //获取停止定位的状态
}

- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    NSLog(@"coordinate:%f,%f, heading:%f", userLocation.coordinate.latitude, userLocation.coordinate.longitude, userLocation.heading.trueHeading);

    if (!self.isLocationSuccess) {
        self.isLocationSuccess = YES;
        [mapView setUserTrackingMode:QUserTrackingModeFollowWithHeading animated:YES];
    }

    
}

- (void)mapView:(QMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位失败");
}

#pragma mark btnClickAction
- (IBAction)leftClickAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    static NSString *cIdentifier = @"RouteHistoryCell";
    RouteHistoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cIdentifier forIndexPath:indexPath];
    
    //        MainBannerModel *model = [self.mainRsp.data_bottom objectAtIndex:indexPath.item];
 
    [cell.iconImageView setImage:[UIImage imageNamed:@"route_history_icon"]];
    [cell.nameLabel setText:@"国际科技园"];
    [cell.addressLabel setText:@"江苏省苏州市工业园区金鸡湖大道2135号"];
    
    return cell;
    
}

//pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return CGSizeMake(SCREEN_SIZE.width - 20, 80);
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
