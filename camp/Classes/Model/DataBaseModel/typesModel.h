//
//  typesModel.h
//  camp
//
//  Created by 张三好 on 2017/5/8.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface typesModel : NSObject<NSCoding>

@property (nonatomic, assign) BOOL android;
@property (nonatomic, strong) NSDictionary *client_Cache_Type;
@property (nonatomic, copy) NSString *codeList;
@property (nonatomic, assign) NSInteger dataFtime;
@property (nonatomic, assign) NSInteger defaultItem;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign) BOOL ios;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) BOOL ishot;
@property (nonatomic, assign) BOOL istop;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, copy) NSString *onGetNoed;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, assign) BOOL web;

@end
