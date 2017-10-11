//
//  RouteDetailVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "RouteDetailVC.h"
#import "TicketChooseVC.h"
#import "RouteDetailCell.h"

@interface RouteDetailVC ()<QMapViewDelegate>

@property (strong, nonatomic) QMapView *mapView;

@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIView *tabHeadView;
@property (weak, nonatomic) IBOutlet UILabel *tabHeadLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UITableView *routeTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (assign, nonatomic) BOOL isDown;

@property (assign, nonatomic) NSInteger routeNum;
@property (assign, nonatomic) BOOL isLocationSuccess;//是否定位成功

@property (nonatomic, strong) NSMutableArray *annotations;

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
    [self.headView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.headView showShadowColor];
   
    [self.downBtn showShadowColor];
    
    [self.tabHeadLabel setCornerRadius:10.0f AndBorder:0 borderColor:nil];
    self.tabHeadLabel.layer.masksToBounds = YES;
    
    [self.routeTableView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    self.routeTableView.clipsToBounds = YES;
  
    [self.routeTableView registerNib:[UINib nibWithNibName:@"RouteDetailCell" bundle:nil] forCellReuseIdentifier:@"RouteDetailCell"];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"5"];
    NSAttributedString *tempAttributeString = [[NSAttributedString alloc] initWithString:@"元" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    [attributeString appendAttributedString:tempAttributeString];
    self.priceLabel.attributedText = attributeString;
    
}

- (void)initMapView
{
    CGRect frame = self.view.frame;
    QMapView *mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, SCREEN_HEIGHT - 64)];
    self.mapView = mapView;
    self.mapView.delegate = self;
//    self.mapView.showsUserLocation = YES;
    //    self.mapView.userTrackingMode = QUserTrackingModeFollow;
//    [self.mapView setZoomLevel:11.01 animated:NO];
    [self.view insertSubview:self.mapView atIndex:0];
    
    [self setupAnnotations];
    [self.mapView addAnnotations:self.annotations];
//    [self.mapView showAnnotations:self.annotations animated:YES];
    
    
}

- (void)setupAnnotations
{
    self.annotations = [NSMutableArray array];
    
    QPointAnnotation *annotation1 = [[QPointAnnotation alloc] init];
    annotation1.coordinate = CLLocationCoordinate2DMake(31.3207208243,120.7133102417);
    
    [self.annotations addObject:annotation1];
    
    QPointAnnotation *annotation2 = [[QPointAnnotation alloc] init];
    annotation2.coordinate = CLLocationCoordinate2DMake(31.2796511847,120.6376075745);
    
    [self.annotations addObject:annotation2];
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((annotation1.coordinate.latitude + annotation2.coordinate.latitude) / 2, (annotation2.coordinate.longitude + annotation1.coordinate.longitude) / 2);
    [self.mapView setCenterCoordinate:center];
    
//    QCoordinateSpan span = QCoordinateSpanMake(fabs(annotation1.coordinate.latitude - annotation2.coordinate.latitude), fabs(annotation1.coordinate.longitude - annotation1.coordinate.longitude));
//    
//    QCoordinateRegion region = [self.mapView regionThatFits:QCoordinateRegionMake(center, span)];
//    [self.mapView setRegion:region animated:YES];
    
    QMapPoint point1 = QMapPointForCoordinate(annotation1.coordinate);
    QMapPoint point2 = QMapPointForCoordinate(annotation2.coordinate);
    double distance = QMetersBetweenMapPoints(point1, point2);
 
    //这个数组就是百度地图比例尺对应的物理距离，其中2000000对应的比例是3，5对应的是21；可能有出入可以根据情况累加
    NSArray *zoomLevelArr = [[NSArray alloc]initWithObjects:@"2000000", @"1000000", @"500000", @"200000", @"100000", @"50000", @"25000", @"20000", @"10000", @"5000", @"2000", @"1000", @"500", @"200", @"100", @"50", @"20", @"10", @"5", nil];
    for (int j=0; j<zoomLevelArr.count; j++) {
        if (j + 1 < zoomLevelArr.count) {
            if (distance < [zoomLevelArr[j] intValue] && distance > [zoomLevelArr[j+1] intValue] ) {
                [_mapView setZoomLevel:j+5.01];
                break;
            }
        }
    }
    
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

- (QAnnotationView *)mapView:(QMapView *)mapView
           viewForAnnotation:(id<QAnnotation>)annotation
{
    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        //设置复用标识
        static NSString *pointReuseIdentifier = @"pointReuseIdentifier";
        QAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIdentifier];
        if (annotationView == nil) {
            annotationView = [[QAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIdentifier];
        }
        
        // 可拖拽.
        annotationView.draggable = NO;
        // 开启下落动画
//        annotationView.animatesDrop = YES;
        //显示气泡
        [annotationView setCanShowCallout:YES];
        //设置图标
        [annotationView setImage:[UIImage imageNamed:@"map_up_icon"]];
        
        return annotationView;
    }
    return nil;
}

#pragma mark BtnClickAction
- (void)rightBarButtonItemAction:(UIButton *)sender
{
    
}

- (IBAction)downClickAction:(UIButton *)sender
{
    if (!self.isDown) {
        
        [UIView animateWithDuration:0.2f animations:^{
            
            self.heightConstraint.constant = SCREEN_HEIGHT - 64 - 30 - 44;
            self.routeTableView.alpha = 1;
            [self.bigView layoutIfNeeded];
            [self.view layoutIfNeeded];
        }];
     
    }
    else{
        
        [UIView animateWithDuration:0.2f animations:^{
            
            self.heightConstraint.constant = 160;
            self.routeTableView.alpha = 0;
            [self.bigView layoutIfNeeded];
            [self.view layoutIfNeeded];
            
        }];
        
    }
//    [self.routeTableView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
  

    self.isDown = !self.isDown;
}

- (IBAction)buyClickAction:(id)sender
{
    TicketChooseVC *vc = [[TicketChooseVC alloc]initWithNibName:@"TicketChooseVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44.0f;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.tabHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RouteDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RouteDetailCell"];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
