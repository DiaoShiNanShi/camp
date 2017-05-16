//
//  playTypeModel.h
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface playTypeModel : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@end
