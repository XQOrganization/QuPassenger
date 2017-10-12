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

    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
 
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.quNavBar.leftView = leftBtn;
    
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

#pragma mark Request
//获取验证码
- (void)requestVertrifyCode
{
    GetCodeReq *req = [[GetCodeReq alloc]init];
    req.phone = _ibPhoneTf.text;
    
    [NetWorkReqManager requestDataWithApiName:getCode params:req response:^(NSDictionary *responseObject) {
        
        BaseResponse *rsp = [BaseResponse mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            [self openCountdown];
        }
        else{
            [QuHudHelper qu_showMessage:rsp.message];
        }
        
    } errorResponse:^(NSString *error) {
        
        
    }];
}

//验证码登录
- (void)requestVertrifyLogin
{
    CheckCodeReq *req = [[CheckCodeReq alloc]init];
    req.phone = _ibPhoneTf.text;
    req.code = _ibCodeTf.text;
    
    [NetWorkReqManager requestDataWithApiName:checkCode params:req response:^(NSDictionary *responseObject) {
        
        CheckCodeRsp *rsp = [CheckCodeRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            ACCOUNTINFO.isLogin = YES;
            ACCOUNTINFO.userInfo = rsp.data;
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            [QuHudHelper qu_showMessage:rsp.message];
        }
        
    } errorResponse:^(NSString *error) {
        
        
    }];

}

//微信登录
- (void)requestWXLoginWithUid:(NSString *)uid nickName:(NSString *)nickName headUrl:(NSString *)headUrl
{
    BindWeChatReq *req = [[BindWeChatReq alloc]init];
    req.winXinKey = uid;
    req.phone = @"";
    req.nick = @"";
    req.headImage = @"";
    
    [NetWorkReqManager requestDataWithApiName:bindWeChat params:req response:^(NSDictionary *responseObject) {
        
        BindWeChatRsp *rsp = [BindWeChatRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            ACCOUNTINFO.isLogin = YES;
            ACCOUNTINFO.userInfo = rsp.data;
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        else if (rsp.code == 3){
            
            WXRegistViewController *vc = [[WXRegistViewController alloc]initWithNibName:@"WXRegistViewController" bundle:nil];
            vc.wxUid = uid;
            vc.nickName = nickName;
            vc.imageUrl = headUrl;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else{
            [QuHudHelper qu_showMessage:rsp.message];
        }
        
        
    } errorResponse:^(NSString *error) {
        
        
    }];

}


- (void)phoneTfChange{
  
    if (_ibPhoneTf.text.length >11) {
        [QuHudHelper qu_showMessage:@"手机号码超出范围"];
        [_ibPhoneTf endEditing:YES];
        _ibPhoneTf.text = [_ibPhoneTf.text substringToIndex:11];
        
    }
    if (_ibPhoneTf.text.length == 11) {
        [_ibGetCodeBtn setTitleColor:HEXCOLOR(@"#FF5C41") forState:UIControlStateNormal];
    }
}
- (void)codeTfChange{
    
    if (_ibCodeTf.text.length > 3) {
       
        _ibLoginBtn.backgroundColor = HEXCOLOR(@"#FF5C41");
    }else{
        _ibLoginBtn.backgroundColor = HEXCOLOR(@"#DBDBDB");

    }
}
//微信登录操作
- (IBAction)wechatLoginBtnClick:(id)sender {
    
    WS(weakSelf)
    [[ThirdApiManager shareManager]getThirdUserInfoCompletion:^(NSString *uid,NSString *nickName,NSString *headUrl) {
        
        [weakSelf requestWXLoginWithUid:uid nickName:nickName headUrl:headUrl];

    }];
}
//获取验证码
- (IBAction)getCodeBtnClick:(id)sender {
    //验证手机号码
    if (_ibPhoneTf.text.length != 11) {
   
        [QuHudHelper qu_showMessage:@"请输入正确的11位手机号码"];
        return ;
    }
    
    [self requestVertrifyCode];
    
    
}
//登录方法
- (IBAction)loginBtnClick:(id)sender {
    
    [self requestVertrifyLogin];
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

- (IBAction)protocalClickAction:(id)sender
{
    BaseWebViewController *vc = [[BaseWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
