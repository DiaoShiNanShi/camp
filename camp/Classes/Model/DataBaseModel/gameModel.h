//
//  gameModel.h
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface gameModel : JSONModel

@property (nonatomic, assign) BOOL android;
@property (nonatomic, copy) NSString *clientInfo;
@property (nonatomic, assign) NSInteger clientType;
@property (nonatomic, copy) NSString *code1;
@property (nonatomic, copy) NSString *code2;
@property (nonatomic, copy) NSString *dealerName;
@property (nonatomic, assign) NSInteger did;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, copy) NSString *groupCode;
@property (nonatomic, assign) NSInteger groupID;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) BOOL ios;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, copy) NSString *name1;
@property (nonatomic, copy) NSString *name2;
@property (nonatomic, copy) NSString *name3;
@property (nonatomic, copy) NSString *name4;
@property (nonatomic, copy) NSString *name5;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger picAndroid1;
@property (nonatomic, assign) NSInteger picAndroid2;
@property (nonatomic, copy) NSString *picPath1;
@property (nonatomic, copy) NSString *picPath2;
@property (nonatomic, copy) NSString *plantform;
@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) BOOL web;

@end
