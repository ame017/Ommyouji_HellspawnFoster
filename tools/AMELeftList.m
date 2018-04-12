//
//  AMELeftList.m
//  AMEelemeDEMO
//
//  Created by syetc053 on 16/7/7.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import "AMELeftList.h"


#define VIEW_WIDTH self.frame.size.width
#define VIEW_HEIGHT self.frame.size.height
#define CONTROL_HEIGHT 130
#define MIDDLE VIEW_HEIGHT/2.0+CONTROL_HEIGHT

@implementation AMELeftList
{
    UIControl * _tempSelectedControl;
    NSMutableArray * _titleLabelArray;
    NSMutableArray * _controlTintArray;
    NSMutableArray * _ControlArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _tempSelectedControl = [[UIControl alloc]init];
        _tintColor = SYSTEM_BLUE;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.backgroundColor = VIEW_GRAY;
        _titleLabelArray = [NSMutableArray arrayWithCapacity:0];
        _controlTintArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame listArray:(NSArray<NSString *> *)listArray tintColor:(UIColor *)tintColor{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _tempSelectedControl = [[UIControl alloc]init];
        
        _listArray = listArray;
        _tintColor = SYSTEM_BLUE;
        
        _titleLabelArray = [NSMutableArray arrayWithCapacity:0];
        _controlTintArray = [NSMutableArray arrayWithCapacity:0];
        _ControlArray = [NSMutableArray arrayWithCapacity:0];
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
//        self.bounces = NO;
        self.backgroundColor = VIEW_GRAY;
        
        if (tintColor) {
            _tintColor = tintColor;
        }
        UIView * rightLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        rightLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [self addSubview:rightLine];
        
        UIView * topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 1)];
        topLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [self addSubview:topLine];
        
        
        for (int i=0; i<_listArray.count; i++) {
            UIView * bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, (i+1)*CONTROL_HEIGHT-1, VIEW_WIDTH, 1)];
            bottomLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
            [self addSubview:bottomLine];
            
            UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, i*CONTROL_HEIGHT, VIEW_WIDTH, CONTROL_HEIGHT)];
            control.backgroundColor = [UIColor clearColor];
            control.tag = i;
            [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:control];
            [_ControlArray addObject:control];
            
            UIView * controlTintView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, CONTROL_HEIGHT)];
            controlTintView.backgroundColor = _tintColor;
            [control addSubview:controlTintView];
            [_controlTintArray addObject:controlTintView];
            
            if (control.frame.origin.y+CONTROL_HEIGHT>VIEW_HEIGHT) {
                self.contentSize = CGSizeMake(VIEW_WIDTH, control.frame.origin.y+CONTROL_HEIGHT);
            }
            AMELabel * desc = [[AMELabel alloc]initWithFrame:CGRectMake((VIEW_WIDTH-60)/2.0, 10, 60, 60)];
            desc.text = [_listArray[i] substringToIndex:1];
            desc.layer.borderWidth = 1.0;
            desc.layer.borderColor = [UIColor blackColor].CGColor;
            UIColor * color;
            switch (i) {
                case 0:
                    color = BLUE_TINT;
                    break;
                case 1:
                    color = BTN_LIGHT_GREEN;
                    break;
                case 2:
                    color = [UIColor orangeColor];
                    break;
                case 3:
                    color = UIColorFromRGB(0xCC99CC);
                    break;
                case 4:
                    color = UIColorFromRGB(0x009900);
                    break;
            }
            desc.backgroundColor = color;
            desc.fillColor = [UIColor whiteColor];
            desc.font = [UIFont fontWithName:@"Helvetica-Bold" size:48.0f];
            desc.textAlignment = NSTextAlignmentCenter;
            desc.verticalAlignment = VerticalAlignmentMiddle;
            [control addSubview:desc];
            
            AMELabel * title = [[AMELabel alloc]initWithFrame:CGRectMake(7, 80, VIEW_WIDTH-14, 50)];
            title.numberOfLines = 2;
            title.text = _listArray[i];
            CGFloat fontSize = WIDTH*(18/320.0f)<30.0f?WIDTH*(18/320.0f):30.0f;
            title.font = [UIFont systemFontOfSize:fontSize];
            title.textAlignment = NSTextAlignmentCenter;
            if (i==0) {
                control.selected = YES;
                title.fillColor = _tintColor;
                control.backgroundColor = [UIColor whiteColor];
                controlTintView.hidden = NO;
                _tempSelectedControl = control;
            }else{
                control.selected = NO;
                title.fillColor = TEXT_LIGHTBLACK;
                controlTintView.hidden = YES;
            }
            [control addSubview:title];
            [_titleLabelArray addObject:title];
        }
        
        self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height+90);
        rightLine.frame = CGRectMake(VIEW_WIDTH-1, -200, 1, self.contentSize.height+400);
    }
    return self;
}

- (void)setNowSectionindex:(NSUInteger)nowSectionindex{
    _nowSectionindex = nowSectionindex;
    
    
    UIControl * control = _ControlArray[_nowSectionindex];
    if (control.selected == NO) {
        control.selected = YES;
        _tempSelectedControl.selected = NO;
    
        AMELabel * lastTitle = _titleLabelArray[_tempSelectedControl.tag];
        AMELabel * newTitle = _titleLabelArray[_nowSectionindex];
        lastTitle.fillColor = TEXT_LIGHTBLACK;
        newTitle.fillColor = _tintColor;
        UIView * lastTintView = _controlTintArray[_tempSelectedControl.tag];
        UIView * newTintView = _controlTintArray[_nowSectionindex];
        lastTintView.hidden = YES;
        newTintView.hidden = NO;

        control.backgroundColor = [UIColor whiteColor];
        _tempSelectedControl.backgroundColor = [UIColor clearColor];
        
        //自动滚动
        if (self.contentSize.height>self.frame.size.height) {
            float move = self.contentOffset.y+(control.frame.origin.y-self.contentOffset.y-MIDDLE);
            if (move<0) {
                move=0;
            }else if (move>self.contentSize.height-VIEW_HEIGHT){
                move = self.contentSize.height-VIEW_HEIGHT;
            }
            [self setContentOffset:CGPointMake(0,move) animated:YES];
        }
        
        _tempSelectedControl = control;
    }
}


- (void)controlClick:(UIControl *)control{
    self.nowSectionindex = control.tag;
    [self.cellDelegate clickLeftSelectScrollButton:control.tag];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
