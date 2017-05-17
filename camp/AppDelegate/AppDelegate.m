//
//  AppDelegate.m
//  camp
//
//  Created by 张三好 on 2017/5/2.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // 设置键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    // 请求页面数据 并归档
    [self getDataBase];
    
    /* 获取当前语言配置 */
    [self getLanguage];
    return YES;
}
- (void) getLanguage{
    if(self.lan == nil || [self.lan isEqualToString:@""]){
        /**
         * 获取用户的语言偏好设置列表，该列表对应于IOS中Setting>General>Language弹出的面板中的语言列表。
         */
        NSArray *languages = [NSLocale preferredLanguages];
        /**
         *  第0个元素即为当前用户设置的语言
         */
        NSString *language = [languages objectAtIndex:0];
        self.lan = @"zh-Hans";
//        if ([language hasPrefix:@"zh-Hans"]) {
//            self.lan = @"zh-Hans";
//        }else{
//            self.lan = @"en";
//        }
    }
}

-  (void) getDataBase{
    @try {
        /* 解档数据 */
        NSData *UnarchiveDataBase = [NSData dataWithContentsOfFile:LocalDataBaseModelFilePath];
        DataBaseModel *dataBase;
        if(UnarchiveDataBase != nil){
            dataBase = [NSKeyedUnarchiver unarchiveObjectWithData:UnarchiveDataBase];
            /* 更新本地保存版本号 */
            [persistenceData setValue:dataBase.version forKey:PD_Version];
        }
        NSMutableDictionary *parment = [NSMutableDictionary dictionary];
        [parment setValue:@"CS" forKey:@"plantform"];
        [parment setValue:@"123456" forKey:@"merID"];
        [parment setValue:dataBase == nil? @"": dataBase.version forKey:@"version"];
//        [parment setValue: @"" forKey:@"version"];
        
        [[CSNetWorkIngManager sharNetWorkManager] Post:DataBase withCommletionHandler:^(id result, NSError *error) {
            /* 如果版本号相同 则不需要进行下一步 */
            if([[persistenceData valueForKey:PD_Version] isEqualToString:result[@"version"]]){
                return ;
            }
            DataBaseModel *model = [DataBaseModel mj_objectWithKeyValues:result];
            /* 写入到文件中 */
            NSData *baseData = [NSKeyedArchiver archivedDataWithRootObject:model];
            [baseData writeToFile:LocalDataBaseModelFilePath atomically:YES];
            NSLog(@"a");
        } withParameters:parment withcompletionHandlerError:^(NSString *code) {
            NSLog(@"");
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

-(NSString *)showText:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle] pathForResource:_lan ofType:@"lproj"];
    return [[NSBundle bundleWithPath:path] localizedStringForKey:key value:nil table:@"CustomLocalizable"];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"camp"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}
// 动画设置
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow* window = self.window;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


@end
