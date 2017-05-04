//
//  GameElectronicMenu.h
//  camp
//
//  Created by 张三好 on 2017/5/4.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameElectronicMenu : UIScrollView

/* 菜单选中 Block 回调 */
@property (nonatomic, copy) void(^didSelectGameMenu)(NSInteger selectIndex);
@end
