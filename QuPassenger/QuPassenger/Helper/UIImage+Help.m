//
//  UIImage+Help.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/22.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "UIImage+Help.h"

@implementation UIImage (Help)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        return img;
        
    }
}

@end
