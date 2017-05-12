//
//  LotteryControl.m
//  camp
//
//  Created by 张三好 on 2017/5/8.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "LotteryControl.h"
#import "CustomGroupView.h"
#import "sportsGameCell.h"
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
    [self.table registerNib:[UINib nibWithNibName:@"sportsGameCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([sportsGameCell class])];
}
- (void)updateLanguage{
    self.title = CustomStr(@"tabbar_lottery")
}


#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:_customView];
        [cell.contentView setBackgroundColor:RGBACOLOR(15, 15, 15, 1)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        sportsGameCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([sportsGameCell class])];
        [cell.Icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_physical_footer%ld.png",indexPath.row]]];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 0 ? self.customView.returnSelfHeight() + 15 : 100;
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
