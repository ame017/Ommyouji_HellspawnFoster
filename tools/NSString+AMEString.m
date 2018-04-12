//
//  NSString+AMEString.m
//  TagViewTest
//
//  Created by Vino－lgc on 16/9/19.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "NSString+AMEString.h"

@implementation NSString (AMEString)

- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString
{
    if (!fromString || !toString || fromString.length == 0 || toString.length == 0) {
        return nil;
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = self;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        }
        else
        {
            break;
        }
    }
    return subStringsArray;
}
- (NSString *)stringToUTF8{
    NSCharacterSet * set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString * UTF8 = [self stringByAddingPercentEncodingWithAllowedCharacters:set];
    return UTF8;
}

- (NSString *)stringCalculate:(NSString *)calculate breviary:(NSInteger)breviary{
    //获取数据并进行计算
    double stringNum;
    if ([self isEqualToString:@""]) {
        stringNum = 0;
    }else{
        stringNum = [self doubleValue];
    }
    NSString * calculateNumString = [calculate substringFromIndex:1];
    double calculateNum = [calculateNumString doubleValue];
    char operator = [calculate characterAtIndex:0];
    double answer = stringNum;
    switch (operator) {
        case '+':{
            answer = stringNum + calculateNum;
        }break;
        case '-':{
            answer = stringNum - calculateNum;
        }break;
        case '*':{
            answer = stringNum * calculateNum;
        }break;
        case '/':{
            answer = stringNum / calculateNum;
        }break;
        default:{
            NSLog(@"operatorWrong");
        }break;
    }
    //根据用户输入的精确位数进行修改
    NSString * newAnswerString;
    if (breviary==-1) {
        if ((long)answer == answer) {
            //证明answer不是个小数
            newAnswerString = [NSString stringWithFormat:@"%ld",(long)answer];
        }else{
            //如果是个小数,砍掉0输出
            NSString * answerString = [NSString stringWithFormat:@"%lf",answer];
            NSRange zeroRange;
            BOOL hasRange = NO;
            BOOL needCut = NO;
            for (int i=0; i<answerString.length; i++) {
                if ([answerString characterAtIndex:i]=='0') {
                    if (!hasRange) {
                        hasRange = YES;
                        zeroRange = NSMakeRange(i, 1);
                    }else{
                        zeroRange = NSMakeRange(zeroRange.location, zeroRange.length+1);
                    }
                    //最后一位
                    if (i == answerString.length-1 & zeroRange.location+zeroRange.length == answerString.length) {
                        needCut = YES;
                    }
                }else{
                    hasRange = NO;
                }
            }
            if (needCut) {
                newAnswerString = [answerString substringToIndex:zeroRange.location];
            }
        }
    }else if (breviary >= 0){
        NSString * answerString = [NSString stringWithFormat:@"%lf",answer];
        NSArray * answerArray = [answerString componentsSeparatedByString:@"."];
        NSString * decimals = answerArray.lastObject;
        if (decimals.length == breviary) {
            newAnswerString = answerString;
        }else if (decimals.length < breviary){
            for (int i=0; i<breviary-decimals.length; i++) {
                answerString = [NSString stringWithFormat:@"%@%@",answerString,@"0"];
            }
            newAnswerString = answerString;
        }else if (decimals.length > breviary){
            NSString * newDecimals = [decimals substringToIndex:breviary];
            newAnswerString = [NSString stringWithFormat:@"%@.%@",answerArray.firstObject,newDecimals];
        }
    }else{
        NSLog(@"breviaryWrong");
        newAnswerString = [NSString stringWithFormat:@"%lf",answer];
    }
    return newAnswerString;
}

@end
