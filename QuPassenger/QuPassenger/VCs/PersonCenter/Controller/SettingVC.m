//
//  SettingVC.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *titleArr;
    
}
    @property (weak, nonatomic) IBOutlet UITableView *settingTableView;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    titleArr = @[@[@"上下班地址设置",@"紧急联系人"],@[@"密码",@"更换手机号"],@[@"版本更新",@"关于我们"]];
    
}
- (void)setNavItem{
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    bar.title= @"设置";
    self.quNavBar = bar;
    self.settingTableView.backgroundColor = HEXCOLOR(@"#f2f2f2");
    self.settingTableView.rowHeight = 50;
    self.settingTableView.tableFooterView = [self tableFootView];

}
- (UIView *)tableFootView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.backgroundColor = [UIColor whiteColor];
    but.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [but setTitle:@"退出登录" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(logOutClick:) forControlEvents:UIControlEventTouchUpInside];
    [but setTitleColor:HEXCOLOR(@"#FF0030") forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [view addSubview:but];
    return but;
}
    //MARK:-----退出登录
- (void)logOutClick:(UIButton *)sender{
    
    UIAlertController * altController = [UIAlertController alertControllerWithTitle:@"是否退出账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [altController addAction:cancelAction];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        [cancelAction setValue:[UIColor grayColor] forKey:@"titleTextColor"];
    }
    UIAlertAction * yesAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self logOut];
    }];
    
    [altController addAction:yesAction];
    [self presentViewController:altController animated:YES completion:nil];
   
}
- (void)logOut{
    ACCOUNTINFO.userInfo = nil;
    ACCOUNTINFO.isLogin = NO;
    [self goMainVc:nil];
  
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = HEXCOLOR(@"#f2f2f2");
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = HEXCOLOR(@"#f2f2f2");
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr =titleArr[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [cell.textLabel setTextColor:HEXCOLOR(@"#404040")];
    cell.textLabel.text = titleArr[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


    
@end
