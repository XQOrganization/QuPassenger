//
//  RouteSearchVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/26.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "RouteSearchVC.h"

@interface RouteSearchVC ()<QMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *startTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTextField;
@property (weak, nonatomic) IBOutlet UIImageView *greenDotImageView;

@property (strong, nonatomic) QMapView *mapView;
@property (assign, nonatomic) BOOL isLocationSuccess;//是否定位成功

@end

@implementation RouteSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMapView];
    
    [self.searchView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.greenDotImageView setCornerRadius:self.greenDotImageView.qu_w/2 AndBorder:0 borderColor:nil];
    
    self.startTextField.borderStyle = UITextBorderStyleNone;
    self.endTextField.borderStyle = UITextBorderStyleNone;
    
    

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
