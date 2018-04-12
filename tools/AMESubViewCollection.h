//
//  AMESubViewCollection.h
//  AMEelemeDEMO
//
//  Created by Apple on 16/7/6.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMETools.h"

@interface AMESubViewCollection : UIView
/**
 *  标题分栏
 */
@property (nonatomic,retain)NSMutableArray<NSString *> * titleArray;
/**
 *  每个分栏对应的view
 */
@property (readonly,nonatomic,retain)NSMutableArray * subViewCollection;
/**
 *  是否有动画效果,默认为有
 */
@property (nonatomic)BOOL animation;
/**
 *  文字和提示条的颜色
 */
@property (nonatomic,retain) UIColor * tintColor;
/**
 *  标题栏的高度,最低20,默认30
 */
@property (nonatomic)CGFloat titleHeight;
/**
 *  是否有提示条
 */
@property (nonatomic)BOOL noticeBarHidden;

/**
 *  标题View(公开出来以便修改)
 */
@property (nonatomic,retain) UIView * titleView;
/**
 *  当前index
 */
@property (nonatomic)NSUInteger indexOfSubView;
/**
 *  init构造
 *
 *  @param frame       frame
 *  @param titleArray  标题名数组
 *  @param titleHeight 标题栏高度
 *  @param tintColor   填充颜色
 *
 *  @return 返回一个大新闻
 */
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray<NSString *> *)titleArray titleHeight:(CGFloat)titleHeight tintColor:(UIColor *)tintColor;

@end
