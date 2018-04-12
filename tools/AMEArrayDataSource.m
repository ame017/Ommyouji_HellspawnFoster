//
//  AMEArrayDataSource.m
//  AMEToosVer
//
//  Created by Vino－lgc on 16/9/21.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "AMEArrayDataSource.h"

@interface AMEArrayDataSource ()

/**
 *  identity
 */
@property (nonatomic, copy) NSString * cellIdentifier;
/**
 *  生成后的执行块
 */
@property (nonatomic, copy) void (^configureCell)(UITableViewCell * cell, NSIndexPath * indexPath, id item);
/**
 *  cell的自定义类名,若为空则为普通tableViewCell
 */
@property (nonatomic, copy) NSString * cellClassName;

@end

@implementation AMEArrayDataSource

- (instancetype)initDataSourceMakeWithItems:(NSMutableArray *)items  cellClassName:(NSString *)cellClassName cellIdentitifer:(NSString *)cellIdentifier configureCell:(void (^)(UITableViewCell * cell, NSIndexPath * indexPath , id item))configureCell{
    self = [super init];
    if (self) {
        _items = items;
        _cellClassName = cellClassName;
        _cellIdentifier = cellIdentifier;
        _configureCell = [configureCell copy];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        if (self.cellClassName) {
            cell = [[NSClassFromString(self.cellClassName) alloc]initWithStyle:0 reuseIdentifier:self.cellIdentifier];
        }else{
            cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:self.cellIdentifier];
        }
    }
    self.configureCell(cell, indexPath, self.items[indexPath.row]);
    return cell;
}

@end
