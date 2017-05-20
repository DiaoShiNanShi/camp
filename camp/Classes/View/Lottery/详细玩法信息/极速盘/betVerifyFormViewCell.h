//
//  betVerifyFormViewCell.h
//  camp
//
//  Created by 张三好 on 2017/5/18.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface betVerifyFormViewCell : UITableViewCell

@property (nonatomic, copy) void (^returnSelfheight)();
/* 当前所处盘面ID */
@property (nonatomic, copy) NSString *diskID;
@property (nonatomic, assign) NSInteger pid;
@property (nonatomic, strong) NSDictionary *entity;
@property (nonatomic, weak) IBOutlet UILabel *centerLbl;

-(void)setIntroductionText;
@end
