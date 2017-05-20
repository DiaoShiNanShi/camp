//
//  CustomGroupView.m
//  camp
//
//  Created by 张三好 on 2017/5/8.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "CustomGroupView.h"

@interface CustomGroupView()
{
    CAGradientLayer *lineLayer;
    CALayer *verticalLine;
    
}

@end

@implementation CustomGroupView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUI];
    }
    return self;
}
- (void)setUI{

    float width = kScreenWidth / 2;
    float height = kScreenWidth / 4;
    float y = 0.0;
    CGPoint startPoint = CGPointMake(1.0, 0);
    CGPoint endPoint = CGPointMake(0, 0);
    for(int  i = 0; i < CommonDataBaseModel.types.count; i ++){
        y = i / 2 * height;
        UIView *view_ = [[UIView alloc] initWithFrame:CGRectMake(i % 2 == 0 ?0:width,y, width, height)];
        [view_ setBackgroundColor:RGBACOLOR(49, 49, 49, 1)];
        [self setBackgroundColor:RGBACOLOR(49, 49, 49, 1)];
        /* 添加子视图 */
        UIButton *JsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [JsBtn setFrame:CGRectMake(width/2, 0, height, height/2)];
        [JsBtn setTitle:@"极速盘" forState:UIControlStateNormal];
        [JsBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        JsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        JsBtn.tag = i;
        UITapGestureRecognizer *JsButton_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(JsButton_OnClick:)];
        [JsBtn addGestureRecognizer:JsButton_tap];
        
        UIButton *BzBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [BzBtn setFrame:CGRectMake(width/2, height/2, height, height/2)];
        [BzBtn setTitle:@"标准盘" forState:UIControlStateNormal];
        [BzBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        BzBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        BzBtn.tag = i;
        UITapGestureRecognizer *BzBtn_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BzButton_OnClick:)];
        [BzBtn addGestureRecognizer:BzBtn_tap];
        
        UILabel *groupName = [[UILabel alloc] init];
        [groupName setFrame:CGRectMake(0, height - 15, height, 10)];
        groupName.font = [UIFont systemFontOfSize:13];
        groupName.text = CommonDataBaseModel.types[i].groupName;
        groupName.textAlignment = NSTextAlignmentCenter;
        [groupName setTextColor:[UIColor redColor]];
        
        UIImageView *icon = [[UIImageView alloc] init];
        [icon setContentMode:UIViewContentModeScaleAspectFit];
        [icon setFrame:CGRectMake(0, 0, height, height - 20)];
        [icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_lottery%d.png",i]]];
        
        
        lineLayer = [CAGradientLayer layer];
        lineLayer.colors = @[(__bridge id)RGBACOLOR(139, 125, 85, 1).CGColor,(__bridge id)RGBACOLOR(49, 49, 49, 1).CGColor];
        lineLayer.locations = @[@0.2];
        lineLayer.startPoint = i % 2 != 0 ? endPoint : startPoint;
        lineLayer.endPoint = i % 2 != 0 ? startPoint : endPoint;
        lineLayer.frame = CGRectMake(0, view_.frame.size.height - 1, view_.frame.size.width, 1);
        [view_.layer addSublayer:lineLayer];
        
        verticalLine = [CALayer layer];
        [verticalLine setBackgroundColor:RGBACOLOR(103, 94, 70, 1).CGColor];
        verticalLine.frame = CGRectMake(view_.frame.size.width - 1, 0, 1, view_.frame.size.height);
        [view_.layer addSublayer:verticalLine];
        
        [view_ addSubview:JsBtn];
        [view_ addSubview:BzBtn];
        [view_ addSubview:groupName];
        [view_ addSubview:icon];
        
        [self addSubview:view_];
    }
    self.returnSelfHeight = ^float{
        return y +  height;
    };
}

- (void)JsButton_OnClick:(UITapGestureRecognizer *)tap{
    if(!self.PushToJsPage)return;
    self.PushToJsPage(CommonDataBaseModel.types[tap.view.tag]);
}
- (void)BzButton_OnClick:(UITapGestureRecognizer *)tap{
    if(!self.PushToBzPage)return;
    self.PushToBzPage(CommonDataBaseModel.types[tap.view.tag]);
}

@end
