//
//  QuLocationManager.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/28.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "QuLocationManager.h"

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
        
    });
    return shared;
}

- (id)init
{
    self = [super init];
    if(self){
        
        _locationManager = [[TencentLBSLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        //    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
        [_locationManager setApiKey:TencentAppKey];
        [_locationManager setRequestLevel:TencentLBSRequestLevelPoi];
        
        CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
        if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
            [_locationManager requestWhenInUseAuthorization];
        }
        
        
    }
    return self;
}

- (void)startUpdatingLocationWithSuccess:(void(^)(TencentLBSLocation *lbsLocation))successBlock fail:(void(^)(void))failBlock {
    
    [self.locationManager startUpdatingLocation];
    
    self.locationSuccessBlock = successBlock;
    self.locationFailBlock = failBlock;
    
    self.isLocating = YES;

}

#pragma mark - TencentLBSLocationManagerDelegate
- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager
                 didFailWithError:(NSError *)error {
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted) {
        NSLog(@"定位权限未开");
        
    }
    else {
        NSLog(@"定位失败");
    }
    self.isLocating = NO;
    [self.locationManager stopUpdatingLocation];
    if (self.locationFailBlock) {
        self.locationFailBlock();
    }
}

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager
                didUpdateLocation:(TencentLBSLocation *)location {
    
    [self.locationManager stopUpdatingLocation];
    
    self.lbsLocation = location;
    NSLog(@"%@, %@, %@", location.location, location.name, location.address);
    
    self.isLocating = NO;
    
    self.latitude = [NSString stringWithFormat:@"%f",location.location.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f",location.location.coordinate.longitude];
    
    QuCityModel *cityModel = [[QuCityModel alloc]init];
    cityModel.cityName = [location.city replace:@"市" withString:@""];
    cityModel.cityCode = [[QuDBManager shareDataManger]getTheCityCodeWithCityName:cityModel.cityName];
    cityModel.provinceCode = [[QuDBManager shareDataManger]getTheProvinceCodeWithCityName:cityModel.cityName];
    self.locationCityModel = cityModel;
    
    if (self.locationSuccessBlock) {
        self.locationSuccessBlock(location);
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:LOCATION_SUCCESS_NOTIFICATION object:nil];
}


@end
