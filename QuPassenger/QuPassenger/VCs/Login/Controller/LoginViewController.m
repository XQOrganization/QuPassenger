//
//  LoginViewController.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "LoginViewController.h"
#import "WXRegistViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ibPhoneTf;
@property (weak, nonatomic) IBOutlet UITextField *ibCodeTf;
@property (weak, nonatomic) IBOutlet UIButton *ibLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *ibGetCodeBtn;
@property (strong, nonatomic) dispatch_source_t timer;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
    [self setLeftBarItemWithButton:leftBtn];
    
    [_ibPhoneTf addTarget:self action:@selector(phoneTfChange) forControlEvents:UIControlEventEditingChanged];
    _ibPhoneTf.clearButtonMode=UITextFieldViewModeWhileEditing;
//    _ibPhoneTf.tintColor = HEXCOLOR(@"#FF5C41");
    
    [_ibCodeTf addTarget:self action:@selector(codeTfChange) forControlEvents:UIControlEventEditingChanged];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
}

- (void)phoneTfChange{
  
    if (_ibPhoneTf.text.length >11) {
        [QuHudHelper sv_showErrorWithStatus:@"手机号码超出范围"];
        [_ibPhoneTf endEditing:YES];
        _ibPhoneTf.text = [_ibPhoneTf.text substringToIndex:11];
        
    }
}
- (void)codeTfChange{
    
    if (_ibCodeTf.text.length > 4) {
       
        _ibLoginBtn.backgroundColor = HEXCOLOR(@"#FF5C41");
    }else{
        _ibLoginBtn.backgroundColor = HEXCOLOR(@"#DBDBDB");

    }
}
//微信登录操作
- (IBAction)wechatLoginBtnClick:(id)sender {
    
    WS(weakSelf)
    [[ThirdApiManager shareManager]getThirdUserInfoCompletion:^(NSString *uid) {
        
        WXRegistViewController *vc = [[WXRegistViewController alloc]initWithNibName:@"WXRegistViewController" bundle:nil];
        [weakSelf.navigationController pushViewController:vc animated:YES];

    }];
}
//获取验证码
- (IBAction)getCodeBtnClick:(id)sender {
    //验证手机号码
    if (_ibPhoneTf.text.length != 11) {
   
        [QuHudHelper sv_showErrorWithStatus:@"请输入正确的11位手机号码"];
        return ;
    }
    
    GetCodeReq *req = [[GetCodeReq alloc]init];
    req.phone = _ibPhoneTf.text;
    
    [NetWorkReqManager requestDataWithApiName:getCode params:req response:^(NSDictionary *responseObject) {
        
        [self openCountdown];
        
    } errorResponse:^(NSString *error) {
        
    }];
    
}
//登录方法
- (IBAction)loginBtnClick:(id)sender {
}
// 开启倒计时
-(void)openCountdown{
    
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [_ibGetCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            
                _ibGetCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [_ibGetCodeBtn setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                _ibGetCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
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

//MARK:--------UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)eve{
    [self.view endEditing:YES];
}
@end
