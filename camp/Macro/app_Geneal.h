//
//  app_Geneal.h
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#ifndef app_Geneal_h
#define app_Geneal_h

#define KAppDelegate                       ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define KMainStoryboard                 [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define kScreenWidth                        CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight                       CGRectGetHeight([UIScreen mainScreen].bounds)


/* 持久化   数据 */
#define persistenceData                        [NSUserDefaults standardUserDefaults]

/* Key */
#define PD_IsRememberAccount         @"isRememberAccount"
#define PD_UserInfo                             @"pd_userInfo"
#define PD_Account                              @"pd_account"
#define PD_Cookie                                @"pd_Cookie"
#define PD_DataBaseModel                @"pd_DataBaseModel"
#define PD_Version                              @"pd_Version"

/* 获取本地保存的信息 */
#define LocalDataBaseModelFilePath          [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dataBaseModel.achive"]

/*                   IdentFiler_Control*/
#define KMainTabBarIdentFiler                                           @"MainTabBarControlIdentFiler"

/*                  IdentFiler_GameCollectionCell */
#define KGamesCollectionViewCell                                       @"KGamesCollectionViewCellIdentfiler"

#endif /* app_Geneal_h */
