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

@end

@implementation WXRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
    [self setLeftBarItemWithButton:leftBtn];
    
    [_ibPhoneTf addTarget:self action:@selector(phoneTfChange) forControlEvents:UIControlEventEditingChanged];
    _ibPhoneTf.clearButtonMode=UITextFieldViewModeWhileEditing;
    [_ibCodeTf addTarget:self action:@selector(codeTfChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)phoneTfChange{
    
    if (_ibPhoneTf.text.length >11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码超出范围"];
        [_ibPhoneTf endEditing:YES];
        _ibPhoneTf.text = [_ibPhoneTf.text substringToIndex:11];
        [SVProgressHUD dismissWithDelay:1];
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
        
        [QuHudHelper sv_showErrorWithStatus:@"请输入正确的11位手机号码"];
        return ;
    }
    [self openCountdown];
}
//确认
- (IBAction)sureClick:(id)sender {
}
// 开启倒计时
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)even{
    [self.view endEditing:YES];
}
@end
