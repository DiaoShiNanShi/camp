//
//  LotteryControl.m
//  camp
//
//  Created by 张三好 on 2017/5/8.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "LotteryControl.h"
#import "CustomGroupView.h"

@interface LotteryControl ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) IBOutlet SDCycleScrollView *sdCycView;
@property (nonatomic, weak) IBOutlet UITableView *table;
@property (nonatomic, strong) CustomGroupView *customView;
@end

@implementation LotteryControl

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.sdCycView adjustWhenControllerViewWillAppera];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    /* 加载本地Banner图 */
    [self.sdCycView setLocalizationImageNamesGroup:@[[UIImage imageNamed:@"ic_banner1"],[UIImage imageNamed:@"ic_banner2"],[UIImage imageNamed:@"ic_banner3"]]];
    /* 注册Cell */
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}
- (void)updateLanguage{
    self.title = CustomStr(@"tabbar_lottery")
}


#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:_customView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float height = self.customView.returnSelfHeight();
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - loding
- (CustomGroupView *)customView{
    if(!_customView){
        _customView = [[CustomGroupView alloc]  initWithFrame:CGRectZero];
    }
    return _customView;
}
@end
