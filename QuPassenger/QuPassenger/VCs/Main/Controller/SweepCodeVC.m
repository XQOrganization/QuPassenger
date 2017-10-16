//
//  SweepCodeVC.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/16.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "SweepCodeVC.h"
#import "SGQRCodeGenerateManager.h"
@interface SweepCodeVC ()
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
