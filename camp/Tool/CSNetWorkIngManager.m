//
//  CSNetWorkIngManager.m
//  铲屎官
//
//  Created by 任务鱼 on 16/7/21.
//  Copyright © 2016年 宠物社区. All rights reserved.
//

#import "CSNetWorkIngManager.h"

static CSNetWorkIngManager *network;
@interface CSNetWorkIngManager()
// 网络请求管理
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation CSNetWorkIngManager

#pragma mark - singApption
+ (instancetype)sharNetWorkManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if(!network)
        {
            network = [[CSNetWorkIngManager alloc] init];
        }
        
    });
    return network;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if(!network)
        {
            network = [super allocWithZone:zone];
        }
        
    });
    return network;
}

- (id)copy
{
    return self;
}

/**
 *  用户通用
 *
 *  @param url               地址
 *  @param completionHandler 回调处理
 *  @param parameter         参数
 *  @param handlerError 处理错误
 */
- (void)Post:(NSString *)url withCommletionHandler:(completionHandler)completionHandler withParameters:(id)parameter withcompletionHandlerError:(completionHandlerError)handlerError
{
    NSString *Cookie = [persistenceData valueForKey:PD_Cookie];
    if(Cookie.length > 0){
        [self.manager.requestSerializer setValue:Cookie forHTTPHeaderField:@"Cookie"];
    }
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@",baseUrl,url] parameters:parameter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSHTTPURLResponse *response_ = (NSHTTPURLResponse *)task.response;
            NSString *Cookie_ = response_.allHeaderFields[@"Set-Cookie"];
            if(Cookie_.length > 0){
                [persistenceData setValue:Cookie_ forKey:PD_Cookie];
            }
            
            NSError *err;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&err];
            dispatch_async(dispatch_get_main_queue(), ^{
                if([response[@"reason"] isEqualToString:@"success"]){
                    completionHandler(response,nil);
                }else{
                    handlerError(response[@"reason"]);
                }
            });
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"");
    }];
}


/**
 *  处理用户验证了token获取数据 GET
 *
 *  @param url              地址
 *  @param comletionHandler 回调处理
 *  @param parameter        参数
 *  @param handlerError 处理错误
 */
- (void) Get:(NSString *)url withCommletionHandler:(completionHandler) comletionHandler withParameters:(id) parameter
 withcompletionHandlerError:(completionHandlerError)handlerError{
   
        [self.manager GET:[NSString stringWithFormat:@"%@%@",baseUrl,url] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
}


#pragma mark - Custom Assecc
- (AFHTTPSessionManager *)manager
{
    if(!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.requestSerializer = requestSerializer;
        _manager.requestSerializer.timeoutInterval = 10.0;
        
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",nil];
    }
    return _manager;
}

@end
