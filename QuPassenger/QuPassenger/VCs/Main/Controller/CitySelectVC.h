//
//  CitySelectVC.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/30.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "BasicVC.h"

@interface CitySelectVC : BasicVC

@property (copy, nonatomic) void (^selectCityBlock)(QuCityModel *model);

@end
