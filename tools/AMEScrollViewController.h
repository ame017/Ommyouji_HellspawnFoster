//
//  AMEScrollViewController.h
//  TagViewTest
//
//  Created by Vino－lgc on 16/9/19.
//  Copyright © 2016年 AME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMETools.h"

@interface AMEScrollViewController : UIViewController

/**
 *  主容器,使页面可以上下滑动
 */
@property (nonatomic, strong) UIScrollView * mainView;
/**
 *  如果页面上有textField,希望滚动界面的时候收起键盘,则放在这个数组里
 */
@property (nonatomic, retain) NSMutableArray * textFieldArray;

/**
 *  收键盘的方法
 */
- (void)keyboardDown;
@end
