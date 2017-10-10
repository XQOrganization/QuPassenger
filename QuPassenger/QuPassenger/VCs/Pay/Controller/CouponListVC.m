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
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponListCell *cell =[tableView dequeueReusableCellWithIdentifier:@"couponCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CouponListCell" owner:nil options:nil][0];
    }
    return cell;
}
@end
