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
    if([key isEqualToString:@"gameGroups"]){
        NSMutableArray<gameGroupModel *> *group = [NSMutableArray array];
        @try {
            for (NSDictionary *item in value) {
                [group addObject:[[gameGroupModel alloc] initWithDictionary:item error:nil]];
            }
            [super setValue:group forKey:key];
        } @catch (NSException *exception) {
            
        } @finally {
        }
    }else if([key isEqualToString:@"games"]){
        
        self.games = [NSDictionary dictionaryWithDictionary:value];
//        [value enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            NSMutableArray<gameModel *> *gameArray_ = [NSMutableArray arrayWithCapacity:[obj count]];
//            for (NSDictionary *item in obj) {
//                gameModel *model_ = [[gameModel alloc] initWithDictionary:item error:nil];
//                [gameArray_ addObject:model_];
//            }
//            
//            [self.games setValue:gameArray_ forKey:key];
//        }];
    }else{
        [super setValue:value forKey:key];
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
