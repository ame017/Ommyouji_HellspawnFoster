//
//  AMETransitionView.m
//  AMEelemeDEMO
//
//  Created by syetc053 on 16/6/30.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import "AMETransitionView.h"
#define IMG_COUNT _images.count
#define VIEW_WIDTH self.frame.size.width
#define VIEW_HEIGHT self.frame.size.height

@interface AMETransitionView ()
{
    UIImageView * _imageView;
    NSInteger _indexOfImage;
    NSTimer * _timer;
    UIPageControl * _pageControl;
}

@end
@implementation AMETransitionView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.autoSwipeInterval = 1.0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoSwipeInterval = 1.0;
    }
    return self;
}

-(void)setImages:(NSArray *)images{
    _images = images;
    _imageView = [[UIImageView alloc]initWithFrame:self.frame];
    if (IMG_COUNT) {
        _imageView.image = _images[0];
    }
    [self addSubview:_imageView];
    _indexOfImage = 0;
    
    
    //添加向左和向右的滑动事件
    UISwipeGestureRecognizer * leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(left)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer * rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(right)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipe];
    
    if (!self.isHidden) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((VIEW_WIDTH-50)/2.0, VIEW_HEIGHT-20, 50, 20)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = IMG_COUNT;
        [self addSubview:_pageControl];
    }
}

- (void)startAutoSwipe{
    if (_timer) {
        [_timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.autoSwipeInterval target:self selector:@selector(left) userInfo:nil repeats:YES];
}
- (void)stopAutoSwipe{
    if (_timer) {
        [_timer invalidate];
    }
}


#pragma mark 左划 右侧出后一张图
- (void)left{
    [self transitionAnimation:YES];
}
#pragma mark 右划 左侧出前一张图
- (void)right{
    [self transitionAnimation:NO];
}

#pragma mark 转场动画
- (void)transitionAnimation:(BOOL)isNext{
    CATransition * tAni = [[CATransition alloc]init];
    tAni.type = @"push";
    
    if (isNext) {
        tAni.subtype = kCATransitionFromRight;
    }else{
        tAni.subtype = kCATransitionFromLeft;
    }
    tAni.duration = 0.3;
    
    //执行完之后的动作
    _imageView.image = [self changeImg:isNext];
    
    [_imageView.layer addAnimation:tAni forKey:nil];
}
#pragma mark 换图
- (UIImage *)changeImg:(BOOL)isNext{
    if (isNext) {
        _indexOfImage++;
        if (_indexOfImage>IMG_COUNT-1) {
            _indexOfImage=0;
        }
    }else{
        _indexOfImage--;
        if (_indexOfImage<0) {
            _indexOfImage = IMG_COUNT-1;
        }
    }
    _pageControl.currentPage = _indexOfImage;
    return self.images[_indexOfImage];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
