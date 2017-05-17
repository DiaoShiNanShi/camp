//
//  NumberCell.h
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel *numberName;
@property (nonatomic, strong) NumberModel *entity;
/* 玩法ID */
@property (nonatomic, assign) NSInteger plID;
@end
