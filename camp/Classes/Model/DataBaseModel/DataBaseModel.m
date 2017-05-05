//
//  DataBaseModel.m
//  camp
//
//  Created by 张三好 on 2017/5/3.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "DataBaseModel.h"

@implementation DataBaseModel

- (void)setValue:(id)value forKey:(NSString *)key{
    @try {
        if([key isEqualToString:@"gameGroups"]){
            NSMutableArray<gameGroupModel *> *group = [NSMutableArray array];
            for (NSDictionary *item in value) {
                [group addObject:[gameGroupModel mj_objectWithKeyValues:item]];
            }
            [super setValue:group forKey:key];
        }else if([key isEqualToString:@"games"]){
            self.games = [NSMutableDictionary dictionary];
            [value enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSMutableArray<gameModel *> *gameArray_ = [NSMutableArray arrayWithCapacity:[obj count]];
                for (NSDictionary *item in obj) {
                    gameModel *model_ = [gameModel mj_objectWithKeyValues:item];
                    [gameArray_ addObject:model_];
                }
                [self.games setValue:gameArray_ forKey:key];
            }];
        }else{
            [super setValue:value forKey:key];
        }
    } @catch (NSException *exception) {
        NSLog(@"");
    }
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_gameGroups forKey:@"gameGroups"];
    [aCoder encodeObject:_games forKey:@"games"];
    [aCoder encodeObject:_version forKey:@"version"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.gameGroups = [aDecoder decodeObjectForKey:@"gameGroups"];
        self.games = [aDecoder decodeObjectForKey:@"games"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
    }
    return self;
}

@end
