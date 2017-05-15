//
//  CustomGroupView.h
//  camp
//
//  Created by 张三好 on 2017/5/8.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomGroupView : UIView

@property (nonatomic, copy) float (^returnSelfHeight)();

@property (nonatomic, copy) void (^PushToJsPage)(NSInteger pageId);
@property (nonatomic, copy) void (^PushToBzPage)(NSInteger pageId);
@end
