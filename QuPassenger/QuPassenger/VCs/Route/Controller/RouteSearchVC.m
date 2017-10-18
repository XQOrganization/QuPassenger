//
//  RouteSearchVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/26.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "RouteSearchVC.h"
#import "RouteHistoryTabCell.h"
#import "RouteBusTabCell.h"
#import "TicketChooseVC.h"

@interface RouteSearchVC ()<QMapViewDelegate,QMSSearchDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *startTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTextField;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UITableView *routeTableView;

@property (strong, nonatomic) QMapView *mapView;
@property (assign, nonatomic) BOOL isLocationSuccess;//是否定位成功
@property (assign, nonatomic) NSInteger reloadState;//加载是哪一种cell 0://历史记录 1://班次

@property(strong,nonatomic)QMSGeoCodeSearchOption *geocoder;
@property(strong,nonatomic)QMSSearcher * searcher;

@property (nonatomic, strong) QMSSuggestionResult *suggestionResut;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *endTopConstraint;

@property (assign, nonatomic) BOOL isCurrentTop;//当前位置在顶部


@property(nonatomic,strong)SiteMatchRsp * rsp;

@end

@implementation RouteSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMapView];
    
    [self.searchView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.searchView showShadowColor];

    if (self.choosefrom == 1) {
        
        [self.topBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
        [self.bottomBtn setImage:[UIImage imageNamed:@"route_red_icon"] forState:UIControlStateNormal];
    }
    else{
        
        [self.topBtn setImage:[UIImage imageNamed:@"route_green_icon"] forState:UIControlStateNormal];
        [self.bottomBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
    }
    self.isCurrentTop = YES;
    
    self.startTextField.borderStyle = UITextBorderStyleNone;
    self.endTextField.borderStyle = UITextBorderStyleNone;
    
    [self.routeTableView registerNib:[UINib nibWithNibName:@"RouteHistoryTabCell" bundle:nil] forCellReuseIdentifier:@"RouteHistoryTabCell"];
    [self.routeTableView registerNib:[UINib nibWithNibName:@"RouteBusTabCell" bundle:nil] forCellReuseIdentifier:@"RouteBusTabCell"];
}

- (void)initMapView
{
    CGRect frame = self.view.frame;
    QMapView *mapView = [[QMapView alloc] initWithFrame:frame];
    self.mapView = mapView;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
//    self.mapView.userTrackingMode = QUserTrackingModeFollow;
    [self.mapView setZoomLevel:15.01 animated:NO];
    [self.view insertSubview:self.mapView atIndex:0];
    
    //地图检索初始化
    self.searcher= [[QMSSearcher alloc] init];
    [self.searcher setDelegate:self];
    
    self.geocoder = [[QMSGeoCodeSearchOption alloc] init];
      //可选字段，设置所属城市
    [self.geocoder setRegion:[PublicManager shareManager].selectCityModel.cityName];
    [self.searcher searchWithGeoCodeSearchOption:self.geocoder];
  
  
    QMSReverseGeoCodeSearchOption *regeocoder = [[QMSReverseGeoCodeSearchOption alloc] init];
    [regeocoder setLocation:[NSString stringWithFormat:@"%@,%@",[QuLocationManager shareManager].longitude,[QuLocationManager shareManager].latitude]];
    //返回坐标点附近poi列表
    [regeocoder setGet_poi:YES];
    //设置坐标所属坐标系，以返回正确地址，默认为腾讯所用坐标系
    [regeocoder setCoord_type:QMSReverseGeoCodeCoordinateTencentGoogleGaodeType];

}
//当前位置正在编辑中
- (IBAction)currentPositionTfChange:(UITextField *)sender {
    [self.geocoder setAddress:sender.text];
    [self.searcher searchWithGeoCodeSearchOption:self.geocoder];
    
    //配置搜索参数
    QMSSuggestionSearchOption *suggetionOption = [[QMSSuggestionSearchOption alloc] init];
    [suggetionOption setKeyword:sender.text];
    [suggetionOption setRegion:[PublicManager shareManager].selectCityModel.cityName];
    
    [self.searcher searchWithSuggestionSearchOption:suggetionOption];


}
//目的地正在编辑中
- (IBAction)destinationTfChange:(id)sender {
    
}
- (void)searchWithSuggestionSearchOption:(QMSSuggestionSearchOption *)suggestionSearchOption didReceiveResult:(QMSSuggestionResult *)suggestionSearchResult
{
    NSLog(@"suggest result:%@", suggestionSearchResult);
    self.suggestionResut = suggestionSearchResult;
    [self.routeTableView reloadData];
}
#pragma mark QMSSearchDelegate
//地址解析(地址转坐标)结果回调接口
- (void)searchWithGeoCodeSearchOption:(QMSGeoCodeSearchOption *)geoCodeSearchOption didReceiveResult:(QMSGeoCodeSearchResult *)geoCodeSearchResult{
    
//    [self requestSiteMatch:geoCodeSearchResult];
    
    
}
//MARK:-----检索路线请求
- (void)requestSiteMatch:(QMSGeoCodeSearchResult *)geoResult{
    SiteMatchReq * req = [[SiteMatchReq alloc]init];
    req.lat = [NSString stringWithFormat:@"%f",geoResult.location.latitude];
    req.longitude = [NSString stringWithFormat:@"%f",geoResult.location.longitude];
    req.cityCode = [PublicManager shareManager].selectCityModel.cityCode;
    req.str = _startTextField.text;
    
    [NetWorkReqManager requestDataWithApiName:siteMatch params:req response:^(NSDictionary *responseObject) {
        
        _rsp = [SiteMatchRsp mj_objectWithKeyValues:responseObject];
        if (_rsp.code == 1) {
            
            
            
        }
        else{
            [QuHudHelper qu_showMessage:_rsp.message];
        }
        
    } errorResponse:^(NSString *error) {
        
    }];
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

- (IBAction)exchangeClickAction:(id)sender
{
    if (self.isCurrentTop) {
        
        [UIView animateWithDuration:0.2f animations:^{
            
            self.startBottomConstraint.constant = -49.5;
            self.endTopConstraint.constant = -49.5;
            [self.searchView layoutIfNeeded];
        }];
        
        
    }
    else{
        
        [UIView animateWithDuration:0.2f animations:^{
            
            self.startBottomConstraint.constant = 0.5;
            self.endTopConstraint.constant = 0.5;
            [self.searchView layoutIfNeeded];
        }];
        
    }
    self.isCurrentTop = !self.isCurrentTop;
    
    if (self.choosefrom == 2) {
        
        if (self.isCurrentTop) {
            [self.topBtn setImage:[UIImage imageNamed:@"route_green_icon"] forState:UIControlStateNormal];
            [self.bottomBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
        }
        else{
            [self.topBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
            [self.bottomBtn setImage:[UIImage imageNamed:@"route_red_icon"] forState:UIControlStateNormal];
        }
    }
    else{
        
        if (self.isCurrentTop) {
            
            [self.topBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
            [self.bottomBtn setImage:[UIImage imageNamed:@"route_red_icon"] forState:UIControlStateNormal];

        }
        else{
            [self.topBtn setImage:[UIImage imageNamed:@"route_green_icon"] forState:UIControlStateNormal];
            [self.bottomBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.suggestionResut.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.reloadState == 1) {
        return 198.0f;
    }
    return 90.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.reloadState == 0) {
        
        RouteHistoryTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RouteHistoryTabCell"];
        
        [cell.iconImageView setImage:[UIImage imageNamed:@"route_history_icon"]];
//        [cell.nameLabel setText:@"国际科技园"];
//        [cell.addressLabel setText:@"江苏省苏州市工业园区金鸡湖大道2135号"];
        QMSSuggestionPoiData *poi = [self.suggestionResut.dataArray objectAtIndex:[indexPath row]];
        
        [cell.nameLabel setText:poi.title];
        [cell.addressLabel setText:poi.address];

        
        
        return cell;
    }
    else{
        
        RouteBusTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RouteBusTabCell"];
        
//        [cell.iconImageView setImage:[UIImage imageNamed:@"route_history_icon"]];
//        [cell.nameLabel setText:@"国际科技园"];
//        [cell.addressLabel setText:@"江苏省苏州市工业园区金鸡湖大道2135号"];
        
        cell.routeBuyBlock = ^{
            
            TicketChooseVC *vc = [[TicketChooseVC alloc]initWithNibName:@"TicketChooseVC" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        
        return cell;
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.reloadState == 0) {
        self.reloadState = 1;
        [tableView reloadData];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//要求委托方的编辑风格在表视图的一个特定的位置。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.reloadState == 0) {
        
        return UITableViewCellEditingStyleDelete;
        
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        
            
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
