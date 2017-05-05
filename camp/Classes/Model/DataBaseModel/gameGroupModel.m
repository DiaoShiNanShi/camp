//
//  gameGroupModel.m
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "gameGroupModel.h"

@implementation gameGroupModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:@(_android) forKey:@"android"];
    [aCoder encodeObject:_code forKey:@"code"];
    [aCoder encodeObject:_dealerName forKey:@"dealerName"];
    [aCoder encodeObject:_describe forKey:@"describe"];
    [aCoder encodeObject:@(_did) forKey:@"did"];
    [aCoder encodeObject:@(_enable) forKey:@"enable"];
    [aCoder encodeObject:@(_id) forKey:@"id"];
    [aCoder encodeObject:@(_ios) forKey:@"ios"];
    [aCoder encodeObject:@(_isDelete) forKey:@"isDelete"];
    [aCoder encodeObject:@(_mid) forKey:@"mid"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_plantform forKey:@"plantform"];
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    [aCoder encodeObject:@(_web) forKey:@"web"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.android = [aDecoder decodeObjectForKey:@"android"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.describe = [aDecoder decodeObjectForKey:@"describe"];
        self.did = [[aDecoder decodeObjectForKey:@"did"] integerValue];
        self.enable = [aDecoder decodeObjectForKey:@"enable"];
        _id = [[aDecoder decodeObjectForKey:@"id"] integerValue];
        self.ios = [aDecoder decodeObjectForKey:@"ios"];
        self.isDelete = [aDecoder decodeObjectForKey:@"isDelete"];
        self.mid = [[aDecoder decodeObjectForKey:@"mid"] integerValue];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.plantform = [aDecoder decodeObjectForKey:@"plantform"];
        self.updateTime = [aDecoder decodeObjectForKey:@"updateTime"];
        self.web = [aDecoder decodeObjectForKey:@"web"];
    }
    return self;
}

@end
