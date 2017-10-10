//
//  PayTheTicketVC.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "PayTheTicketVC.h"
#import "PayTheTicketCell.h"
#import "CouponListVC.h"
@interface PayTheTicketVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UIButton *markBtn;


@end

@implementation PayTheTicketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
}
- (void)setNavItem{
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    bar.title = @"支付";
    self.quNavBar = bar;
    self.tableView.backgroundColor = HEXCOLOR(@"#f2f2f2");
    self.tableView.tableFooterView = [self loadtableFootView];
    
}
-(UIView *)loadtableFootView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 143)];
    view.backgroundColor = HEXCOLOR(@"#f2f2f2");
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 134, SCREEN_WIDTH, 14);
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:@"支付即表示同意《趣约车服务协议及隐私条款》"];
  //按钮富文本
    NSDictionary *attrDic = @{
                              NSFontAttributeName: [UIFont fontWithName: @"PingFangSC-Medium" size: 10],
                              NSForegroundColorAttributeName: HEXCOLOR(@"#FF5C41")
                              };
    [attributedStr setAttributes:attrDic range:NSMakeRange(7,14)];

    [but setAttributedTitle:attributedStr forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    but.titleLabel.textColor = HEXCOLOR(@"#B3B3B3");
    
    UIButton *goPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goPayBtn addTarget:self action:@selector(goPayClick:) forControlEvents:UIControlEventTouchUpInside];
    goPayBtn.clipsToBounds = YES;
    goPayBtn.layer.cornerRadius = 2;
    goPayBtn.frame = CGRectMake(10, 70,SCREEN_WIDTH - 20 , 44);
    [goPayBtn setTitle:@"去支付" forState:UIControlStateNormal];
    goPayBtn.backgroundColor = HEXCOLOR(@"#FFFF5C41");
    [goPayBtn setTitleColor:HEXCOLOR(@"#FFFFFFFF") forState:UIControlStateNormal];
    goPayBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [view addSubview:but];
    [view addSubview:goPayBtn];
    
    return view;
}
//MARK----去支付
- (void)goPayClick:(id)sender{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 0.01;
    }
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 3;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayTheTicketCell * cell = [tableView dequeueReusableCellWithIdentifier:@"payCell"];
    
    if (indexPath.section == 0) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"PayTheTicketCell" owner:nil options:nil][0];
    }else if (indexPath.section == 1){
        cell = [[NSBundle mainBundle]loadNibNamed:@"PayTheTicketCell" owner:nil options:nil][1];
        if (indexPath.row == 0) {
            cell.ibChoosePayTypeBtn.selected = YES;
            _markBtn = cell.ibChoosePayTypeBtn;
        }
        [cell.ibChoosePayTypeBtn addTarget:self action:@selector(choosePayTypeBtn:) forControlEvents:UIControlEventTouchUpInside];
        NSArray *arr = @[@"微信支付",@"支付宝支付",@"余额支付"];
        cell.ibPayTypeIConImg.image = [UIImage imageNamed:arr[indexPath.row]];
        cell.ibPayTypeLab.text = arr[indexPath.row];
        if (indexPath.row == 2) {
            cell.ibBalanceLab.text = @"余额：0.00元";
        }
        
    }else{
         cell = [[NSBundle mainBundle]loadNibNamed:@"PayTheTicketCell" owner:nil options:nil][2];
    }
  
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        //查看优惠券
        CouponListVC *vc = [[CouponListVC alloc]initWithNibName:@"CouponListVC" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)choosePayTypeBtn:(UIButton *)sender{
    sender.selected = YES;
    if (sender !=_markBtn) {
        _markBtn.selected = NO;
        sender.selected = YES;
    }
    _markBtn = sender;
}
@end
