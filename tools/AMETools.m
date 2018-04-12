//
//  AMETools.m
//
//
//  Created by AME on 16/6/29.
//  Update 16/9/20
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import "AMETools.h"



@implementation AMETools


+ (UIImage *)getImageWithName:(NSString *)name extension:(NSString *)extension{
    NSString * path = [[NSBundle mainBundle]pathForResource:name ofType:extension];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)getPNGImageWithName:(NSString *)name{
    NSString * path = [[NSBundle mainBundle]pathForResource:name ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}

+ (NSString *)getNetWorkType{
    NSString * strNetworkType = @"";
    
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return strNetworkType;
    }
    
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        // if target host is reachable and no connection is required
        // then we'll assume (for now) that your on Wi-Fi
        strNetworkType = @"WIFI";
    }
    
    if (
        ((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
        (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0
        )
    {
        // ... and the connection is on-demand (or on-traffic) if the
        // calling application is using the CFSocketStream or higher APIs
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            // ... and no [user] intervention is needed
            strNetworkType = @"WIFI";
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
            
            if (currentRadioAccessTechnology)
            {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
                {
                    strNetworkType =  @"4G";
                }
                else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
                {
                    strNetworkType =  @"2G";
                }
                else
                {
                    strNetworkType =  @"3G";
                }
            }
        }
        else
        {
            if((flags & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable)
            {
                if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection)
                {
                    if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired)
                    {
                        strNetworkType = @"2G";
                    }
                    else
                    {
                        strNetworkType = @"3G";
                    }
                }
            }
        }
    }
    
    
    if ([strNetworkType isEqualToString:@""]) {
        strNetworkType = @"WWAN";
    }
    return strNetworkType;
}

+ (UIAlertController *)getSimpleAlertWithTitle:(NSString *)title message:(NSString *)message okActionTitle:(NSString *)okActionTitle okHandler:(void(^)(UIAlertAction * _Nonnull action))handler{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction actionWithTitle:okActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        handler(action);
    }];
    [alert addAction:ok];
    return alert;
}


+ (void)getInternetDateWithCompletion:(void(^)(NSDate * date,BOOL isError))completion;
{
    NSString *urlString = @"http://m.baidu.com";
    urlString = [urlString stringToUTF8];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * task = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        BOOL isError = NO;
        NSDate * resultDate = [NSDate new];
        if (error) {
            isError = YES;
            resultDate = [NSDate date];
        }else{
            NSLog(@"response is %@",response);
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
            NSString *date = [[httpResponse allHeaderFields] objectForKey:@"Date"];
            date = [date substringFromIndex:5];
            date = [date substringToIndex:[date length]-4];
            NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
            dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
            resultDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
        }
        completion(resultDate,isError);
    }];
    [task resume];
}

+ (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}
//zh-Hans-CN或zh-Hans  简体中文   zh-Hant-CN或zh-Hant
+ (BOOL)preferredLanguageIsChinese{
    NSString * language = [AMETools getPreferredLanguage];
    if (!([language isEqualToString:@"zh-Hans-CN"]||[language isEqualToString:@"zh-Hans"]||[language isEqualToString:@"zh-Hant-CN"]||[language isEqualToString:@"zh-Hant"])) {
        return NO;
    }
    return YES;
}

+ (NSString *)getUUID{
    NSString * uuid = [[NSUserDefaults standardUserDefaults]objectForKey:@"selfUUID"];
    if (!uuid||[uuid isEqualToString:@""]) {
        uuid = [[NSUUID UUID] UUIDString];
        [[NSUserDefaults standardUserDefaults]setObject:uuid forKey:@"selfUUID"];
        NSLog(@"getNewUUID:%@",uuid);
    }else{
        NSLog(@"UUID:%@",uuid);
    }
    return uuid;
}

@end
