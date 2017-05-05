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

#define CGRectStatus            [[UIApplication sharedApplication] statusBarFrame]
#define CGRectNav               self.navigationController.navigationBar.frame
#define CGRectTab               self.tabBarController.tabBar.frame

/* 电子游戏界面Collection的宽高 */
#define KGameCollectionCell_MG_Width                                 (kScreenWidth - 50) / 4
#define KGameCollectionCell_PT_Width                                   (kScreenWidth - 40) / 3
#define KGameCollectionCell_BB_Width                                   kScreenWidth
#define KGameCollectionCell_AG_Width                                  (kScreenWidth - 30) / 2
#define KGameCollectionCell_XT_Width                                   kScreenWidth
#define KGameCollectionCellHeight                                           (kScreenWidth - 50) / 4 + 40


#define KGamePopViewHeight                                                    300

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
