//
//  bz_NumberCell.m
//  camp
//
//  Created by 张三好 on 2017/5/19.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "bz_NumberCell.h"



extern NSMutableDictionary *bz_selectedDic;
extern float bz_Price;
extern NSInteger bz_PourNumber;
extern float bz_extendedPrice;


@interface bz_NumberCell()
{
    float start_Price;
}

@end

@implementation bz_NumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *num_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(numberTap:)];
    [self.outLayer addGestureRecognizer:num_tap];
    
    // 长按手势
    UILongPressGestureRecognizer *Long_Ges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
    Long_Ges.minimumPressDuration = 1.0;
    [self.outLayer addGestureRecognizer:Long_Ges];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modeSwitch:) name:@"modeSwitch" object:nil];
}
- (void)modeSwitch:(NSNotification *)not{
    
    [self.bz_Price setEnabled:[not.object isEqual:@0]?NO:YES];
    [self.bz_Price setBorderStyle:[not.object isEqual:@0]?UITextBorderStyleNone:UITextBorderStyleRoundedRect];
    [self.bz_Price setBackgroundColor:[not.object isEqual:@0]?[UIColor clearColor]:RGBACOLOR(45, 45, 45, 1)];
}

- (void)setEntity:(NumberModel *)entity{
    _entity = entity;
    self.numberName.text = entity.name;
    
    NSMutableDictionary *tmpDic = bz_selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]][[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]];
    [self.bz_Price setText:[tmpDic count]?[tmpDic[@"price"] stringValue]:@"0"];
    self.outLayer.layer.borderColor = [tmpDic count] ? RGBACOLOR(204, 99, 23, 1).CGColor : [UIColor whiteColor].CGColor;
}

- (void)longTap:(UILongPressGestureRecognizer *)ges{
    if(ges.state == UIGestureRecognizerStateBegan){
        
        NSMutableDictionary *tmpDic = bz_selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]];
        NSMutableDictionary *childDic = tmpDic[[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]];
        if([childDic count]<=0)return;
        bz_PourNumber --;
        bz_extendedPrice -= [tmpDic[[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]][@"price"] floatValue];
        [tmpDic removeObjectForKey:[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]];
        self.outLayer.layer.borderColor = [UIColor whiteColor].CGColor;
        self.bz_Price.text = @"0";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePriceInfo_Bz" object:nil userInfo:nil];
    }
}

- (void)numberTap:(UITapGestureRecognizer *)tap{
    if(self.bz_Price.enabled)return;
    self.outLayer.layer.borderColor = RGBACOLOR(204, 99, 23, 1).CGColor;
    NSMutableDictionary *tmpDic = bz_selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]][[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]];
    NSMutableDictionary *parentDic = bz_selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]];
    if(tmpDic.count <= 0){
        // 还没数据
        [parentDic setValue:[NSMutableDictionary dictionaryWithObjects:@[@(self.entity.index),@(bz_Price),self.entity.name] forKeys:@[@"numcs_id",@"price",@"name"]] forKey:[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]];
        bz_PourNumber ++;
        bz_extendedPrice += bz_Price;
    }else{
        // 累加价格
        float price = [tmpDic[@"price"] floatValue];
        [tmpDic setValue:@(price + bz_Price) forKey:@"price"];
        bz_extendedPrice += bz_Price;
    }
    self.bz_Price.text = [NSString stringWithFormat:@"%@",bz_selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]][[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]][@"price"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePriceInfo_Bz" object:nil userInfo:nil];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.text = [textField.text isEqualToString:@""]?@"0":textField.text;
    float number_price = [textField.text floatValue];
    [self.bz_Price setText:[NSString stringWithFormat:@"%.0f",number_price]];
    self.outLayer.layer.borderColor = number_price <= 0 ? [UIColor whiteColor].CGColor:RGBACOLOR(204, 99, 23, 1).CGColor;
    NSMutableDictionary *tmpDic = bz_selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]][[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]];
    NSMutableDictionary *parentDic = bz_selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.plID]];
    if(tmpDic.count <= 0){
        // 还没数据
        if(number_price <= 0)return;
        [parentDic setValue:[NSMutableDictionary dictionaryWithObjects:@[@(self.entity.index),@(number_price),self.entity.name] forKeys:@[@"numcs_id",@"price",@"name"]] forKey:[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]];
        bz_PourNumber ++;
        bz_extendedPrice += number_price;
    }else{
        if(number_price <= 0){
            /* 移除数据 取消选中*/
            [tmpDic setValue:@(number_price) forKey:@"price"];
            bz_extendedPrice = bz_extendedPrice - start_Price;
            bz_PourNumber --;
            [parentDic removeObjectForKey:[NSString stringWithFormat:@"%ld%ld",self.plID,self.entity.index]];
        }else{
            [tmpDic setValue:@(number_price) forKey:@"price"];
            bz_extendedPrice = bz_extendedPrice - start_Price + number_price;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePriceInfo_Bz" object:nil userInfo:nil];
    /* 重置开始值 */
    start_Price = 0.0;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = [textField.text isEqualToString:@"0"]?@"":textField.text;
    /* 记录开始时的值 */
    start_Price = [textField.text floatValue];
}
@end
