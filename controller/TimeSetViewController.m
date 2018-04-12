//
//  TimeSetViewController.m
//  shishenjiyang
//
//  Created by Vino－lgc on 2016/12/6.
//  Copyright © 2016年 AME. All rights reserved.
//

#import "TimeSetViewController.h"
#import "MainViewController.h"

@interface TimeSetViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * hourField;
@property (nonatomic, strong) UITextField * minuteField;

@end

@implementation TimeSetViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置时间";
    [self.textFieldArray addObjectsFromArray:@[self.hourField,self.minuteField]];
    
    [self.mainView addSubview:self.hourField];
    [self.mainView addSubview:self.minuteField];
    
    [self.hourField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(150);
    }];
    [self.minuteField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hourField.mas_bottom).offset(30);
        make.centerX.height.width.mas_equalTo(self.hourField);
    }];
    
    AMEButton * fiveHour = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        self.hourField.text = @"5";
    }];
    [fiveHour setTitle:@"5小时" forState:UIControlStateNormal];
    [self.mainView addSubview:fiveHour];
    
    AMEButton * fourHour = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        self.hourField.text = @"4";
    }];
    [fourHour setTitle:@"4小时" forState:UIControlStateNormal];
    [self.mainView addSubview:fourHour];
    
    AMEButton * threeHour = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        self.hourField.text = @"3";
    }];
    [threeHour setTitle:@"3小时" forState:UIControlStateNormal];
    [self.mainView addSubview:threeHour];
    
    AMEButton * twoHour = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        self.hourField.text = @"2";
    }];
    [twoHour setTitle:@"2小时" forState:UIControlStateNormal];
    [self.mainView addSubview:twoHour];
    
    AMEButton * oneHour = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        self.hourField.text = @"1";
    }];
    [oneHour setTitle:@"1小时" forState:UIControlStateNormal];
    [self.mainView addSubview:oneHour];
    
    AMEButton * helfHour = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        self.minuteField.text = @"30";
    }];
    [helfHour setTitle:@"30分钟" forState:UIControlStateNormal];
    [self.mainView addSubview:helfHour];
    
    AMEButton * plus = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        if ([self.minuteField.text integerValue]>=50 && [self.hourField.text integerValue] == 5) {
            UIAlertController * alert = [AMETools getSimpleAlertWithTitle:@"提示" message:@"不能再增加了" okActionTitle:@"好的" okHandler:^(UIAlertAction *action) {
                
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            self.minuteField.text = [self.minuteField.text stringCalculate:@"+10" breviary:-1];
            if ([self.minuteField.text integerValue]>=60) {
                self.hourField.text = [self.hourField.text stringCalculate:@"+1" breviary:-1];
                self.minuteField.text = [self.minuteField.text stringCalculate:@"-60" breviary:-1];
            }
        }
    }];
    [plus setTitle:@"+10分钟" forState:UIControlStateNormal];
    plus.backgroundColor = AME_FILM_TINT;
    [self.mainView addSubview:plus];
    
    AMEButton * minus = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        if (([self.minuteField.text integerValue]<=10 || [self.minuteField.text isEqualToString:@""]) && ([self.hourField.text integerValue] == 0 || [self.hourField.text isEqualToString:@""])) {
            UIAlertController * alert = [AMETools getSimpleAlertWithTitle:@"提示" message:@"不能再减少了" okActionTitle:@"好的" okHandler:^(UIAlertAction *action) {
                
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            self.minuteField.text = [self.minuteField.text stringCalculate:@"-10" breviary:-1];
            if ([self.minuteField.text integerValue]<0) {
                self.hourField.text = [self.hourField.text stringCalculate:@"-1" breviary:-1];
                self.minuteField.text = [self.minuteField.text stringCalculate:@"+60" breviary:-1];
            }
        }
    }];
    [minus setTitle:@"-10分钟" forState:UIControlStateNormal];
    minus.backgroundColor = AME_FILM_TINT;
    [self.mainView addSubview:minus];
    
    [fiveHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.minuteField.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view).offset(WIDTH/11.0);
        make.width.mas_equalTo(WIDTH/11.0*4.0);
        make.height.mas_equalTo(30);
    }];
    [fourHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fiveHour);
        make.left.mas_equalTo(fiveHour.mas_right).offset(WIDTH/11.0);
        make.width.height.mas_equalTo(fiveHour);
    }];
    [threeHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fiveHour.mas_bottom).offset(20);
        make.left.width.height.mas_equalTo(fiveHour);
    }];
    [twoHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(threeHour);
        make.left.width.height.mas_equalTo(fourHour);
    }];
    [oneHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(threeHour.mas_bottom).offset(20);
        make.left.width.height.mas_equalTo(fiveHour);
    }];
    [helfHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneHour);
        make.left.width.height.mas_equalTo(fourHour);
    }];
    [minus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneHour.mas_bottom).offset(20);
        make.left.width.height.mas_equalTo(fiveHour);
    }];
    [plus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(minus);
        make.left.width.height.mas_equalTo(fourHour);
    }];
    //提交
    AMEButton * submit = [AMEButton buttonWithType:AMEButtonTypeBackGrounded event:^{
        MainViewController * main = self.navigationController.viewControllers[0];
        [main.timeLabel reset];
        [main.imageView stopAnimating];
        
        NSInteger minute;
        NSInteger hour;
        if ([self.minuteField.text isEqualToString:@""]) {
            minute = 0;
        }else{
            minute = [self.minuteField.text integerValue];
        }
        if ([self.hourField.text isEqualToString:@""]) {
            hour = 0;
        }else{
            hour = [self.hourField.text integerValue];
        }
        
        [main.timeLabel setCountDownTime:60*minute+60*60*hour];
        [main.timeLabel start];
        
        NSDate * date = [NSDate dateWithTimeIntervalSinceNow:60*minute+60*60*hour];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"寄养将会在 HH:mm 结束";
        main.finishTimeLabel.text = [formatter stringFromDate:date];
        
        [main.imageView startAnimating];

        [main removeAllNotification];
        [main registerNotificationWithDelayTime:20 title:@"设置成功" detail:main.finishTimeLabel.text identifier:@"success"];
        if (hour>=3 && minute!=0) {
            [main registerNotificationWithDelayTime:60*minute+60*60*hour-3600*3 title:@"式神寄养剩余3小时" detail:@"注意规划时间哦~" identifier:@"halfTime"];
        }
        [main registerNotificationWithDelayTime:60*minute+60*60*hour-60*3 title:@"式神寄养剩余3分钟" detail:@"快要刷新了 可以上游戏活动一下筋骨了😈" identifier:@"threeMin"];
        [main registerNotificationWithDelayTime:60*minute+60*60*hour title:@"式神寄养已到期" detail:@"赶紧上线抢寄养位置啦w(ﾟДﾟ)w" identifier:@"timeUp"];
        [SVProgressHUD showSuccessWithStatus:@"设置成功\n将在计时到期时发送推送提醒"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    submit.backgroundColor = BTN_LIGHT_GREEN;
    [submit setTitle:@"确认" forState:UIControlStateNormal];
    [self.mainView addSubview:submit];
    
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(plus.mas_bottom).offset(40);
        make.left.mas_equalTo(fiveHour);
        make.right.mas_equalTo(fourHour);
        make.height.mas_equalTo(35);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter & setter
- (UITextField *)hourField{
    if (!_hourField) {
        _hourField                     = [UITextField new];
        _hourField.backgroundColor     = [UIColor whiteColor];
        _hourField.placeholder         = @"小时(不填为0)";
//        _hourField.text                = @"0";
        _hourField.layer.cornerRadius  = 5.0;
        _hourField.layer.masksToBounds = YES;
        _hourField.layer.borderColor   = TEXT_LIGHTBLACK.CGColor;
        _hourField.layer.borderWidth   = 0.8;
        _hourField.leftView            = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
        _hourField.leftViewMode        = UITextFieldViewModeAlways;
        _hourField.delegate            = self;
        _hourField.returnKeyType       = UIReturnKeyDone;
        _hourField.keyboardType        = UIKeyboardTypeNumberPad;
    }
    return _hourField;
}

- (UITextField *)minuteField{
    if (!_minuteField) {
        _minuteField                     = [UITextField new];
        _minuteField.backgroundColor     = [UIColor whiteColor];
        _minuteField.placeholder         = @"分钟(不填为0)";
//        _minuteField.text                = @"0";
        _minuteField.layer.cornerRadius  = 5.0;
        _minuteField.layer.masksToBounds = YES;
        _minuteField.layer.borderColor   = TEXT_LIGHTBLACK.CGColor;
        _minuteField.layer.borderWidth   = 0.8;
        _minuteField.leftView            = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
        _minuteField.leftViewMode        = UITextFieldViewModeAlways;
        _minuteField.delegate            = self;
        _minuteField.returnKeyType       = UIReturnKeyDone;
        _minuteField.keyboardType        = UIKeyboardTypeNumberPad;
    }
    return _minuteField;
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
