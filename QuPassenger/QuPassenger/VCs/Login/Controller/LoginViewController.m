//
//  LoginViewController.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
    [self setLeftBarItemWithButton:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 22)];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [rightBtn setTitleColor:HEXCOLOR(@"404040") forState:UIControlStateNormal];
    [rightBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    [self setRightBarItemWithButton:rightBtn];

}

#pragma mark btnClickAction
- (void)leftBarButtonItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBarButtonItemAction:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
