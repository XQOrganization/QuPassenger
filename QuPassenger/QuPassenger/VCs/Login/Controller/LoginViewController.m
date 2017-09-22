//
//  LoginViewController.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ibPhoneTf;
@property (weak, nonatomic) IBOutlet UITextField *ibCodeTf;

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
    
    [_ibPhoneTf addTarget:self action:@selector(phoneTfChange) forControlEvents:UIControlEventEditingChanged];
    [_ibCodeTf addTarget:self action:@selector(codeTfChange) forControlEvents:UIControlEventEditingChanged];

}
- (void)phoneTfChange{
    if (_ibPhoneTf.text.length > 1) {
        
    }
    if (_ibPhoneTf.text.length >11) {
    
        [QuHudHelper sv_showErrorWithStatus:@"手机号码超出范围"];
    }
}
- (void)codeTfChange{
    
    if (_ibPhoneTf.text.length != 11) {
   
        [QuHudHelper sv_showErrorWithStatus:@"请输入正确的11位手机号码"];
        return ;
    }
}
//获取验证码
- (IBAction)getCodeBtnClick:(id)sender {
}
//登录方法
- (IBAction)loginBtnClick:(id)sender {
}

#pragma mark btnClickAction
- (void)leftBarButtonItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBarButtonItemAction:(id)sender
{
    [[ThirdApiManager shareManager]getThirdUserInfoCompletion:^(NSString *uid) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK:--------UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)eve{
    [self.view endEditing:YES];
}
@end
