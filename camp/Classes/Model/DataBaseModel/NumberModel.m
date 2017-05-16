//
//  NumberModel.m
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "NumberModel.h"

@implementation NumberModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:@(_index) forKey:@"index"];
    [aCoder encodeObject:_name forKey:@"name"];
    
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _index = [[aDecoder decodeObjectForKey:@"index"] integerValue];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
