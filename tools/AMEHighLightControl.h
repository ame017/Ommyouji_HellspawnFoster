//
//  AMEHeightLightControl.h
//  AMEelemeDEMO
//
//  Created by Apple on 16/6/29.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMEHighLightControl : UIControl
/**
 *  按钮可以带一些信息,比如url啊什么的,用字典存储
 */
@property (nonatomic, retain) NSMutableDictionary * userInfo;

- (instancetype)initWithFrame:(CGRect)frame event:(void (^)())event;

- (instancetype)initWithEvent:(void (^)())event;
@end
