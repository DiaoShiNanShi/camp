//
//  DataBaseModel.h
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@class gameGroupModel;
@class gameModel;
@interface DataBaseModel : JSONModel<NSCoding>

/* 游戏分组 */
@property (nonatomic, strong) NSArray<gameGroupModel *> *gameGroups;

/* 所有游戏*/
@property (nonatomic, strong) NSDictionary *games;

/* 最新版本号 */
@property (nonatomic, copy) NSString *version;
@end
