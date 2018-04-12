//
//  AMECellInfo.h
//  comicDEMO
//
//  Created by syetc053 on 16/7/14.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AMECellInfo : NSObject

@property (nonatomic,retain) NSString * title;
@property (nonatomic,retain) UIImage * image;
@property (nonatomic,retain) NSString * subTitle;
//如果不用上面的 可以用字典
@property (nonatomic,retain) NSMutableDictionary * infoDictionary;


/**
 构造方法,用于构造常用cell数据(由于多用于本地,所以将imageString更新为Image)

 @param title    NSString * title
 @param image    UIImage * image;
 @param subTitle NSString * subTitle

 @return 😌
 */
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image subTitle:(NSString *)subTitle;

@end
