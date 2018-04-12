//
//  AMENetWork+Token.m
//  AMEToosVer
//
//  Created by Vino－lgc on 2016/11/18.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "AMENetWork+Token.h"
#import "AMETools.h"


@implementation AMENetWork (Token)

//@dynamic tokenKey;
//@dynamic tokenUrl;

//#pragma mark - autoResume
//+ (void)autoRequsetDataTokenAndAutoResumeWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url tokenKey:(NSString *)tokenKey tokenUrl:(NSString *)tokenUrl parameters:(NSDictionary *)parameters Completion:(void (^)(id responseObject, NSError * error))completion{
//    AMENetWork * netWork = [[AMENetWork alloc]initWithNetWorkWay:netWorkWay url:url tokenKey:tokenKey tokenUrl:tokenUrl parameters:parameters Completion:completion];
//    [netWork autoRequsetDataTokenAndAutoResumeWithNetWorkWay:netWorkWay url:url tokenKey:tokenKey tokenUrl:tokenUrl parameters:parameters Completion:completion];
//}
//
//- (void)autoRequsetDataTokenAndAutoResumeWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url tokenKey:(NSString *)tokenKey tokenUrl:(NSString *)tokenUrl parameters:(NSDictionary *)parameters Completion:(void (^)(id responseObject, NSError * error))completion{
//    if ([AMENetWorkManager shardManager].isGettingToken == NO) {
//        [AMENetWorkManager shardManager].isGettingToken = YES;
//        [self start];
//    }else{
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(start) name:@"tokenGet" object:nil];
//    }
//}
//- (void)start{
//    [[self getAutoRequsetDataTokenTask] resume];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"tokenGet" object:nil];
//}

#pragma mark - getTask
+ (NSURLSessionTask *)autoRequsetDataTokenWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url tokenKey:(NSString *)tokenKey tokenUrl:(NSString *)tokenUrl parameters:(NSDictionary *)parameters Completion:(void (^)(id responseObject, NSError * error))completion{
    AMENetWork * netWork = [[AMENetWork alloc]initWithNetWorkWay:netWorkWay url:url tokenKey:tokenKey tokenUrl:tokenUrl parameters:parameters Completion:completion];
    return [netWork getAutoRequsetDataTokenTask];
}

- (instancetype)initWithNetWorkWay:(AMENetWorkWay)netWorkWay url:(NSString *)url tokenKey:(NSString *)tokenKey tokenUrl:(NSString *)tokenUrl parameters:(NSDictionary *)parameters Completion:(void (^)(id responseObject, NSError * error))completion{
    self.netWorkWay = netWorkWay;
    self.parameters = parameters;
    self.url        = url;
    self.completion = completion;
    self.tokenUrl   = tokenUrl;
    self.tokenKey   = tokenKey;
    return self;
}

- (NSURLSessionTask *)getAutoRequsetDataTokenTask{
    NSLog(@"getAuto");
    //如果没有属性,将其初始化为字典
    if (!self.parameters) {
        self.parameters = [NSDictionary dictionary];
    }
    NSMutableDictionary * paramertsWithToken = self.parameters.mutableCopy;
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"request_token"];
    if (!token) {
        token = @"0";
    }
    NSLog(@"token======%@",token);
    paramertsWithToken[self.tokenKey] = token;
    paramertsWithToken[@"mac"] = [AMETools getUUID];
    NSURLSessionTask * task = [AMENetWork requestDataTaskWithNetWorkWay:self.netWorkWay url:self.url parameters:paramertsWithToken Completion:^(id responseObject, NSError *error) {
        //customCode
        if (error) {
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"网络连接失败或服务器维护中", nil)];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }else{
            //tokenWrong
            NSString * token_flag;
            NSString * getDataClass = NSStringFromClass([responseObject[@"getData"] class]);
            NSLog(@"%@",getDataClass);
            if ([getDataClass rangeOfString:@"Dictionary"].location != NSNotFound) {
                token_flag = responseObject[@"getData"][@"token_flag"];
            }else if ([getDataClass rangeOfString:@"Array"].location != NSNotFound){
                token_flag = responseObject[@"getData"][0][@"token_flag"];
            }
            NSLog(@"token_flag------------>%@",token_flag);
            if (![token_flag isEqualToString:@"0"]) {
                [[AMENetWork requestDataTaskWithNetWorkWay:self.netWorkWay url:self.tokenUrl parameters:@{@"mac":[AMETools getUUID]} Completion:^(id responseObject, NSError *error) {
                    //redo
                    if (!error) {
                        //存入新token
                        NSString * newToken = responseObject[@"getData"];
                        NSLog(@"newToken ====== %@",newToken);
                    
                        [[NSUserDefaults standardUserDefaults]setObject:newToken forKey:@"request_token"];
                        //设为没在获取数据的状态
                        [AMENetWorkManager shardManager].isGettingToken = NO;
                        //发个大新闻
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"tokenGet" object:nil];
                        
                        //从新获取数据
                        NSMutableDictionary * paramertsWithToken = self.parameters.mutableCopy;
                        paramertsWithToken[self.tokenKey] = newToken;
                        paramertsWithToken[@"mac"] = [AMETools getUUID];
                        [[AMENetWork requestDataTaskWithNetWorkWay:self.netWorkWay url:self.url parameters:paramertsWithToken Completion:self.completion] resume];
                    }
                }] resume];
            }else{
                [AMENetWorkManager shardManager].isGettingToken = NO;
                //发个大新闻
                [[NSNotificationCenter defaultCenter]postNotificationName:@"tokenGet" object:nil];
                self.completion(responseObject,error);
            }
        }
    }];
    return task;
}

- (void)reRequsetWithToken{
    [self getAutoRequsetDataTokenTask];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"tokenGet" object:nil];
}
@end


//@implementation NSURLSessionTask (SafetyResume)
//
//- (void)safetyResume{
//    if ([AMENetWorkManager shardManager].isGettingToken == NO) {
//        NSLog(@"setYES");
//        [AMENetWorkManager shardManager].isGettingToken = YES;
//        [self resume];
//    }else{
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reStart) name:@"tokenGet" object:nil];
//    }
//}
//
//- (void)reStart{
//    NSLog(@"reStart");
//    [self resume];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"tokenGet" object:nil];
//}
//
//@end
