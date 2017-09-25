//
//  MainViewController.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [leftBtn setImage:[UIImage imageNamed:@"main_person_icon"] forState:UIControlStateNormal];
    [self setLeftBarItemWithButton:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [rightBtn setImage:[UIImage imageNamed:@"main_message_icon"] forState:UIControlStateNormal];
    [self setRightBarItemWithButton:rightBtn];
    
    self.title = @"苏州市";
}

#pragma mark btnClickAction
- (void)leftBarButtonItemAction:(id)sender
{
    [self presentLoginWithComplection:nil];
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
