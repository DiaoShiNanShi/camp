//
//  bz_NumberCell.h
//  camp
//
//  Created by 张三好 on 2017/5/19.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bz_NumberCell : UICollectionViewCell<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIView *outLayer;
@property (nonatomic, weak) IBOutlet UITextField *bz_Price;
@property (nonatomic, weak) IBOutlet UILabel *numberName;
@property (nonatomic, strong) NumberModel *entity;
/* 玩法ID */
@property (nonatomic, assign) NSInteger plID;
@end
