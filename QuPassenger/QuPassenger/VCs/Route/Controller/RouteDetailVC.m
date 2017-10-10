//
//  RouteDetailVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "RouteDetailVC.h"

@interface RouteDetailVC ()<QMapViewDelegate>

@property (strong, nonatomic) QMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@end

@implementation RouteDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMapView];
    
    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    self.quNavBar.title = @"班次详情";
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"route_share_icon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.quNavBar.rightView = rightBtn;
    
    [self.buyBtn setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    
}

- (void)initMapView
{
    CGRect frame = self.view.frame;
    QMapView *mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, SCREEN_HEIGHT - 64)];
    self.mapView = mapView;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = NO;
    //    self.mapView.userTrackingMode = QUserTrackingModeFollow;
    [self.mapView setZoomLevel:15.01 animated:YES];
    [self.view insertSubview:self.mapView atIndex:0];
}

#pragma mark BtnClickAction
- (void)rightBarButtonItemAction:(UIButton *)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
