//
//  paramsModel.m
//  camp
//
//  Created by 张三好 on 2017/5/12.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "paramsModel.h"

@implementation paramsModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_client_Cache_Param forKey:@"client_Cache_Param"];
    [aCoder encodeObject:_code forKey:@"code"];
    [aCoder encodeObject:_dealerName forKey:@"dealerName"];
    [aCoder encodeObject:_describe forKey:@"describe"];
    [aCoder encodeObject:@(_did) forKey:@"did"];
    [aCoder encodeObject:@(_enable) forKey:@"enable"];
    [aCoder encodeObject:@(_id) forKey:@"id"];
    [aCoder encodeObject:@(_isDelete) forKey:@"isDelete"];
    [aCoder encodeObject:@(_mid) forKey:@"mid"];
    [aCoder encodeObject:_paramName forKey:@"paramName"];
    [aCoder encodeObject:_paramValue forKey:@"paramValue"];
    [aCoder encodeObject:_plantform forKey:@"plantform"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.client_Cache_Param = [aDecoder decodeObjectForKey:@"client_Cache_Param"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.dealerName = [aDecoder decodeObjectForKey:@"dealerName"];
        self.describe = [aDecoder decodeObjectForKey:@"describe"];
        self.did = [[aDecoder decodeObjectForKey:@"did"] integerValue];
        self.enable = [aDecoder decodeObjectForKey:@"enable"];
        self.id = [[aDecoder decodeObjectForKey:@"id"] integerValue];
        self.isDelete = [aDecoder decodeObjectForKey:@"isDelete"];
        self.mid = [[aDecoder decodeObjectForKey:@"mid"] integerValue];
        self.paramName = [aDecoder decodeObjectForKey:@"paramName"];
        self.paramValue = [aDecoder decodeObjectForKey:@"paramValue"];
        self.plantform = [aDecoder decodeObjectForKey:@"plantform"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.updateTime = [aDecoder decodeObjectForKey:@"updateTime"];
    }
    return self;
}

@end
