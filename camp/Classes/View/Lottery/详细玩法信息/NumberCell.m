//
//  NumberCell.m
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "NumberCell.h"

/** 引用全局*/
extern NSMutableDictionary *selectedDic;
extern float price;

@implementation NumberCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *num_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(numberTap:)];
    [self.numberName addGestureRecognizer:num_tap];
}
- (void)setEntity:(NumberModel *)entity{
    _entity = entity;
    self.numberName.text = entity.name;
    BOOL exist = false;
    for (NSDictionary *dic in selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]]) {
        if([dic[@"numcs_id"] isEqual:@(self.entity.index)]){
            exist = YES;
            break;
        }else
        {
            exist = NO;
        }
    }
    self.numberName.layer.borderColor = exist ? [UIColor redColor].CGColor : [UIColor whiteColor].CGColor;
    [self.numberName setTextColor:exist ? [UIColor redColor] : [UIColor whiteColor]];
    self.numberName.tag = exist ? 1 : 0 ;
}

- (void)numberTap:(UITapGestureRecognizer *)tap{
    
    self.numberName.layer.borderColor = tap.view.tag == 0 ? [UIColor redColor].CGColor : [UIColor whiteColor].CGColor;
    [self.numberName setTextColor:tap.view.tag == 0 ? [UIColor redColor] : [UIColor whiteColor]];
    tap.view.tag = tap.view.tag == 0 ? 1 : 0 ;

    if(tap.view.tag == 0){
        /* 移除 */
        NSMutableArray *tmpArr = selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]];
        NSDictionary *tmpDic;
        for (NSDictionary *dic in tmpArr) {
            if([dic[@"numcs_id"] isEqual:@(self.entity.index)]){
                tmpDic = dic;
                break;
            }
        }
        [tmpArr removeObject:tmpDic];
    }else{
        /* 添加 */
        [selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]] addObject:@{@"numcs_id":@(self.entity.index),@"price":@(price)}];
    }
}

@end
