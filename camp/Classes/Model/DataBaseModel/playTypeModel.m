//
//  playTypeModel.m
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "playTypeModel.h"

@implementation playTypeModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:@(_id) forKey:@"id"];
    [aCoder encodeObject:_name forKey:@"name"];
    
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _id = [[aDecoder decodeObjectForKey:@"id"] integerValue];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
