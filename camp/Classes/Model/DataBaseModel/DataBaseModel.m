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
        
        NSMutableDictionary <NSString *,NSArray<gameModel *> *> *game_ = [NSMutableDictionary dictionary];
        [value enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
             NSLog(@"key = %@ and obj = %@", key, obj);
        }];
    }else{
        [super setValue:value forKey:key];
    }
}

@end
