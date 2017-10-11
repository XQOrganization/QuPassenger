//
//  CustomerServiceVC.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/11.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "CustomerServiceVC.h"

@interface CustomerServiceVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *titleArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CustomerServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    titleArr = @[@[@"常见问题",@"微巴班线问题",@"摆渡车问题",@"拼车问题",@"购票问题",@"支付问题",@"乘车问题"],@[@"反馈与建议"],@[@"服务热线"]];
}
- (void)setNavItem{
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    bar.title= @"设置";
    self.quNavBar = bar;
    self.tableView.backgroundColor = HEXCOLOR(@"#f2f2f2");
    self.tableView.rowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = HEXCOLOR(@"#f2f2f2");
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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

    [cell.textLabel setTextColor:HEXCOLOR(@"#404040")];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    cell.textLabel.text = titleArr[indexPath.section][indexPath.row];
    if (indexPath.row == 0) {
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
        if (indexPath.section == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
      
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
