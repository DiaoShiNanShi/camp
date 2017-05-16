//
//  DataBaseModel.h
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "DataBaseModel.h"
@class gameGroupModel;
@class gameModel;
@class typesModel;
@class paramsModel;
@class quotationInfoModel;
@class playTypeModel;
@class NumberModel;
@interface DataBaseModel : NSObject<NSCoding>

/* 游戏分组 */
@property (nonatomic, strong) NSArray<gameGroupModel *> *gameGroups;

/* 首页信息 */
@property (nonatomic, strong) NSArray<typesModel *> *types;

/* 所有游戏*/
@property (nonatomic, strong) NSMutableDictionary <NSString *,NSArray<gameModel *> *> *games;

@property (nonatomic,strong) NSMutableDictionary <NSString *,paramsModel *>* params;

/* 盘面信息 */
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSArray<quotationInfoModel *> *>  *items;

/* 玩法信息 */
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSArray<playTypeModel *>*> *playeds;

/* 号码信息 */
@property (nonatomic, strong) NSMutableDictionary <NSString *,NSArray<NumberModel *>*> *numcs;

/* 最新版本号 */
@property (nonatomic, copy) NSString *version;
@end
