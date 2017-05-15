//
//  quotationInfoModel.m
//  camp
//
//  Created by 张三好 on 2017/5/15.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "quotationInfoModel.h"

@implementation quotationInfoModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_code forKey:@"code"];
    [aCoder encodeObject:@(_id) forKey:@"id"];
    [aCoder encodeObject:_name forKey:@"name"];

    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.code = [aDecoder decodeObjectForKey:@"code"];
        _id = [[aDecoder decodeObjectForKey:@"id"] integerValue];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
