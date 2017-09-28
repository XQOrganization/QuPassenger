//
//  QuLocationManager.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/28.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuLocationManager : NSObject

+ (QuLocationManager *)shareManager;

- (void)startUpdatingLocation;

@end
