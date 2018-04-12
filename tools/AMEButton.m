//
//  AMEButton.m
//  TagViewTest
//
//  Created by Vino－lgc on 16/9/19.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "AMEButton.h"

#import "UIImage+ColorAtPoint.h"
#define kAlphaVisibleThreshold (0.1f)

@interface AMEButton()

@property(nonatomic, assign)CGFloat lastAlpha;

@property (nonatomic, assign) CGPoint previousTouchPoint;
@property (nonatomic, assign) BOOL previousTouchHitTestResponse;
@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UIImage *buttonBackground;

@end

@implementation AMEButton

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
        _lastAlpha = self.alpha;
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
    _lastAlpha = self.alpha;
    [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lastAlpha = self.alpha;
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self setup];
    }
    return self;
}

+ (instancetype)buttonWithType:(AMEButtonType)buttonType event:(void (^)())event{
    AMEButton * button = [AMEButton new];
    button.event = event;
    switch (buttonType) {
        case AMEButtonTypeClean:{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }break;
        case AMEButtonTypeBorder:{
            button.layer.borderWidth = 1.0;
            button.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
            break;
        case AMEButtonTypeRoundCorner:{
            button.layer.borderWidth = 1.0;
            button.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
            button.layer.cornerRadius = 5.0;
            button.layer.masksToBounds = YES;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
            break;
        case AMEButtonTypeBackGrounded:{
            button.layer.cornerRadius = 5.0;
            button.layer.masksToBounds = YES;
            button.backgroundColor = [UIColor colorWithRed:45/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    return button;
}

- (void)setup {
    [self updateImageCacheForCurrentState];
    [self resetHitTestCache];
}

#pragma mark - 判断图片在此点区域是否是透明的

- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forImage:(UIImage *)image {
    
    CGSize iSize = image.size;
    CGSize bSize = self.bounds.size;
    point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
    point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;
    
    UIColor *pixelColor = [image colorAtPoint:point];
    CGFloat alpha = 0.0;
    
    if ([pixelColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        
        [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    } else {
        CGColorRef cgPixelColor = [pixelColor CGColor];
        alpha = CGColorGetAlpha(cgPixelColor);
    }
    return alpha >= kAlphaVisibleThreshold;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.onlyShapeOfImage) {
        BOOL superResult = [super pointInside:point withEvent:event];
        if (!superResult) {
            return superResult;
        }
        
        if (CGPointEqualToPoint(point, self.previousTouchPoint)) {
            return self.previousTouchHitTestResponse;
        } else {
            self.previousTouchPoint = point;
        }
        
        BOOL response = NO;
        
        if (self.buttonImage == nil && self.buttonBackground == nil) {
            
            response = YES;
            
        } else if (self.buttonImage != nil && self.buttonBackground == nil) {
            
            response = [self isAlphaVisibleAtPoint:point forImage:self.buttonImage];
            
        } else if (self.buttonImage == nil && self.buttonBackground != nil) {
            
            response = [self isAlphaVisibleAtPoint:point forImage:self.buttonBackground];
            
        } else {
            
            if ([self isAlphaVisibleAtPoint:point forImage:self.buttonImage]) {
                response = YES;
            } else {
                response = [self isAlphaVisibleAtPoint:point forImage:self.buttonBackground];
            }
        }
        
        self.previousTouchHitTestResponse = response;
        return response;
    }else{
        return [super pointInside:point withEvent:event];
    }
}

#pragma mark - Accessors

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self updateImageCacheForCurrentState];
    [self resetHitTestCache];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [super setBackgroundImage:image forState:state];
    [self updateImageCacheForCurrentState];
    [self resetHitTestCache];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateImageCacheForCurrentState];
}

- (void)setHighlighted:(BOOL)highlighted {
    if (self.highlightEnable) {
        [super setHighlighted:highlighted];
    }
    [self updateImageCacheForCurrentState];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateImageCacheForCurrentState];
}


#pragma mark - Helper methods

- (void)updateImageCacheForCurrentState {
    _buttonBackground = [self currentBackgroundImage];
    _buttonImage = [self currentImage];
}

- (void)resetHitTestCache {
    self.previousTouchPoint = CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN);
    self.previousTouchHitTestResponse = NO;
}



#pragma mark - T&A model
- (void)buttonClick{
    if (self.event) {
        self.event();
    }
}

//- (void)beginHighLight{
//    self.alpha = _lastAlpha*0.7;
//}
//- (void)endHighLight{
//    self.alpha = _lastAlpha;
//}
//
//#pragma mark - getter&setter
//- (void)setHighlightEnable:(BOOL)highlightEnable{
//    if (!_highlightEnable == highlightEnable) {
//        _highlightEnable = highlightEnable;
//        if (_highlightEnable) {
//            [self addTarget:self action:@selector(beginHighLight) forControlEvents:UIControlEventTouchDown];
//            [self addTarget:self action:@selector(endHighLight) forControlEvents:UIControlEventTouchUpInside];
//            [self addTarget:self action:@selector(endHighLight) forControlEvents:UIControlEventTouchUpOutside];
//        }else{
//            [self removeTarget:self action:@selector(beginHighLight) forControlEvents:UIControlEventTouchDown];
//            [self removeTarget:self action:@selector(endHighLight) forControlEvents:UIControlEventTouchUpInside];
//            [self removeTarget:self action:@selector(endHighLight) forControlEvents:UIControlEventTouchUpOutside];
//        }
//    }
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
