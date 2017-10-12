//
//  CouponListVC.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "CouponListVC.h"
#import "CouponListCell.h"
@interface CouponListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UIButton *markBtn;

@end

@implementation CouponListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
  
}
- (void)setNavItem{
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    bar.title = @"优惠券";
    self.quNavBar = bar;
    self.tableView.backgroundColor = HEXCOLOR(@"#f2f2f2");
    self.tableView.rowHeight = 120;
    self.tableView.tableFooterView = [self tableFootView];
    self.tableView.separatorStyle = NO;
    
}
-(UIView *)tableFootView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 143)];
    view.backgroundColor = HEXCOLOR(@"#f2f2f2");
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 10, 10)];
    img.image = [UIImage imageNamed:@"i8 提示"];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(25, 12, 100, 10);
    [but setTitle:@"趣约车优惠券使用规则" forState:UIControlStateNormal];
    [but setTitleColor:HEXCOLOR(@"#777777") forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    
    [view addSubview:img];
    [view addSubview:but];
    
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponListCell *cell =[tableView dequeueReusableCellWithIdentifier:@"couponCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CouponListCell" owner:nil options:nil][0];
    }
    
    if (_isChooseCoupon) {
        cell.isChooseCouponBtn.hidden = YES;
    }
    //默认选择第一章优惠券
    if (indexPath.row == 0) {
        cell.isChooseCouponBtn.selected = YES;
        _markBtn = cell.isChooseCouponBtn;
    }
    [cell.isChooseCouponBtn addTarget:self action:@selector(isChooseCouponBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    NSIndexPath *idex = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    CouponListCell *cell = [tableView cellForRowAtIndexPath:idex];
    
    cell.isChooseCouponBtn.selected = YES;
    if (cell.isChooseCouponBtn != _markBtn) {
        _markBtn.selected = NO;
        cell.isChooseCouponBtn.selected = YES;
    }
    _markBtn = cell.isChooseCouponBtn;
    
}
- (void)isChooseCouponBtnClick:(UIButton *)sender{
    sender.selected = YES;
    if (sender != _markBtn) {
        _markBtn.selected = NO;
        sender.selected = YES;
    }
    _markBtn = sender;
}
@end
