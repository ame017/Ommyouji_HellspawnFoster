//
//  AMEArrayDataSource.h
//  AMEToosVer
//
//  Created by Vino－lgc on 16/9/21.
//  Copyright © 2016年 AME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AMEArrayDataSource : NSObject<UITableViewDataSource>

/**
 *  数组
 */
@property (nonatomic, retain) NSMutableArray * items;

/**
 *  构造一个代理(cellClassName如果为空,则默认UITableViewCell)
 *
 *  @param items          内容数组
 *  @param cellClassName  cell的自定义cell类名
 *  @param cellIdentifier cell的标识字符串
 *  @param configureCell  cell的控件处理
 *
 *  @return 返回一个大光头
 */
- (instancetype)initDataSourceMakeWithItems:(NSMutableArray *)items cellClassName:(NSString *)cellClassName cellIdentitifer:(NSString *)cellIdentifier configureCell:(void (^)(UITableViewCell * cell, NSIndexPath * indexPath , id item))configureCell;

@end
