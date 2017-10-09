//
//  MyWalletTableViewController.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/9/30.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "MyWalletTableViewController.h"

@interface MyWalletTableViewController ()
@property(nonatomic,strong)UIButton *markBtn;
@end

@implementation MyWalletTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)picBtnClick:(UIButton *)sender {

    if (sender !=_markBtn) {
        _markBtn.layer.borderColor = [HEXCOLOR(@"#DBDBDB")CGColor];
        [_markBtn setTitleColor:HEXCOLOR(@"##404040") forState:UIControlStateNormal];
        sender.layer.borderColor = [HEXCOLOR(@"#FF5C41")CGColor];
        [sender setTitleColor:HEXCOLOR(@"#FF5C41") forState:UIControlStateNormal];
    }
    _markBtn = sender;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0.1;
}
@end
