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

@property (assign, nonatomic) BOOL isDown;

@property (assign, nonatomic) NSInteger routeNum;

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
    
    self.routeTableView.clipsToBounds = YES;
  
    [self.routeTableView registerNib:[UINib nibWithNibName:@"RouteDetailCell" bundle:nil] forCellReuseIdentifier:@"RouteDetailCell"];
    
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
    [self.routeTableView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
  

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
