//
//  CustomGroupView.m
//  camp
//
//  Created by 张三好 on 2017/5/8.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "CustomGroupView.h"

@implementation CustomGroupView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUI];
    }
    return self;
}
- (void)setUI{
    /* 循环产生控件 */
    /* 解档数据 */
    NSData *UnarchiveDataBase = [NSData dataWithContentsOfFile:LocalDataBaseModelFilePath];
    DataBaseModel* dataBase = [NSKeyedUnarchiver unarchiveObjectWithData:UnarchiveDataBase];
    
    float width = kScreenWidth / 2;
    float height = kScreenWidth / 4;
    float y = 0.0;
    for(int  i = 0; i < dataBase.types.count; i ++){
        y = i / 2 * height;
        UIView *view_ = [[UIView alloc] initWithFrame:CGRectMake(i % 2 == 0 ?0:width,y, width, height)];
        view_.borderWhich = ZJViewBorderBottom;
        /* 添加子视图 */
        UIButton *JsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [JsBtn setFrame:CGRectMake(width/2, 0, height, height/2)];
        [JsBtn setTitle:@"极速盘" forState:UIControlStateNormal];
        [JsBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        JsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        JsBtn.borderWhich = ZJViewBorderBottom;
        JsBtn.borderWhich = ZJViewBorderLeft;
        JsBtn.borderWhich = ZJViewBorderRight;
        
        UIButton *BzBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [BzBtn setFrame:CGRectMake(width/2, height/2, height, height/2)];
        [BzBtn setTitle:@"标准盘" forState:UIControlStateNormal];
        [BzBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        BzBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        BzBtn.borderWhich = ZJViewBorderLeft;
        BzBtn.borderWhich = ZJViewBorderRight;
        
        UILabel *groupName = [[UILabel alloc] init];
        [groupName setFrame:CGRectMake(0, height - 15, height, 10)];
        groupName.font = [UIFont systemFontOfSize:13];
        groupName.text = dataBase.types[i].groupName;
        groupName.textAlignment = NSTextAlignmentCenter;
        [groupName setTextColor:[UIColor redColor]];
        
        UIImageView *icon = [[UIImageView alloc] init];
        [icon setContentMode:UIViewContentModeScaleAspectFit];
        [icon setFrame:CGRectMake(0, 0, height, height - 20)];
        [icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_lottery%d.png",i]]];
        
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
@end
