//
//  AMELabel.m
//  AMELabelTest
//
//  Created by Apple on 16/5/21.
//  Copyright © 2016年 AME studio Co., LTD. All rights reserved.
//

#import "AMELabel.h"

@implementation AMELabel
{
    NSTimer * _timer;
    NSString * _allText;
    NSUInteger _textIndex;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.verticalAlignment = VerticalAlignmentMiddle;
        self.fillColor = [UIColor blackColor];
        self.strokeColor = [UIColor clearColor];
        self.strokeWidth = 0.0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.verticalAlignment = VerticalAlignmentMiddle;
        self.fillColor = [UIColor blackColor];
        self.strokeColor = [UIColor clearColor];
        self.strokeWidth = 0.0;
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment{
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

- (void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

- (void)setStrokeWidth:(float)strokeWidth{
    _strokeWidth = strokeWidth;
    [self setNeedsDisplay];
}

- (void)startAnimation{
    [_timer invalidate];
    _textIndex = 1;
    _allText = self.text;
    self.text = @"";
    self.hidden = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(running) userInfo:nil repeats:YES];
}
- (void)stopAnimation{
    [_timer invalidate];
}

- (void)running{
    self.text = [_allText substringToIndex:_textIndex];
    [self setNeedsDisplay];
    if (_textIndex == _allText.length) {
        [_timer invalidate];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"textAnimationDone" object:nil];
        _textIndex = 1;
        return ;
    }
    _textIndex++;
}

- (void)drawRect:(CGRect)rect{
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(c, self.strokeWidth);
        CGContextSetLineJoin(c, kCGLineJoinRound);
        CGContextSetTextDrawingMode(c, kCGTextStroke);
        self.textColor = self.strokeColor;
        [self drawTextInRect:rect];
        self.textColor = self.fillColor;
        CGContextSetTextDrawingMode(c, kCGTextFill);
        [self drawTextInRect:rect];
}

-(float)height{
    self.numberOfLines = 0;
    self.lineBreakMode =  NSLineBreakByWordWrapping;
    CGRect textFrame = self.frame;
    NSString * str = self.text;
    
    NSDictionary * dic = @{NSFontAttributeName:self.font};
    float height = [str boundingRectWithSize:CGSizeMake(textFrame.size.width, 3000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}

-(CGSize)sizeAuto{
    self.lineBreakMode = NSLineBreakByTruncatingTail;
    NSString * str = self.text;
    NSDictionary * dic = @{NSFontAttributeName:self.font};
    CGSize size = self.frame.size;
    CGPoint origin = self.frame.origin;
    CGRect labelRect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
//    self.frame = CGRectMake(origin.x+(size.width-labelRect.size.width)/2.0, origin.y, labelRect.size.width, size.height);
    self.frame = CGRectMake(origin.x, origin.y, labelRect.size.width+1, size.height);
    return labelRect.size;
}

@end
