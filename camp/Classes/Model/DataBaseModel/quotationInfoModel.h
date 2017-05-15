//
//  quotationInfoModel.h
//  camp
//
//  Created by 张三好 on 2017/5/15.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 盘面信息 */
@interface quotationInfoModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@end
