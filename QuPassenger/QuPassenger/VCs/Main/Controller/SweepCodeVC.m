//
//  SweepCodeVC.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/16.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "SweepCodeVC.h"
#import "SGQRCodeGenerateManager.h"
#import <MessageUI/MessageUI.h>
@interface SweepCodeVC ()<MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *ibCodeImg;

@end

@implementation SweepCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
}
- (void)setNavItem{
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    bar.title = @"扫码验票";
    _ibCodeImg.image = [SGQRCodeGenerateManager generateWithDefaultQRCodeData:@"33adddd" imageViewWidth:200 ];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:@"route_share_icon"] forState:UIControlStateNormal];
    bar.rightView = btn;
 
}
//发送短信二维码
- (IBAction)sendMessageBtnClick:(id)sender {
    [self showMessageView:@[] title:@"购票二维码" body:@"购票二维码:XQ6666"];
    
}
//MARK:-----MFMessageComposeViewControllerDelegate{
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
