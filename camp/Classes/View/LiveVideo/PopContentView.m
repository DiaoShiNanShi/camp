//
//  PopContentView.m
//  camp
//
//  Created by 张三好 on 2017/5/5.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "PopContentView.h"
#import "PopContentTableCell.h"

@interface PopContentView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;
- (void)setUI;
@end
@implementation PopContentView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUI];
    }
    return self;
}
- (void)setUI{
    
    _table = [[UITableView alloc] init];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.bounces = NO;
    [_table registerNib:[UINib nibWithNibName:@"PopContentTableCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PopContentTableCell class])];
    [self addSubview:_table];
    
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PopContentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PopContentTableCell class])];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
         return (KGamePopViewHeight - 30) / 2;
}

/* 自定义头视图 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    UILabel *headerV_Text = [[UILabel alloc] init];
    headerV_Text.text = @"系统提示";
    
    UIImageView *cloesIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [cloesIcon setContentMode:UIViewContentModeScaleAspectFit];
    [cloesIcon setBackgroundColor:[UIColor orangeColor]];
    
    [headerV addSubview:headerV_Text];
    [headerV addSubview:cloesIcon];
    
    [headerV_Text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(headerV);
    }];
    [cloesIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerV);
        make.leading.equalTo(headerV).offset(10);
        make.width.height.equalTo(@15);
    }];
    return headerV;
}
/* 头视图 高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

@end
