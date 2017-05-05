//
//  gameGroupModel.h
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "gameGroupModel.h"

/* 游戏分组 */
@interface gameGroupModel : NSObject<NSCoding>

@property (nonatomic, assign) BOOL android;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *dealerName;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, assign) NSInteger did;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) BOOL ios;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *plantform;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) BOOL web;
@end
