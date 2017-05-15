//
//  MyAccountHeaderCell.m
//  camp
//
//  Created by 张三好 on 2017/5/15.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "MyAccountHeaderCell.h"

@interface MyAccountHeaderCell()

@property (nonatomic, weak) IBOutlet UILabel *nickName;
@property (nonatomic, weak) IBOutlet UILabel *coin;
@property (nonatomic, weak) IBOutlet UILabel *fcoin;
@property (nonatomic, weak) IBOutlet UILabel *scoreTotal;
@end

@implementation MyAccountHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setEntity:(UserModel *)entity{
    _entity = entity;
    self.nickName.text = entity.easemobUsername;
    self.coin.text = entity.coin;
    self.fcoin.text = [NSString stringWithFormat:@"%.2f",entity.fcoin];
    self.scoreTotal.text = [NSString stringWithFormat:@"%.2f",entity.scoreTotal];
}
- (IBAction)btnOnClick:(UIButton *)sender {
    if(!self.AccountOperate)return;
    self.AccountOperate(sender.tag);
}

@end
