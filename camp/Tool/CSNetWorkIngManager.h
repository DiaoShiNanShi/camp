//
//  CSNetWorkIngManager.h
//  铲屎官
//
//  Created by 任务鱼 on 16/7/21.
//  Copyright © 2016年 宠物社区. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^completionHandler)(id result,NSError *error);
typedef void(^completionHandlerError)(NSString *code);

@interface CSNetWorkIngManager : NSObject

/**
 *  创建单例
 */
+(instancetype) sharNetWorkManager;

/**
 *  用户通用POST
 *
 *  @param url               请求路径
 *  @param completionHandler 回调处理
 *  @param handlerError 处理错误
 */
- (void) Get:(NSString *)url withCommletionHandler:(completionHandler) completionHandler withParameters:(id) parameter withcompletionHandlerError:(completionHandlerError)handlerError;

/**
 *  处理用户验证了token获取数据 GET
 *
 *  @param url              地址
 *  @param comletionHandler 回调处理
 *  @param parameter        参数
 *  @param handlerError 处理错误
 */
- (void) Post:(NSString *)url withCommletionHandler:(completionHandler) comletionHandler withParameters:(id) parameter withcompletionHandlerError:(completionHandlerError)handlerError;


@end
