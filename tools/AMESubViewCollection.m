//
//  AMESubViewCollection.m
//  AMEelemeDEMO
//
//  Created by Apple on 16/7/6.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import "AMESubViewCollection.h"


#define VIEW_WIDTH self.frame.size.width
#define VIEW_HEIGHT self.frame.size.height

@interface AMESubViewCollection()<UIScrollViewDelegate>
{
    UIView * _noticeBar;
    UIScrollView * _mainView;
    NSMutableArray * _titleLabelArray;
}

@end


@implementation AMESubViewCollection

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleArray = [NSMutableArray arrayWithCapacity:0];
        _animation = YES;
        _tintColor = [UIColor colorWithRed:45/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
        _titleHeight = 30;
        _noticeBarHidden = NO;
        _indexOfSubView = 0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArray = [NSMutableArray arrayWithCapacity:0];
        _animation = YES;
        _tintColor = [UIColor colorWithRed:45/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
        _titleHeight = 30;
        _noticeBarHidden = NO;
        _indexOfSubView = 0;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray<NSString *> *)titleArray titleHeight:(CGFloat)titleHeight tintColor:(UIColor *)tintColor{
    self = [super initWithFrame:frame];
    _titleArray = [NSMutableArray arrayWithCapacity:0];
    _subViewCollection = [NSMutableArray arrayWithCapacity:0];
    _animation = YES;
    _tintColor = [UIColor colorWithRed:45/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    _titleHeight = 30;
    _noticeBarHidden = NO;
    _indexOfSubView = 0;
    
    _titleArray = titleArray;
    if (titleHeight>=20) {
        _titleHeight = titleHeight;
    }
    if (tintColor) {
        _tintColor = tintColor;
    }
    
    if (self) {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, _titleHeight)];
        [self addSubview:_titleView];
        
        UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, _titleHeight-1, VIEW_WIDTH, 1)];
        bottomLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [self addSubview:bottomLine];
        
        _titleLabelArray = [NSMutableArray arrayWithCapacity:_titleArray.count];
        for (int i=0; i<_titleArray.count; i++) {
            UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0+i*(VIEW_WIDTH/_titleArray.count), 0, (VIEW_WIDTH/_titleArray.count), _titleHeight)];
            [self.titleView addSubview:control];
            control.tag = i;
            [control addTarget:self action:@selector(touchUP:) forControlEvents:UIControlEventTouchUpInside];
            
            AMELabel * title = [[AMELabel alloc]initWithFrame:CGRectMake(0, 0, (VIEW_WIDTH/_titleArray.count), _titleHeight)];
            if (i==_indexOfSubView) {
                title.fillColor = _tintColor;
            }else{
                title.fillColor = TEXT_LIGHTBLACK;
            }
            title.text = _titleArray[i];
            title.font = [UIFont systemFontOfSize:_titleHeight-15];
            title.textAlignment = NSTextAlignmentCenter;
            [control addSubview:title];
            [_titleLabelArray addObject:title];
        }
        
        
        _noticeBar = [[UIView alloc]initWithFrame:CGRectMake(0, _titleHeight-3, (VIEW_WIDTH/_titleArray.count), 3)];
        _noticeBar.backgroundColor = _tintColor;
        [_titleView addSubview:_noticeBar];
        
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _titleHeight, VIEW_WIDTH, VIEW_HEIGHT-_titleHeight)];
        _mainView.contentSize = CGSizeMake(VIEW_WIDTH*_titleArray.count, VIEW_HEIGHT-_titleHeight);
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.bounces = NO;
        _mainView.pagingEnabled = YES;
        _mainView.delegate = self;
        [self addSubview:_mainView];
        
        for (int i=0; i<_titleArray.count; i++) {
            UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(VIEW_WIDTH*i, 0, VIEW_WIDTH, VIEW_HEIGHT-_titleHeight)];
//            subView.backgroundColor = [UIColor colorWithWhite:arc4random()%100/100.0 alpha:1.0];
            subView.backgroundColor = [UIColor whiteColor];
            subView.tag = i;
            [_mainView addSubview:subView];
            [_subViewCollection addObject:subView];
        }
    }
    return self;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = _mainView.contentOffset.x/VIEW_WIDTH;
    NSUInteger lastIndex = _indexOfSubView;
    
    AMELabel * lastTitle = _titleLabelArray[lastIndex];
    AMELabel * nowTitle = _titleLabelArray[index];
    
    if (_animation) {
        [UIView animateWithDuration:0.4 animations:^{
            _noticeBar.frame = CGRectMake(index*(VIEW_WIDTH/_titleArray.count), _titleHeight-3, (VIEW_WIDTH/_titleArray.count), 3);
            lastTitle.fillColor = TEXT_LIGHTBLACK;
            nowTitle.fillColor = _tintColor;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        _noticeBar.frame = CGRectMake(index*(VIEW_WIDTH/_titleArray.count), _titleHeight-3, (VIEW_WIDTH/_titleArray.count), 3);
        lastTitle.fillColor = TEXT_LIGHTBLACK;
        nowTitle.fillColor = _tintColor;
        _mainView.contentOffset = CGPointMake(VIEW_WIDTH*_indexOfSubView, 0);
    }

    _indexOfSubView = index;
}
- (void)touchUP:(UIControl *)sender{
    self.indexOfSubView = sender.tag;
}

- (void)setIndexOfSubView:(NSUInteger)indexOfSubView{
    NSUInteger lastIndex = _indexOfSubView;
    if (indexOfSubView<_titleArray.count) {
        _indexOfSubView = indexOfSubView;
        AMELabel * lastTitle = _titleLabelArray[lastIndex];
        AMELabel * nowTitle = _titleLabelArray[_indexOfSubView];
        if (_animation) {
            [UIView animateWithDuration:0.4 animations:^{
                _noticeBar.frame = CGRectMake(_indexOfSubView*(VIEW_WIDTH/_titleArray.count), _titleHeight-3, (VIEW_WIDTH/_titleArray.count), 3);
                lastTitle.fillColor = TEXT_LIGHTBLACK;
                nowTitle.fillColor = _tintColor;
                _mainView.contentOffset = CGPointMake(VIEW_WIDTH*_indexOfSubView, 0);
            } completion:^(BOOL finished) {
                
            }];
        }else{
            _noticeBar.frame = CGRectMake(_indexOfSubView*(VIEW_WIDTH/_titleArray.count), _titleHeight-3, (VIEW_WIDTH/_titleArray.count), 3);
            lastTitle.fillColor = TEXT_LIGHTBLACK;
            nowTitle.fillColor = _tintColor;
            _mainView.contentOffset = CGPointMake(VIEW_WIDTH*_indexOfSubView, 0);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
