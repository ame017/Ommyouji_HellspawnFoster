//
//  AMELeftList.h
//  AMEelemeDEMO
//
//  Created by syetc053 on 16/7/7.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMETools.h"


@protocol AMELeftListDelegate <NSObject>

-(void)clickLeftSelectScrollButton:(NSInteger)section;

@end

@interface AMELeftList : UIScrollView


@property (nonatomic) NSUInteger nowSectionindex;
@property (nonatomic,strong)NSArray<NSString *> * listArray;

@property (nonatomic,weak)id<AMELeftListDelegate> cellDelegate;
@property (nonatomic,retain) UIColor * tintColor;


//-(void)setSelectButtonWithIndexPathSection:(NSInteger)section;

/**
 *  初始化方法
 *
 *  @param frame     frame大小
 *  @param listArray 列表文字
 *  @param tintColor 渲染颜色
 *
 *  @return 返回本控件
 */
-(instancetype)initWithFrame:(CGRect)frame listArray:(NSArray<NSString *> *)listArray tintColor:(UIColor *)tintColor;

@end
