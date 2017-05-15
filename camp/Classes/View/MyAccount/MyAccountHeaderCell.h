//
//  MyAccountHeaderCell.h
//  camp
//
//  Created by 张三好 on 2017/5/15.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountHeaderCell : UITableViewCell

/** 操作 */
@property (nonatomic, copy) void (^AccountOperate)(NSInteger type);
@property (nonatomic, strong) UserModel *entity;
@end
