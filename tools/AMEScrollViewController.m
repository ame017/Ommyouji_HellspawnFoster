//
//  AMEScrollViewController.m
//  TagViewTest
//
//  Created by Vino－lgc on 16/9/19.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "AMEScrollViewController.h"

@interface AMEScrollViewController ()<UIScrollViewDelegate>

@end

@implementation AMEScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - keyboardMethod
- (void)keyboardDown{
    if (self.textFieldArray.count>0) {
        for (UITextField * textField in self.textFieldArray) {
            [textField resignFirstResponder];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //让界面一滑动就收起键盘
    if (scrollView == _mainView) {
        [self keyboardDown];
    }
}

#pragma mark - getter&setter
- (UIScrollView *)mainView{
    if (!_mainView) {
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _mainView.alwaysBounceVertical = YES;
        _mainView.delegate = self;
        _mainView.backgroundColor = UIColorFromRGB(0xF9F9F9);
        
//        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardDown)];
//        [_mainView addGestureRecognizer:tapGesture];
        
    }
    return _mainView;
}

- (NSMutableArray *)textFieldArray{
    if (!_textFieldArray) {
        _textFieldArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _textFieldArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//@interface UINavigationItem (margin)
//
//@end
//
//@implementation UINavigationItem (margin)
//
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
//- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
//{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSeperator.width = -16;//此处修改到边界的距离，请自行测试
//        
//        if (_leftBarButtonItem)
//        {
//            [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
//        }
//        else
//        {
//            [self setLeftBarButtonItems:@[negativeSeperator]];
//        }
//        
//        
//    }
//    else
//    {
//        [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
//    }
//}
//
//- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
//{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//    {
//        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSeperator.width = -12;//此处修改到边界的距离，请自行测试
//        
//        if (_rightBarButtonItem)
//        {
//            [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
//        }
//        else
//        {
//            [self setRightBarButtonItems:@[negativeSeperator]];
//        }
//        
//    }
//    else
//    {
//        [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
//    }
//}
//
//#endif
//@end
