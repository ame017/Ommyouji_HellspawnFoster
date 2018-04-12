//
//  MainViewController.m
//  shishenjiyang
//
//  Created by Vino－lgc on 2016/12/5.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "MainViewController.h"

#import "TimeSetViewController.h"


@interface MainViewController ()<MZTimerLabelDelegate>


@end

@implementation MainViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"式神寄养";
    
    [self.mainView addSubview:self.timeLabel];
    [self.mainView addSubview:self.finishTimeLabel];
    
    [self.mainView addSubview:self.imageView];
    
    AMEButton * setSixHour = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        [self.timeLabel reset];
        [self.imageView stopAnimating];
        
        //更新timelabel
        [self.timeLabel setCountDownTime:60*60*6];
        [self.timeLabel start];
        //更新finishtimelabel
        NSDate * date = [NSDate dateWithTimeIntervalSinceNow:60*60*6];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"寄养将会在 HH:mm 结束";
        self.finishTimeLabel.text = [formatter stringFromDate:date];
        //动画开始
        [self.imageView startAnimating];
        
        

        
//        [[UNUserNotificationCenter currentNotificationCenter]removeAllPendingNotificationRequests];
        [self removeAllNotification];
        [self registerNotificationWithDelayTime:20 title:@"设置成功" detail:self.finishTimeLabel.text identifier:@"success"];
        [self registerNotificationWithDelayTime:3*60*60 title:@"式神寄养剩余3小时" detail:@"注意规划时间哦~" identifier:@"halfTime"];
        [self registerNotificationWithDelayTime:6*60*60-60*3 title:@"式神寄养剩余3分钟" detail:@"快要刷新了 可以上游戏活动一下筋骨了😈" identifier:@"threeMin"];
        [self registerNotificationWithDelayTime:6*60*60 title:@"式神寄养已到期" detail:@"赶紧上线补式神啦w(ﾟДﾟ)w" identifier:@"timeUp"];
        [SVProgressHUD showSuccessWithStatus:@"设置成功\n将在计时到期时发送推送提醒"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
    [setSixHour setTitle:@"重置为6小时" forState:UIControlStateNormal];
    [self.mainView addSubview:setSixHour];
    AMEButton * setNewTime = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        [self.navigationController pushViewController:[TimeSetViewController new] animated:YES];
    }];
    [setNewTime setTitle:@"自定义时间" forState:UIControlStateNormal];
    [setNewTime setBackgroundColor:BTN_LIGHT_GREEN];
    [self.mainView addSubview:setNewTime];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60*(HEIGHT/667.0));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(WIDTH);
    }];
    [self.finishTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.view);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(150);
    }];
    [setSixHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    [setNewTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(setSixHour.mas_bottom).offset(HEIGHT==568.0f?20:40);
        make.centerX.width.height.mas_equalTo(setSixHour);
    }];
    
    UILabel * desc = [UILabel new];
    desc.textAlignment = NSTextAlignmentCenter;
    desc.text = @"请根据游戏中式神寄养的剩余时间设置时间\n当计时完成时将会发送消息提醒您去重新寄养式神哦";
    desc.textColor = TEXT_LIGHTBLACK;
    desc.font = [UIFont fontWithName:SYSTEM_FONT size:12];
    desc.numberOfLines = 2;
    [self.mainView addSubview:desc];
    
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-20);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - timerDelegate
//-(void)timerLabel:(MZTimerLabel*)timerLabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType{
//    static BOOL isDone;
//    if (time <= 21600-12 && isDone == NO) {
//        NSLog(@"done");
//        [self removeAllNotification];
//        isDone = YES;
//    }
//}
-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [self.imageView stopAnimating];
    self.finishTimeLabel.text = @"寄养尚未开始";
}

#pragma mark - notificationMethod
- (void)registerNotificationWithDelayTime:(NSInteger )delaySecond title:(NSString *)title detail:(NSString *)detail identifier:(NSString *)identitfier{
    //ios10
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0) {
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        
        //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
        UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:detail
                                                             arguments:nil];
        content.sound = [UNNotificationSound defaultSound];
        
        // 在 delaySecond 后推送本地推送
        UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                      triggerWithTimeInterval:delaySecond repeats:NO];
        
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:identitfier
                                                                              content:content trigger:trigger];
        
        //添加推送成功后的处理！
        [center addNotificationRequest:request withCompletionHandler:nil];
    }else{
        //ios8-9
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        // 设置触发通知的时间
        NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:delaySecond];
        notification.fireDate = fireDate;
        // 时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
//        // 设置重复的间隔
//        notification.repeatInterval = 0;
        
        // 通知内容
        notification.alertBody =  [NSString stringWithFormat:@"%@\n%@",title,detail];
        // 通知被触发时播放的声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 添加标识
        notification.userInfo = @{@"identifier":identitfier};
        
        // 执行通知注册  
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}
- (void)removeAllNotification{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0){
        [[UNUserNotificationCenter currentNotificationCenter]removeAllPendingNotificationRequests];
    }else{
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}
#pragma mark - getter
- (MZTimerLabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [MZTimerLabel new];
        _timeLabel.timerType = MZTimerLabelTypeTimer;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont fontWithName:SYSTEM_FONT size:50.0f];
        _timeLabel.delegate = self;
    }
    return _timeLabel;
}

- (MZTimerLabel *)getNewTimeLabel{
    _timeLabel = [MZTimerLabel new];
    _timeLabel.timerType = MZTimerLabelTypeTimer;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont fontWithName:SYSTEM_FONT size:50.0f];
    _timeLabel.delegate = self;
    return _timeLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        NSMutableArray * array  = [NSMutableArray arrayWithCapacity:18];
        for (int i = 0; i < 18; i++) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"animation_%d",i]]];
        }
        _imageView.animationDuration = 5.0;
        _imageView.animationImages = array;
        _imageView.image = [UIImage imageNamed:@"animation_0"];
    }
    return _imageView;
}

- (UILabel *)finishTimeLabel{
    if (!_finishTimeLabel) {
        _finishTimeLabel = [UILabel new];
        _finishTimeLabel.textAlignment = NSTextAlignmentCenter;
        _finishTimeLabel.text = @"寄养尚未开始";
        _finishTimeLabel.textColor = TEXT_LIGHTBLACK;
        _finishTimeLabel.font = [UIFont fontWithName:SYSTEM_FONT size:12];
    }
    return _finishTimeLabel;
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
