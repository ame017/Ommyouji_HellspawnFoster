//
//  AMEHeightLightControl.m
//  AMEelemeDEMO
//
//  Created by Apple on 16/6/29.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import "AMEHighLightControl.h"
@interface AMEHighLightControl()

@property (nonatomic,assign) CGFloat lastAlpha;
@property (copy) void (^event) ();

@end
@implementation AMEHighLightControl



- (instancetype)initWithFrame:(CGRect)frame event:(void (^)())event{
    self = [super initWithFrame:frame];
    if (self) {
        _lastAlpha = self.alpha;
        self.event = event;
        [self addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithEvent:(void (^)())event{
    self = [super init];
    if (self) {
        _lastAlpha = self.alpha;
        self.event = event;
        [self addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lastAlpha = self.alpha;
        [self addTarget:self action:@selector(down) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - T&A model
- (void)buttonClick{
    if (self.event) {
        self.event();
    }
}

- (void)down{
    self.alpha = _lastAlpha*0.7;
}

- (void)up{
    self.alpha = _lastAlpha;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
