//
//  AMENetWork+Token.h
//  AMEToosVer
//
//  Created by Vino－lgc on 2016/11/18.
//  Copyright © 2016年 AME. All rights reserved.
//  主要用于需要加密的请求,关于token的自动处理

#import "AMENetWork.h"
#import <SVProgressHUD.h>

@interface AMENetWork (Token)
/**
 自动进行token处理,并返回TAG(token将会自动存在request_token明文中) 有线程BUG,自行解决吧
 
 @param netWorkWay GET POST
 @param parameters 属性
 @param url 请求网址
 @param tokenUrl 请求token网址
 @param tokenKey 请求token字段名
 @param completion 获取数据之后做什么
 @return w(ﾟДﾟ)w
 */
+ (NSURLSessionTask *)autoRequsetDataTokenWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url tokenKey:(NSString *)tokenKey tokenUrl:(NSString *)tokenUrl parameters:(NSDictionary *)parameters Completion:(void (^)(id responseObject, NSError * error))completion;


/**
 init方法
 
 @param netWorkWay GET POST
 @param parameters 属性
 @param url 请求网址
 @param tokenUrl 请求token网址
 @param tokenKey 请求token字段名
 @param completion 获取数据之后做什么
 
 @return 返回一个大光头
 */
- (instancetype)initWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url tokenKey:(NSString *)tokenKey tokenUrl:(NSString *)tokenUrl parameters:(NSDictionary *)parameters Completion:(void (^)(id responseObject, NSError * error))completion;

///**
// 自动进行token处理(token将会自动存在request_token明文中),并自动控制是否请求,MD用不了!
// 
// @param netWorkWay GET POST
// @param parameters 属性
// @param url 请求网址
// @param tokenUrl 请求token网址
// @param tokenKey 请求token字段名
// @param completion 获取数据之后做什么
// */
//+ (void)autoRequsetDataTokenAndAutoResumeWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url tokenKey:(NSString *)tokenKey tokenUrl:(NSString *)tokenUrl parameters:(NSDictionary *)parameters Completion:(void (^)(id responseObject, NSError * error))completion;
@end
//这条路也走不通,哎
//@interface NSURLSessionTask (SafetyResume)
//
///**
// 多次请求按顺序进行
// */
//- (void)safetyResume;
//
//@end
