//
//  app_Geneal.h
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#ifndef app_Geneal_h
#define app_Geneal_h

#define KAppDelegate                    ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define KMainStoryboard                 [UIStoryboard storyboardWithName:@"Main" bundle:nil]


/* 持久化   数据 */
#define persistenceData                        [NSUserDefaults standardUserDefaults]

/* Key */
#define PD_IsRememberAccount         @"isRememberAccount"
#define PD_UserInfo                             @"pd_userInfo"
#define PD_Account                              @"pd_account"
#define PD_Cookie                                 @"pd_Cookie"


/*                   IdentFiler_Control*/
#define KMainTabBarIdentFiler                                           @"MainTabBarControlIdentFiler"

#endif /* app_Geneal_h */
