//
//  GameElectronicMenu.m
//  camp
//
//  Created by 张三好 on 2017/5/4.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "GameElectronicMenu.h"

@interface GameElectronicMenu()
{
    NSMutableArray<UILabel *> *allMenuLabels;
    
    /* 上一个按钮的下标 */
    NSInteger prevBtnIndex;
}

- (void) setUI;
- (void)menuContentLblSelected:(UITapGestureRecognizer *)tap;
@end
@implementation GameElectronicMenu
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    @try {
        /* 解档数据 */
        NSData *UnarchiveDataBase = [NSData dataWithContentsOfFile:LocalDataBaseModelFilePath];
        DataBaseModel *dataBase = [NSKeyedUnarchiver unarchiveObjectWithData:UnarchiveDataBase];
        
        /* 初始化数组 */
        allMenuLabels = [NSMutableArray arrayWithCapacity:dataBase.gameGroups.count];
        /* 循环产生控件 */
        float magin = 10.0;
        float x = 10.0;
        for (int i = 0; i < dataBase.gameGroups.count; i ++) {
          
            UILabel *lbl = [[UILabel alloc] init];
            lbl.text = dataBase.gameGroups[i].describe;
            lbl.font = [UIFont systemFontOfSize:13];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.textColor = [UIColor whiteColor];
            lbl.userInteractionEnabled  = YES;
            lbl.tag = i;
            [lbl sizeToFit];
            lbl.frame = CGRectMake(x, 0, lbl.frame.size.width, self.frame.size.height);
            x += lbl.frame.size.width + magin;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuContentLblSelected:)];
            [lbl addGestureRecognizer:tap];
            [allMenuLabels addObject:lbl];
            [self addSubview:lbl];
        }
        [self setContentSize:CGSizeMake(x, self.frame.size.height)];
        /* 默认第一个按钮高亮显示 */
        [allMenuLabels.firstObject setTextColor:RGBACOLOR(201, 143, 43, 1)];
        prevBtnIndex = 0;
    } @catch (NSException *exception) {
        NSLog(@"___%@",exception.reason);
    }
}

/* 手势实现 */
- (void)menuContentLblSelected:(UITapGestureRecognizer *)tap{
    if(tap.view.tag == prevBtnIndex)return;
    [allMenuLabels[prevBtnIndex] setTextColor:[UIColor whiteColor]];
    [allMenuLabels[tap.view.tag] setTextColor:RGBACOLOR(201, 143, 43, 1)];
    prevBtnIndex = tap.view.tag;
    
    /* 实现回调 */
    if(!self.didSelectGameMenu)return;
    self.didSelectGameMenu(tap.view.tag);
}

@end
