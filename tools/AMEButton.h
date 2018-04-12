//
//  AMEButton.h
//  TagViewTest
//
//  Created by Vino－lgc on 16/9/19.
//  Copyright © 2016年 AME. All rights reserved.
//  写一个按钮插件以快速构建一些自己常用的按钮,同时在图片模式下只点按有图的部分

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AMEButtonType){
    AMEButtonTypeClean,//deafult
    AMEButtonTypeBorder,
    AMEButtonTypeRoundCorner,
    AMEButtonTypeBackGrounded
};

@interface AMEButton : UIButton

/**
 *  按钮可以带一些信息,比如url啊什么的,用字典存储
 */
@property (nonatomic, retain) NSMutableDictionary * userInfo;
/**
 *  是否高亮,默认不高亮
 */
@property (nonatomic, assign) BOOL highlightEnable;
/**
 *  点击事件,这次再也不用把TA放在外面了,自行选择食用
 */
@property (copy) void (^event) ();

/**
 透明区域是否禁止点击,默认为no
 */
@property (nonatomic, assign) BOOL onlyShapeOfImage;
/**
 *  构了个造w(ﾟДﾟ)w
 *
 *  @param buttonType 选个初始化模型
 *  @param event      写个事件(不想写就nil)
 *
 *  @return 返回一个折腾好的button
 */
+ (instancetype)buttonWithType:(AMEButtonType)buttonType event:(void (^)())event;

@end
