//
//  AMENetWork.h
//  AMEToosVer
//
//  Created by Vino－lgc on 2016/11/8.
//  Copyright © 2016年 AME. All rights reserved.
//
//  对AF进行一些二次封装

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSInteger, AMENetWorkWay) {
    AMENetWorkWayGet,
    AMENetWorkWayPost
};

@interface AMENetWork : NSObject

@property (nonatomic, assign) AMENetWorkWay netWorkWay;
@property (nonatomic, retain) NSDictionary * parameters;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, retain) NSDictionary * userInfo;

//token use
@property (nonatomic, copy) NSString * tokenKey;
@property (nonatomic, copy) NSString * tokenUrl;

@property (copy) void (^completion) (id responseObject, NSError * error);


/**
 最直接的构造器

 @param netWorkWay GET POST
 @param parameters 属性
 @param url 请求网址
 @param completion 获取数据之后做什么

 @return 返回一个task
 */
+ (NSURLSessionTask *)requestDataTaskWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url parameters:(NSDictionary *)parameters Completion:(void (^)(id responseObject, NSError * error))completion;

/**
 对象属性根据属性返回一个task(需要三项都有值)

 @return 返回一个task
 */
- (NSURLSessionTask *)getDataTask;

/**
 init方法

 @param netWorkWay GET POST
 @param parameters 属性
 @param url 请求网址
 @param completion 获取数据之后做什么

 @return 返回一个大光头
 */
- (instancetype)initWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url parameters:(NSDictionary *)parameters Completion:(void (^)(id responseObject, NSError * error))completion;


@end

@interface AMENetWorkManager : NSObject

@property (nonatomic , assign) BOOL isGettingToken;


+ (instancetype)shardManager;
@end
