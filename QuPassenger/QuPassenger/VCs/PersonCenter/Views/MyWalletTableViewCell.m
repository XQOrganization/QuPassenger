//
//  MyWalletTableViewCell.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/9.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "MyWalletTableViewCell.h"

@interface MyWalletTableViewCell()
@property(nonatomic,strong)UIButton *markBtn;
@property(nonatomic,strong)UIButton *markTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *ibFistPicBtn;
@property (weak, nonatomic) IBOutlet UIButton *ibFistTypeBtn;

@end;
@implementation MyWalletTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _markBtn = _ibFistPicBtn;
    _ibFistTypeBtn.selected = YES;
    _markTypeBtn = _ibFistTypeBtn;
    
}
- (IBAction)picBtnClick:(UIButton *)sender {
    
    if (sender !=_markBtn) {
        _markBtn.layer.borderColor = [HEXCOLOR(@"#DBDBDB")CGColor];
        [_markBtn setTitleColor:HEXCOLOR(@"##404040") forState:UIControlStateNormal];
        sender.layer.borderColor = [HEXCOLOR(@"#FF5C41")CGColor];
        [sender setTitleColor:HEXCOLOR(@"#FF5C41") forState:UIControlStateNormal];
    }
    _markBtn = sender;
    NSInteger pic = [[sender.titleLabel.text substringToIndex:sender.titleLabel.text.length - 1] integerValue];
    _picBlock(pic);
    
}
- (IBAction)payTypeChoose:(UIButton *)sender {
    sender.selected = YES;
    if (sender !=_markTypeBtn) {
        _markTypeBtn.selected = NO;
        sender.selected = YES;
    }
    _markTypeBtn = sender;
    //sender.tag  1:微信  2:支付宝
    _PayTypeBlock(sender.tag);

    
}


@end
