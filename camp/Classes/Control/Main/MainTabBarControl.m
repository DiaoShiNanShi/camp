//
//  MainTabBarControl.m
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "MainTabBarControl.h"
#import "verticalLayoutControl.h"
#import "LiveFramLayoutControl.h"

@interface MainTabBarControl ()

@end

@implementation MainTabBarControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar setBarTintColor:RGBACOLOR(15, 15, 15, 1)];
    self.tabBar.tintColor  = RGBACOLOR(233, 197, 123, 1);
    /* 解档数据 */
    NSData *UnarchiveDataBase = [NSData dataWithContentsOfFile:LocalDataBaseModelFilePath];
    DataBaseModel * dataBase = [NSKeyedUnarchiver unarchiveObjectWithData:UnarchiveDataBase];
    /* 电子游戏界面 */
    if([dataBase.params[@"gameFrame"].paramValue isEqualToString:@"2"]){
        // verticalLayoutControlID
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.childViewControllers];
        verticalLayoutControl *Vc = [KMainStoryboard instantiateViewControllerWithIdentifier:@"verticalLayoutControlID"];
        CampBaseNavigationController *_Vc_Nav = [[CampBaseNavigationController alloc] initWithRootViewController:Vc];
        _Vc_Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"电子游戏" image:[UIImage imageNamed:@"电子游戏"] selectedImage:[UIImage imageNamed:@"电子游戏"]];
        [arr replaceObjectAtIndex:2 withObject:_Vc_Nav];
        [self setValue:arr forKey:@"childViewControllers"];
    }
    /*  真人视频 */
    if(YES){
        // LiveFramLayoutControlID
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.childViewControllers];
        LiveFramLayoutControl *Vc = [KMainStoryboard instantiateViewControllerWithIdentifier:@"LiveFramLayoutControlID"];
        CampBaseNavigationController *_Vc_Nav = [[CampBaseNavigationController alloc] initWithRootViewController:Vc];
        _Vc_Nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"真人视频" image:[UIImage imageNamed:@"真人视频"] selectedImage:[UIImage imageNamed:@"真人视频"]];
        [arr replaceObjectAtIndex:1 withObject:_Vc_Nav];
        [self setValue:arr forKey:@"childViewControllers"];
    }
    
    
}


@end
