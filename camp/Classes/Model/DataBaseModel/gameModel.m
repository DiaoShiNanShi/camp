//
//  gameModel.m
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "gameModel.h"

@implementation gameModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:@(_android) forKey:@"android"];
    [aCoder encodeObject:_clientInfo forKey:@"clientInfo"];
    [aCoder encodeObject:@(_clientType) forKey:@"clientType"];
    [aCoder encodeObject:_code1 forKey:@"code1"];
    [aCoder encodeObject:_code2 forKey:@"code2"];
    [aCoder encodeObject:@(_did) forKey:@"did"];
    [aCoder encodeObject:@(_enable) forKey:@"enable"];
    [aCoder encodeObject:_groupCode forKey:@"groupCode"];
    [aCoder encodeObject:@(_groupID) forKey:@"groupID"];
    [aCoder encodeObject:_groupName forKey:@"groupName"];
    [aCoder encodeObject:@(_id) forKey:@"id"];
    [aCoder encodeObject:@(_ios) forKey:@"ios"];
    [aCoder encodeObject:@(_isDelete) forKey:@"isDelete"];
    [aCoder encodeObject:_language forKey:@"language"];
    [aCoder encodeObject:@(_mid) forKey:@"mid"];
    [aCoder encodeObject:_name1 forKey:@"name1"];
    [aCoder encodeObject:_name2 forKey:@"name2"];
    [aCoder encodeObject:_name3 forKey:@"name3"];
    [aCoder encodeObject:_name4 forKey:@"name4"];
    [aCoder encodeObject:_name5 forKey:@"name5"];
    [aCoder encodeObject:@(_picAndroid1) forKey:@"picAndroid1"];
    [aCoder encodeObject:@(_picAndroid2) forKey:@"picAndroid2"];
    [aCoder encodeObject:_picPath1 forKey:@"picPath1"];
    [aCoder encodeObject:_picPath2 forKey:@"picPath2"];
    [aCoder encodeObject:_plantform forKey:@"plantform"];
    [aCoder encodeObject:_target forKey:@"target"];
    [aCoder encodeObject:_updateTime forKey:@"updateTime"];
    [aCoder encodeObject:@(_web) forKey:@"web"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.android = [aDecoder decodeObjectForKey:@"android"];
        self.clientInfo = [aDecoder decodeObjectForKey:@"clientInfo"];
        self.clientType = [[aDecoder decodeObjectForKey:@"clientType"] integerValue];
        self.code1 = [aDecoder decodeObjectForKey:@"code1"];
        self.code2 = [aDecoder decodeObjectForKey:@"code2"];
        self.did = [[aDecoder decodeObjectForKey:@"did"] integerValue];
        self.groupCode = [aDecoder decodeObjectForKey:@"groupCode"];
        self.groupID = [[aDecoder decodeObjectForKey:@"groupID"] integerValue];
        self.groupName = [aDecoder decodeObjectForKey:@"groupName"];
        _id = [[aDecoder decodeObjectForKey:@"id"] integerValue];
        self.ios = [aDecoder decodeObjectForKey:@"ios"];
        self.isDelete = [aDecoder decodeObjectForKey:@"isDelete"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.mid = [[aDecoder decodeObjectForKey:@"mid"] integerValue];
        self.name1 = [aDecoder decodeObjectForKey:@"name1"];
        self.name2 = [aDecoder decodeObjectForKey:@"name2"];
        self.name3 = [aDecoder decodeObjectForKey:@"name3"];
        self.name4 = [aDecoder decodeObjectForKey:@"name4"];
        self.name5 = [aDecoder decodeObjectForKey:@"name5"];
        self.picAndroid1 = [[aDecoder decodeObjectForKey:@"picAndroid1"] integerValue];
        self.picAndroid2 = [[aDecoder decodeObjectForKey:@"picAndroid2"] integerValue];
        self.picPath1 = [aDecoder decodeObjectForKey:@"picPath1"];
        self.picPath2 = [aDecoder decodeObjectForKey:@"picPath2"];
        self.plantform = [aDecoder decodeObjectForKey:@"plantform"];
        self.target = [aDecoder decodeObjectForKey:@"target"];
        self.updateTime = [aDecoder decodeObjectForKey:@"updateTime"];
        self.web = [aDecoder decodeObjectForKey:@"web"];
    }
    return self;
}

@end
