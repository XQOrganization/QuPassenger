//
//  WXRegistViewController.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/9/22.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "WXRegistViewController.h"
@interface WXRegistViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ibWxUserIconImg;
@property (weak, nonatomic) IBOutlet UITextField *ibPhoneTf;
@property (weak, nonatomic) IBOutlet UITextField *ibCodeTf;
@property (weak, nonatomic) IBOutlet UIButton *ibGetCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *ibSureBtn;

@property (strong, nonatomic) dispatch_source_t timer;

@end

@implementation WXRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    
    [_ibPhoneTf addTarget:self action:@selector(phoneTfChange) forControlEvents:UIControlEventEditingChanged];
    _ibPhoneTf.clearButtonMode=UITextFieldViewModeWhileEditing;
    [_ibCodeTf addTarget:self action:@selector(codeTfChange) forControlEvents:UIControlEventEditingChanged];
    
    if (self.imageUrl.length > 0) {
        [self.ibWxUserIconImg sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
    }
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
    req.type = 2;
    
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

//微信登录
- (void)requestWXBindLogin
{
    [QuHudHelper mb_loading];
    
    CheckWeChatCodeReq *req = [[CheckWeChatCodeReq alloc]init];
    req.winXinKey = self.wxUid;
    req.phone = self.ibPhoneTf.text;
    req.nick = self.nickName;
    req.headImage = self.imageUrl;
    req.code = self.ibCodeTf.text;
    
    [NetWorkReqManager requestDataWithApiName:checkWeChatCode params:req response:^(NSDictionary *responseObject) {
        
        [QuHudHelper mb_dismiss];
        
        CheckWeChatCodeRsp *rsp = [CheckWeChatCodeRsp mj_objectWithKeyValues:responseObject];
        
        if (rsp.code == 1) {
            
            ACCOUNTINFO.isLogin = YES;
            ACCOUNTINFO.userInfo = rsp.data;
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        else{
            [QuHudHelper qu_showMessage:rsp.message];
        }
        
        
    } errorResponse:^(NSString *error) {
        
        [QuHudHelper mb_dismiss];
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
    }else{
        [_ibGetCodeBtn setTitleColor:HEXCOLOR(@"#DBDBDB") forState:UIControlStateNormal];
    }
}
- (void)codeTfChange{
    
    if (_ibCodeTf.text.length >= 4) {
        
        _ibSureBtn.backgroundColor = HEXCOLOR(@"#FF5C41");
    }else{
        _ibSureBtn.backgroundColor = HEXCOLOR(@"#DBDBDB");
        
    }
}

//获取验证码
- (IBAction)getCodeClick:(id)sender {
    //验证手机号码
    if (_ibPhoneTf.text.length != 11) {
        
        [QuHudHelper qu_showMessage:@"请输入正确的11位手机号码"];
        return ;
    }
    [self requestVertrifyCode];
}
//确认
- (IBAction)sureClick:(id)sender {
    
    [self requestWXBindLogin];

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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even{
    [self.view endEditing:YES];
}


@end
