//
//  paramsModel.h
//  camp
//
//  Created by 张三好 on 2017/5/12.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paramsModel : NSObject<NSCoding>

@property (nonatomic, strong) NSDictionary *client_Cache_Param;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *dealerName;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, assign) NSInteger did;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, copy) NSString *paramName;
@property (nonatomic, copy) NSString *paramValue;
@property (nonatomic, copy) NSString *plantform;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *updateTime;
@end
