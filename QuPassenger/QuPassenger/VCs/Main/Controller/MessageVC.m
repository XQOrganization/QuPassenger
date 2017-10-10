//
//  MessageVC.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/10.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "MessageVC.h"
#import "MessgeCell.h"
@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *messagetableView;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
}
- (void)setNavItem{
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    bar.title= @"消息";
    self.quNavBar = bar;
    self.messagetableView.backgroundColor = HEXCOLOR(@"#f2f2f2");
    self.messagetableView.tableFooterView = [UIView new];
    self.messagetableView.rowHeight = 208;
    self.messagetableView.separatorStyle =NO;

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessgeCell *cell =[tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    if (cell == nil) {
        cell =[[NSBundle mainBundle]loadNibNamed:@"MessgeCell" owner:nil options:nil][0];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
