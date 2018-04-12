//
//  AMELocation.h
//  AMEFilm
//
//  Created by syetc053 on 16/7/25.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AMELocation : NSObject

@property NSString * locationString;
@property CGFloat latitude;
@property CGFloat longitude;
/**
 *  一行搞定定位😌
 *
 *  @param completion 获取到定位以后做的事
 */
- (void)getLocationWithCompletion:(void (^)(CLLocationDegrees latitude,CLLocationDegrees longitude,NSString * locationString))completion;
/**
 *  单例方法
 *
 *  @return 你说返回啥
 */
+ (instancetype)sharedLocation;
@end
