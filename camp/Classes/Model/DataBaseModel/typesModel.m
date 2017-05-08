//
//  typesModel.m
//  camp
//
//  Created by 张三好 on 2017/5/8.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "typesModel.h"

@implementation typesModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:@(_android) forKey:@"android"];
    [aCoder encodeObject:_client_Cache_Type forKey:@"client_Cache_Type"];
    [aCoder encodeObject:_codeList forKey:@"codeList"];
    [aCoder encodeObject:@(_dataFtime) forKey:@"dataFtime"];
    [aCoder encodeObject:@(_defaultItem) forKey:@"defaultItem"];
    [aCoder encodeObject:@(_enable) forKey:@"enable"];
    [aCoder encodeObject:@(_group) forKey:@"group"];
    [aCoder encodeObject:_groupName forKey:@"groupName"];
    [aCoder encodeObject:@(_id) forKey:@"id"];
    [aCoder encodeObject:_info forKey:@"info"];
    [aCoder encodeObject:@(_ios) forKey:@"ios"];
    [aCoder encodeObject:@(_isDelete) forKey:@"isDelete"];
    [aCoder encodeObject:@(_ishot) forKey:@"ishot"];
    [aCoder encodeObject:@(_istop) forKey:@"istop"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_nickName forKey:@"nickName"];
    [aCoder encodeObject:@(_num) forKey:@"num"];
    [aCoder encodeObject:_onGetNoed forKey:@"onGetNoed"];
    [aCoder encodeObject:_shortName forKey:@"shortName"];
    [aCoder encodeObject:@(_web) forKey:@"web"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.client_Cache_Type = [aDecoder decodeObjectForKey:@"client_Cache_Type"];
        self.codeList = [aDecoder decodeObjectForKey:@"codeList"];
        self.dataFtime = [[aDecoder decodeObjectForKey:@"dataFtime"] integerValue];
        self.defaultItem = [[aDecoder decodeObjectForKey:@"defaultItem"] integerValue];
        self.enable = [aDecoder decodeObjectForKey:@"enable"];
        self.group = [[aDecoder decodeObjectForKey:@"group"] integerValue];
        self.groupName = [aDecoder decodeObjectForKey:@"groupName"];
        _id = [[aDecoder decodeObjectForKey:@"id"] integerValue];
        self.info = [aDecoder decodeObjectForKey:@"info"];
        self.ios = [aDecoder decodeObjectForKey:@"ios"];
        self.isDelete = [aDecoder decodeObjectForKey:@"isDelete"];
        self.ishot = [aDecoder decodeObjectForKey:@"ishot"];
        self.istop = [aDecoder decodeObjectForKey:@"istop"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.num = [[aDecoder decodeObjectForKey:@"num"] integerValue];
        self.onGetNoed = [aDecoder decodeObjectForKey:@"onGetNoed"];
        self.shortName = [aDecoder decodeObjectForKey:@"shortName"];
        self.web = [aDecoder decodeObjectForKey:@"web"];
    }
    return self;
}
@end
