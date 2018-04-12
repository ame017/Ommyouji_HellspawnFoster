//
//  AMETransitionView.h
//  AMEelemeDEMO
//
//  Created by syetc053 on 16/6/30.
//  Copyright © 2016年 AMEstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMETools;

@interface AMETransitionView : UIView

@property (nonatomic,retain) NSArray * images;
@property (nonatomic) float autoSwipeInterval;
@property (nonatomic) BOOL pageViewHidden;//default is NO;

- (void)startAutoSwipe;
- (void)stopAutoSwipe;
@end
