//
//  Constants.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define  IS_DEBUG       YES

//在release版本禁止输出NSLog内容
//发布版本时注释#define IOS_DEBUG
#define IOS_DEBUG
#ifdef IOS_DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)

#else
#define NSLog(...){}

#endif
//在release版本切换服务器地址


#import "AFNetworking.h"
#import "UIColor+HEX.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "ThirdApiManager.h"
#import "WZLBadgeImport.h"
#import "IQKeyboardManager.h"
#import "NSString+Help.h"
#import "NetWorkRequestModel.h"
#import "AccountInfo.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "PublicManager.h"
#import "LocalDataModel.h"
#import "CHAlertView.h"
#import "QuHudHelper.h"
#import "BaseNavigationController.h"
#import "BaseWebViewController.h"
#import "LoginViewController.h"
#import "NetWorkReqManager.h"
#import "UITextField+Help.h"
#import "UIImage+Help.h"
#import "UIView+Help.h"
#import <SVProgressHUD.h>
#import <QMapKit/QMapKit.h>
#import <QMapSearchKit/QMapSearchKit.h>
#import "QuDBManager.h"
#import "QuLocationManager.h"

#define ScreenWidthRatio [[UIScreen mainScreen] bounds].size.width/375

//防止block里引用self造成循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//RGB取色值
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//十六进制取色值
#define HEXCOLOR(value)  [UIColor colorWithHexString:value]

//主题色
#define COLOR_THEME HEXCOLOR(@"00a653")
//背景色
#define COLOR_BACK  HEXCOLOR(@"f6f6f6")
//字体大小
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]

//腾讯地图AppKey
#define TencentAppKey @"XSBBZ-ZQMC6-MVBSX-MKZBR-K3D46-JOF6Q"

//当前屏幕大小
#define SCREEN_SIZE   [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

#define BUNDLE_ID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define CLIENT_VERSION [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]

#define APP_VERCODE_LIMIT 60

#define ACCOUNTINFO [AccountInfo shareRsp]

//==================支付宝支付===================
#define ALI_PARTNER                                  @"2016082401793923"
#define ALI_SELLTER                                  @"2088421321062320"
#define ALI_PRIVATE_KEY                           @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMVw0C9WBb6XLvlKuXn4qc60xMTAQscKG0itl8kLD7VjClTAA7XXhoB5tp8zw1uI8Lwki7YGAz/VF3vjmrShlwT+aL01rX+mEQd/5R2wyZPCJhcRa+IdJZ1DA8kbS2ZYw5aHtfJzKIbQ4k/a/ULYK/XGLlv2lO3ifEvqeUXHLT2RAgMBAAECgYB0U+yFB0TpL0Ag5xLytzytKjqIxdJSXTUIFCdK73Z443qRxnQpLmvzxEKB+EiQ5NUZtNqQC2jcshtdBhP/evlzkKr4jsfDY5c/pJKhqspWO0ZR6vyfswbwBqOlIevBeBdokmNg9sqXhP1J7x/AaZiump0Drviq6JeUfVYRfjh7xQJBAPcO4lelL3T2A2pziRyG+DAyX+dFWe24EUKRTRJZI64LmH2DlTSvgYeNZALqemPWGTnhrvoFdMxCEOmzYh7/2uMCQQDMljLfx9fS4/rL5X7uBABhVNQwMzQqvjSuqArTZ3DwGfHQzwhp14BM3C9QTvxKj1CYgER/478QSKnITXH3NKv7AkApG+/rt4/K/XiaCPmCpq67jlZI7FBHbv5oPjc921lFh6ZrFC8Koj2CabN/jLaq0CBIclYkQi4qIsAfsvqbv+UTAkBetlovB1F/LFP6+O/eOLQEW0UwW0QXVZ8GDH2WiRjbzucICBCZD08yRe0RfL+HtPlW4GrV2hWl8D3JoTDVhOjpAkEAoWK7c2CcU6PMUPanXng51KaFe2cOMYbv9r56VCSbt0gNlBRVDQy/pkW+V7qKNPZ0nmr+BzlaaK6kE7NfxJ7t+g=="

#define ALI_CALLBACK_URL                             @"http://121.40.216.91:8080/notify_url.jsp"
//==============================================

//判断是否大于ios几
#define IOS(a) ([[[UIDevice currentDevice] systemVersion] floatValue] >= a)

#define LOCATION_SUCCESS_NOTIFICATION  @"LOCATION_SUCCESS_NOTIFICATION"
#define TABBAR_BADGE_NOTIFICATION  @"TABBAR_BADGE_NOTIFICATION"

#endif /* Constants_h */
