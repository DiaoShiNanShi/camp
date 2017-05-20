//
//  betVerifyFormView.h
//  camp
//
//  Created by 张三好 on 2017/5/18.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(int, DiskType) {
    DiskType_Js = 0,
    DiskType_Bz
};
/* 下注确认视图 */
@interface betVerifyFormView : UIView

@property (nonatomic, assign) BOOL type;
/* 异步解析数据 */
- (void)SyncParseData;
@end
