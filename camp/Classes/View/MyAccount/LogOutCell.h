//
//  LogOutCell.h
//  camp
//
//  Created by 张三好 on 2017/5/15.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogOutCell : UITableViewCell

@property (nonatomic, copy) void (^AppLogOutAction)();
@end
