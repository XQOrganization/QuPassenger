//
//  BasicVC.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/1.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "BasicVC.h"

@interface BasicVC ()<UIGestureRecognizerDelegate>

@end

@implementation BasicVC

+ (BaseNavigationController *)navigationControllerContainSelf
{
    id vc = [[[self class] alloc]init];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[IQKeyboardManager sharedManager]setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar=NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @" ";
    UIImage *image = [UIImage imageNamed:@"tool_back"];
    [backItem setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [backItem setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = backItem;
    
    [self.view setBackgroundColor:COLOR_BACK];

//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

- (void)setBarItemWithLeftButton:(NSObject *)left rightButton:(NSObject *)right
{
    if (left) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, 24, 24)];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [btn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        [self.navigationItem setLeftBarButtonItem:item];
        
    }
    if (right) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, 24, 24)];
        if ([right isKindOfClass:[UIImage class]]) {
            [btn setImage:(UIImage *)right forState:UIControlStateNormal];
//            [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        }
        else{
            [btn setTitle:(NSString *)right forState:UIControlStateNormal];
            [btn.titleLabel setShadowColor:[UIColor blackColor]];
            [btn.titleLabel setShadowOffset:CGSizeMake(1, 1)];
        }
        [btn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        [self.navigationItem setRightBarButtonItem:item];
    }
    
}

- (void)leftBarButtonItemAction:(id)sender{}

- (void)rightBarButtonItemAction:(id)sender{}

#pragma mark 弹出登陆页面
- (void)presentLoginWithComplection:(void(^)(void))complectionBlock
{
//    BaseNavigationController *nav = [LoginViewController navigationControllerContainSelf];
//    LoginViewController *controller = nav.viewControllers[0];
//    controller.loginCompletionBlock = complectionBlock;
//    [self presentViewController:nav animated:YES completion:nil];
    
}


#pragma mark 根据t_id和url跳转
- (void)jumpWithTid:(NSInteger)eventId url:(NSString *)params
{
    
//    switch (eventId) {
//            
//        case 1:{
//            //url传的是分类
//            GoodsListVC *vc = [[GoodsListVC alloc]initWithNibName:@"GoodsListVC" bundle:nil];
//            vc.menuId = params;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//            
//        case 2:{
//            //url传的是搜索关键字
//            GoodsListVC *vc = [[GoodsListVC alloc]initWithNibName:@"GoodsListVC" bundle:nil];
//            vc.keyWords = params;
//            [self.navigationController pushViewController:vc animated:YES];
//           
//        }
//            break;
//            
//        case 3:{
//            //商品详情单品唯一id
//            GoodsDetailVC *vc = [[GoodsDetailVC alloc]initWithNibName:@"GoodsDetailVC" bundle:nil];
//            vc.goodsId = params;
//            [self.navigationController pushViewController:vc animated:YES];
//            
//        }
//            break;
//        case 4:{
//            //单页广告页
//            MainAdvertiseViewController *vc = [MainAdvertiseViewController new];
//            vc.adId = params;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//            
//        case 5:{
//            //webView
//            CommonWebViewController *vc = [[CommonWebViewController alloc]initWithNibName:@"CommonWebViewController" bundle:nil];
//            vc.webUrl = params;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//            
//        case 6:{
//            //app中一些跳转
//            switch ([params integerValue]) {
//                case 1:{
//                    //我的订单
//                    if (!ACCOUNTINFO.isLogin) {
//                        [self presentLoginWithComplection:nil];
//                        return;
//                    }
//                    MyOrderVC *vc = [[MyOrderVC alloc]init];
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//                    break;
//                    
//                case 2:{
//                    //轻松退货
//                    if (!ACCOUNTINFO.isLogin) {
//                        [self presentLoginWithComplection:nil];
//                        return;
//                    }
//                    MainRefundVC *vc = [[MainRefundVC alloc]init];
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//                    break;
//                    
//                case 3:{
//                    //签到送积分
//                    if (!ACCOUNTINFO.isLogin) {
//                        [self presentLoginWithComplection:nil];
//                        return;
//                    }
//                    [self requestSignForScore];
//                }
//                    break;
//                    
//                case 4:{
//                    
//                    //充值
//                    MainRechargeVC *vc = [[MainRechargeVC alloc]initWithNibName:@"MainRechargeVC" bundle:nil];
//                    
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//                    break;
//                    
//                default:
//                    break;
//            }
//        }
//            break;
//            
//        default:
//            [MBHudHelper tipMessage:@"抱歉，暂不支持此功能"];
//            break;
//    }
    
    //    NSLog(@"协议号--- %ld",eventId);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"Release---- %@",NSStringFromClass([self class]));
}

@end
