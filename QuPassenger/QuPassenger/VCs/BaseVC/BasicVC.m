//
//  BasicVC.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/1.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "BasicVC.h"
#import "RouteDetailVC.h"
#import "LoginViewController.h"
#import "MainViewController.h"
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
    UIImage *image = [UIImage imageNamed:@"base_back_icon"];
    [backItem setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [backItem setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0) forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = backItem;
    
//    [self.view setBackgroundColor:COLOR_BACK];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

- (void)setLeftBarItemWithButton:(UIButton *)btn
{
    
    [btn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setLeftBarButtonItem:item];

    
}

- (void)setRightBarItemWithButton:(UIButton *)btn
{
    
    [btn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:item];
    
    
}

- (void)leftBarButtonItemAction:(id)sender{}

- (void)rightBarButtonItemAction:(id)sender{}

#pragma mark 弹出登陆页面
- (void)presentLoginWithComplection:(void(^)(void))complectionBlock
{
    BaseNavigationController *nav = [LoginViewController navigationControllerContainSelf];
//    LoginViewController *controller = nav.viewControllers[0];
//    controller.loginCompletionBlock = complectionBlock;
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (void)goMainVc:(void (^)(void))complectrionBlock{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = [MainViewController navigationControllerContainSelf];
    
}


#pragma mark 根据eventId和params跳转
- (void)jumpWithEventd:(NSInteger)eventId params:(NSString *)params
{
    
    switch (eventId) {
            
        case 0:{
            //不带任务操作
        }
            break;
            
        case 1:{
            //路线详情
            RouteDetailVC *vc = [[RouteDetailVC alloc]initWithNibName:@"GoodsListVC" bundle:nil];
            vc.routeId = params;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2:{
            
            //webView
            BaseWebViewController *vc = [[BaseWebViewController alloc]init];
            vc.url = params;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3:{
            //登录
            [self presentLoginWithComplection:nil];
        }
            break;
            
        default:
            [QuHudHelper qu_showMessage:@"抱歉，暂不支持此功能"];
            break;
    }
    
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
