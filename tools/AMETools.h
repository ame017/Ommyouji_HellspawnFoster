//
//  AMETools.h
//
//
//  Created by AME on 16/6/29.
//  Update 16/9/20
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

//官方

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "AppDelegate.h"

//第三方
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
#import <Masonry.h>
#import <SWTableViewCell.h>
#import <AMTagListView.h>
#import <SVProgressHUD.h>
#import <SDCycleScrollView.h>

#import "CHYPorgressImageView.h"
#import "RxWebViewController.h"
#import "RxWebViewNavigationViewController.h"

//自己写的控件
#import "AMELabel.h"
#import "AMEHighLightControl.h"
#import "AMEButton.h"
#import "AMELeftList.h"
#import "AMERightArrowCell.h"
#import "AMESubViewCollection.h"
#import "AMETransitionView.h"
#import "AMEScrollViewController.h"
#import "AMEArrayDataSource.h"
#import "AMETextView.h"

//自己写的工具类
#import "AMELocation.h"
#import "AMECellInfo.h"
#import "NSString+AMEString.h"
#import "AMEArrayDataSource.h"
#import "UINavigationItem+Margin.h"
#import "AMENetWork.h"
#import "AMENetWork+Token.h"

//百度API
#define BAIDU_API_KEY @"74baf29f801a6ed8c1495777c923f374"

#define SEVER_URL @"http://192.168.1.131:8080/"

//字体
#define SYSTEM_BOLD @"Helvetica-Bold"
#define SYSTEM_FONT @"Helvetica"

//颜色相关
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define AME_FILM_TINT UIColorFromRGB(0xAB4F6C)
#define DARK_BlACK UIColorFromRGB(0x292421)
#define LIGHT_BLUE UIColorFromRGB(0x169BD5)
#define BIRD_BLUE UIColorFromRGB(0x33A1C9)
#define BLUE_TINT [UIColor colorWithRed:45/255.0 green:153/255.0 blue:255/255.0 alpha:1.0]
#define VIEW_GRAY [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]
#define TEXT_LIGHTBLACK [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0]
#define SELECTED_COLOR_LIGHT_GRAY [UIColor colorWithWhite:240/255.0 alpha:1.0]
#define SYSTEM_BLUE [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]
#define RED_ORANGE [UIColor colorWithRed:255/255.0 green:69/255.0 blue:0/255.0 alpha:1.0]
#define BTN_LIGHT_GREEN [UIColor colorWithRed:0 green:201/255.0 blue:87/255.0 alpha:1.0]
#define TEXT_LIGHTGREEN [UIColor colorWithRed:168/255.0 green:216/255.0 blue:75/255.0 alpha:1.0]

//WIDTH和HEIGHT
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
//比例计算
#define X_P WIDTH/375.0
#define Y_P HEIGHT/667.0

@interface AMETools : NSObject


/**
 *  获取当前网络状态
 *
 *  @return 返回啥自己输出一下
 */
+ (NSString *)getNetWorkType;
/**
 *  用Bundle方式获取一张图片
 *
 *  @param name      图片名
 *  @param extension 图片格式
 *
 *  @return 返回图片
 */
+ (UIImage *)getImageWithName:(NSString *)name extension:(NSString *)extension;
/**
 *  用Bundle方式获取一张PNG
 *
 *  @param name 图片名
 *
 *  @return 返回图片
 */
+ (UIImage *)getPNGImageWithName:(NSString *)name;
/**
 *  弄一个单按钮的alert
 *
 *  @param title         alert的title
 *  @param message       alert的message
 *  @param okActionTitle ok按钮的内容
 *  @param handler       ok按钮点击之后执行的方法
 *
 *  @return 返回alert
 */
+ (UIAlertController *)getSimpleAlertWithTitle:(NSString *)title message:(NSString *)message okActionTitle:(NSString *)okActionTitle okHandler:(void(^)(UIAlertAction * action))handler;


/**
 联网获取时间
 */

+ (void)getInternetDateWithCompletion:(void(^)(NSDate * date,BOOL isError))completion;

/**
 *得到本机现在用的语言
 * en-CN 或en  英文  zh-Hans-CN或zh-Hans  简体中文   zh-Hant-CN或zh-Hant  繁体中文    ja-CN或ja  日本  ......
 */
+ (NSString*)getPreferredLanguage;

/**
 系统语言是否是中文
 */
+ (BOOL)preferredLanguageIsChinese;

/**
 获取或生成一个UUID,直到删除APP(存入明文:selfUUID中)
 */
+ (NSString *)getUUID;


/*tips自用
statusBar字体为白色
在plist里面设置View controller-based status bar appearance 为 NO；设置statusBarStyle UIStatusBarStyleLightContent

开定位
首先需要在info.plist文件中添加一个键：NSLocationAlwaysUsageDescription或者NSLocationWhenInUseUsageDescription。其中NSLocationAlwaysUsageDescription是要始终使用定位服务，NSLocationWhenInUseUsageDescription是只在前台使用定位服务。

sd加载不了的图片,试试
[[SDWebImageDownloader sharedDownloader] setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];

屏蔽杂乱无章的bug
Xcode8里边 Edit Scheme-> Run -> Arguments, 在Environment Variables里边添加
OS_ACTIVITY_MODE ＝ Disable

*/
@end
