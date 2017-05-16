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
#define KDiskInfoStoryboard           [UIStoryboard storyboardWithName:@"DiskInfo" bundle:nil]
#define kScreenWidth                        CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight                       CGRectGetHeight([UIScreen mainScreen].bounds)

#define CGRectStatus            [[UIApplication sharedApplication] statusBarFrame]
#define CGRectNav               self.navigationController.navigationBar.frame
#define CGRectTab               self.tabBarController.tabBar.frame
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define KMainStoryboard         [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define kMainDelegate           ((AppDelegate *)[UIApplication sharedApplication].delegate)

/* 电子游戏界面Collection的宽高 */
#define KGameCollectionCell_MG_Width                                 (kScreenWidth - 50) / 4
#define KGameCollectionCell_PT_Width                                   (kScreenWidth - 40) / 3
#define KGameCollectionCell_BB_Width                                   kScreenWidth
#define KGameCollectionCell_AG_Width                                  (kScreenWidth - 30) / 2
#define KGameCollectionCell_XT_Width                                   kScreenWidth
#define KGameCollectionCellHeight                                           (kScreenWidth - 50) / 4 + 40


/* 发送通知 - 更新文字 */
#define NOTFICATION_NAME                                                @"Update_Text"

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

/* 当前盘面ID */
#define PD_DiskID                               @"pd_diskID"

/* 获取本地保存的信息 */
#define LocalDataBaseModelFilePath          [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dataBaseModel.achive"]

/* 通用页面加载数据 */
#define CommonDataBaseModel                 ((DataBaseModel *)[NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:LocalDataBaseModelFilePath]])

/*                   IdentFiler_Control*/
#define KMainTabBarIdentFiler                                           @"MainTabBarControlIdentFiler"

/*                  IdentFiler_GameCollectionCell */
#define KGamesCollectionViewCell                                       @"KGamesCollectionViewCellIdentfiler"

#endif /* app_Geneal_h */
