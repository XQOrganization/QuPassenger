//
//  BaseNavigationController.m
//  Entertainment_App
//
//  Created by 朱青 on 2016/10/13.
//  Copyright © 2016年 Entertainment. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:HEXCOLOR(@"404040")};
    
    //去除导航栏下方的横线
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, 64)]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
 
    [super pushViewController:viewController animated:animated];
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
