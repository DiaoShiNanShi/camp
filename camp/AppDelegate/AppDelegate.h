//
//  AppDelegate.h
//  camp
//
//  Created by 张三好 on 2017/5/2.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

//封装了一个宏 用来方便输入文字--实际是文字对应的key
#define CustomStr(key) [(AppDelegate *)[[UIApplication sharedApplication] delegate] showText:(key)];

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, copy) NSString *lan;

-(NSString *)showText:(NSString *)key;  //用来替代以往的 NSString 方法

- (void)saveContext;

- (void)restoreRootViewController:(UIViewController *)rootViewController;
@end

