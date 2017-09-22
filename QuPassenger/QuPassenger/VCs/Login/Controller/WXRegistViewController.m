//
//  WXRegistViewController.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/9/22.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "WXRegistViewController.h"
@interface WXRegistViewController ()

@end

@implementation WXRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"base_back_icon"] forState:UIControlStateNormal];
    [self setLeftBarItemWithButton:leftBtn];
}
#pragma mark btnClickAction
- (void)leftBarButtonItemAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
