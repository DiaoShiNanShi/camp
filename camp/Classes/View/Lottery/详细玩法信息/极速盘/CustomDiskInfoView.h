//
//  CustomDiskInfoView.h
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^diskClick)(NSString *DiskName);
typedef void(^dismiss)();
@interface CustomDiskInfoView : UIView


- (instancetype)initWithFrame:(CGRect)frame withClickCall_Black:(diskClick) disk withDismiss:(dismiss) dis;
@end
