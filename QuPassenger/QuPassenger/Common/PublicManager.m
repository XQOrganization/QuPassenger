//
//  PublicManager.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/8/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "PublicManager.h"
#import "CHAlertView.h"

/**
 获取字符串value的宽度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param width 限制字符串显示区域的宽度
 @result float 返回的宽度
 */
float HeightForString(NSString *value,float fontSize,float width)
{
    NSMutableParagraphStyle *paragrap = [[NSMutableParagraphStyle alloc]init];
    paragrap.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragrap.copy};
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    //    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    
    return ceil(sizeToFit.height);
}


/**
 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param height 限制字符串显示区域的宽度
 @result float 返回的高度
 */
float WidthForString(NSString *value,float fontSize,float height)
{
    NSMutableParagraphStyle *paragrap = [[NSMutableParagraphStyle alloc]init];
    paragrap.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragrap.copy};
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    //    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    
    return ceil(sizeToFit.width);
}

@implementation PublicManager

+ (NSDictionary *)getMainDataFromLocal
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults objectForKey:@"MainData"];
}

+ (void)saveMainDataToLocalWithDictionary:(NSDictionary *)dictionary
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dictionary forKey:@"MainData"];
    //将数据即时写入
    [userDefaults synchronize];
    
}

+ (void)removeUserLocalToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"MainData"];
    //将数据即时写入
    [userDefaults synchronize];
    
}


+ (BOOL)evenNumberWithNumber:(NSInteger)number
{
    if (number % 2==0) {
        return YES;
    }
    return NO;
}



+(void)showAlert:(NSString *)message
{
    [PublicManager showAlert:message withDoneBlock:nil];
}

+(void)showAlert:(NSString *)message withDoneBlock:(void(^)(void))doneBlock
{
    [CHAlertView showCHAlertViewWithTitle:@"提示" message:message cancleButtonTitle:@"确定" okButtonTitle:nil okClickHandle:nil cancelClickHandle:^{
        if (doneBlock) {
            doneBlock();
        };
    }];
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
   
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

+ (void)callPhoneWithNumber:(NSString *)number
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",number];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    });
    
}

+ (NSString *)base64ImageDataString:(UIImage *)photoImg
{
    CGFloat width = photoImg.size.width;
    CGFloat height = photoImg.size.height;
    if (width > 300 || height > 300) {
        if (width > height) {
            height = height * (300/width);
            width = 300;
        }
        else{
            width = width * (300/height);
            height = 300;
        }
        photoImg = [PublicManager OriginImage:photoImg scaleToSize:CGSizeMake(width, height)];
    }
    NSData *data = UIImageJPEGRepresentation(photoImg, 0.1f);
    NSString *base64DataString = [data base64EncodedString];
    return base64DataString;
}

+ (UIImage *) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
