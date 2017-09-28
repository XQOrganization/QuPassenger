//
//  QuLocationManager.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/28.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "QuLocationManager.h"
#import <TencentLBS/TencentLBS.h>

@interface QuLocationManager ()<TencentLBSLocationManagerDelegate>

@property (strong, nonatomic) TencentLBSLocationManager *locationManager;

@end

@implementation QuLocationManager

+ (QuLocationManager *)shareManager
{
    static dispatch_once_t pred;
    static QuLocationManager *shared = nil;
    dispatch_once(&pred, ^{
        
        shared = [[self alloc]init];
        [shared configLocationManager];
    });
    return shared;
}

- (void)configLocationManager {
    
    self.locationManager = [[TencentLBSLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    [self.locationManager setApiKey:TencentAppKey];
    [self.locationManager setRequestLevel:TencentLBSRequestLevelPoi];
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)startUpdatingLocation {
//    [self.locationManager startUpdatingLocation];
    
    [self.locationManager requestLocationWithCompletionBlock:
     ^(TencentLBSLocation *location, NSError *error) {
         NSLog(@"%@, %@, %@, %@", location.code, location.name, location.address, location.city);
    
     }];
}

#pragma mark - TencentLBSLocationManagerDelegate
- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager
                 didFailWithError:(NSError *)error {
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位权限未开启，是否开启？" preferredStyle:  UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            if( [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]] ) {
//#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}completionHandler:^(BOOL success) {
//                }];
//#elif __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//#endif
//            }
//        }]];
//        
//        [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }]];
//        
//        [self presentViewController:alert animated:true completion:nil];
        
    }
    else {
        
    }
}

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager
                didUpdateLocation:(TencentLBSLocation *)location {
    
    NSLog(@"%@, %@, %@", location.location, location.name, location.address);
}


@end
