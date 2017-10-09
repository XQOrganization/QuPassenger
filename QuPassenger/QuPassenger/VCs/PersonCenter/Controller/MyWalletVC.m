//
//  MyWalletVC.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/9.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "MyWalletVC.h"
#import "MyWalletTableViewCell.h"
@interface MyWalletVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myWalletTabView;

@end

@implementation MyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义导航栏
    [self setNavItem];
   //TabFootView
    _myWalletTabView.tableFooterView = [self tableFootView];

}
- (void)setNavItem{
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setTitle:@"明细" forState:UIControlStateNormal];
    [rightBtn setTitleColor:HEXCOLOR(@"#404040") forState:UIControlStateNormal];
   rightBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [rightBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.quNavBar.rightView = rightBtn;
}
-(UIView *)tableFootView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 143)];
    view.backgroundColor = HEXCOLOR(@"#f2f2f2");
    self.myWalletTabView.backgroundColor = HEXCOLOR(@"#f2f2f2");
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 10, 10)];
    img.image = [UIImage imageNamed:@"i8 提示"];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(30, 12, 90, 10);
    [but setTitle:@"钱包常见问题及规则" forState:UIControlStateNormal];
    [but setTitleColor:HEXCOLOR(@"#777777") forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    
    UIButton *goRechargeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [goRechargeBut addTarget:self action:@selector(goRechargeButClick) forControlEvents:UIControlEventTouchUpInside];
    goRechargeBut.clipsToBounds = YES;
    goRechargeBut.layer.cornerRadius = 2;
    goRechargeBut.frame = CGRectMake(10, view.mj_size.height -54,SCREEN_WIDTH - 20 , 44);
    [goRechargeBut setTitle:@"充值" forState:UIControlStateNormal];
    goRechargeBut.backgroundColor = HEXCOLOR(@"#FFFF5C41");
    [goRechargeBut setTitleColor:HEXCOLOR(@"#FFFFFFFF") forState:UIControlStateNormal];
    goRechargeBut.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    [view addSubview:img];
    [view addSubview:but];
    [view addSubview:goRechargeBut];
    
    return view;
}
- (void)rightBarButtonItemAction:(id)sender{
    
}
//去充值
-(void)goRechargeButClick{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }
    return 320;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyWalletCell"];
  
    if (indexPath.section == 0) {
        cell =[[NSBundle mainBundle]loadNibNamed:@"MyWalletTableViewCell" owner:nil options:nil][0];
    }else if (indexPath.section  ==1){
        cell =[[NSBundle mainBundle]loadNibNamed:@"MyWalletTableViewCell" owner:nil options:nil][1];
    }
   //选择金额block
    cell.picBlock = ^(NSInteger pic) {
        
    };
    //支付方式block
    cell.PayTypeBlock = ^(NSInteger payType) {
       
   };
    return cell;
}


@end
