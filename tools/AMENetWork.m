//
//  AMENetWork.m
//  AMEToosVer
//
//  Created by Vino－lgc on 2016/11/8.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "AMENetWork.h"

@implementation AMENetWork


+ (NSURLSessionTask *)requestDataTaskWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url parameters:(NSDictionary *)parameters Completion:(void (^)(id, NSError *))completion{
    AMENetWork * netWork = [[AMENetWork alloc]initWithNetWorkWay:netWorkWay url:url parameters:parameters Completion:completion];
    return [netWork getDataTask];
}

- (instancetype)initWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url parameters:(NSDictionary *)parameters Completion:(void (^)(id, NSError *))completion{
    self.netWorkWay = netWorkWay;
    self.parameters = parameters;
    self.url        = url;
    self.completion = completion;
    return self;
}

- (NSURLSessionTask *)getDataTask{
    NSMutableURLRequest * request;
    if (self.url == nil || [self.url isEqualToString:@""]) {
        return nil;
    }
    if (self.netWorkWay == AMENetWorkWayGet) {
        request = [[AFHTTPRequestSerializer serializer]requestWithMethod:@"GET" URLString:self.url parameters:self.parameters error:nil];
    }else{
        request = [[AFHTTPRequestSerializer serializer]requestWithMethod:@"POST" URLString:self.url parameters:self.parameters error:nil];
    }
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:config];
    NSURLSessionTask * task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        self.completion(responseObject,error);
    }];
    return task;
}
@end


@implementation AMENetWorkManager

AMENetWorkManager * _manager;

+ (instancetype)shardManager{
    @synchronized (self) {
        if (!_manager) {
            _manager = [[AMENetWorkManager alloc]init];
        }
    }
    return _manager;
}

@end
