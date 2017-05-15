//
//  LogOutCell.m
//  camp
//
//  Created by 张三好 on 2017/5/15.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "LogOutCell.h"

@implementation LogOutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)LogOut:(id)sender {
    if(!self.AppLogOutAction)return;
    self.AppLogOutAction();
}

@end
