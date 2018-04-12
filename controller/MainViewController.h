//
//  MainViewController.h
//  shishenjiyang
//
//  Created by Vino－lgc on 2016/12/5.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "AMEScrollViewController.h"
#import <MZTimerLabel.h>
#import <UserNotifications/UserNotifications.h>

@interface MainViewController : AMEScrollViewController

@property (nonatomic, strong) MZTimerLabel * timeLabel;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * finishTimeLabel;


- (void)registerNotificationWithDelayTime:(NSInteger )delaySecond title:(NSString *)title detail:(NSString *)detail identifier:(NSString *)identitfier;
- (void)removeAllNotification;
@end
