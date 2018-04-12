//
//  AppDelegate.h
//  shishenjiyang
//
//  Created by Vino－lgc on 2016/12/5.
//  Copyright © 2016年 AME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

