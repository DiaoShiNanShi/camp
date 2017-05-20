//
//  PourListControl.m
//  camp
//
//  Created by 张三好 on 2017/5/20.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "PourListControl.h"
#import "PourListCell.h"

@interface PourListControl ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *menu;
}

@property (nonatomic, strong) UITableView *table;
@end

@implementation PourListControl

- (void)viewDidLoad {
    [super viewDidLoad];
    menu = @[@"投注记录",@"体育记录",@"红包记录",@"AG记录",@"AG捕鱼",@"BB记录",@"MG记录",@"PT记录",@"OG记录"];
    
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(CGRectStatus.size.height + CGRectNav.size.height);
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 15, 15)];
    [leftBtn setImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(comblack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menu.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PourListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PourListCell class])];
    cell.titleLbl.text = menu[indexPath.row];
    return cell;
}

#pragma mar _layz Loding
- (UITableView *)table{
    if(!_table){
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table setBackgroundColor:RGBACOLOR(15, 15, 15, 1)];
        [_table registerNib:[UINib nibWithNibName:@"PourListCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PourListCell class])];
    }
    return _table;
}

@end
