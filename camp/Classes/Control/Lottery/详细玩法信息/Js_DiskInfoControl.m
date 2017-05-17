//
//  Js_DiskInfoControl.m
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "Js_DiskInfoControl.h"
#import "CustomDiskInfoView.h"
#import "shortcutCollectionView.h"
#import "playingTypeCell.h"

@interface Js_DiskInfoControl ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    /* 快捷数组 */
    NSArray *shortcutArr;
    
    /* */
    UIView *AwardContent;
    UIView *OpenAward;
    UIButton *OpenAwardBtn;

}

/* 盘面信息 自定义视图 */
@property (nonatomic, strong) CustomDiskInfoView *customDisk;

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *title_Name_Lbl;
@property (weak, nonatomic) IBOutlet UICollectionView *shortcutCollection;
@property (weak, nonatomic) IBOutlet UILabel *pour_Lbl;
@property (weak, nonatomic) IBOutlet UILabel *cion_Lbl;
@property (weak, nonatomic) IBOutlet UITextField *cion_TextFiled;

@property (strong, nonatomic) UITableView *table;

- (void)createUIControls;
@end

/* 全局 */
NSMutableDictionary *selectedDic;
/* 当前价格 */
float price;
@implementation Js_DiskInfoControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    shortcutArr = @[@"10",@"20",@"50",@"100",@"200",@"500",@"1000",@"2000",@"5000"];
    [persistenceData setValue:[NSString stringWithFormat:@"%ld",CommonDataBaseModel.items[[[persistenceData valueForKey:PD_DiskID] stringValue]].firstObject.id]  forKey:PD_Items_id];
    [persistenceData synchronize];
    
    
    /* 选中信息 */
    selectedDic = [NSMutableDictionary dictionary];
    price = [self.cion_TextFiled.text floatValue];
    /* 默认添加所有盘面 */
    for (quotationInfoModel *model in CommonDataBaseModel.items[[[persistenceData valueForKey:PD_DiskID] stringValue]]) {
        [selectedDic setValue:[NSMutableDictionary dictionary] forKey:[NSString stringWithFormat:@"%ld",model.id]];
        /* 遍历所有玩法信息 */
        for (playTypeModel *plModel in CommonDataBaseModel.playeds[[NSString stringWithFormat:@"%ld",model.id]]) {
            [selectedDic[[NSString stringWithFormat:@"%ld",model.id]] setValue:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%ld",plModel.id]];
            
        }
    }
    [self createUIControls];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _table.dataSource = self;
    [_table reloadData];
}

- (void)createUIControls{
    
    AwardContent = [[UIView alloc] init];
    [AwardContent setBackgroundColor:[UIColor orangeColor]];
    
    OpenAward = [[UIView alloc] init];
    [OpenAward setBackgroundColor:RGBACOLOR(49, 49, 49, 1)];
    OpenAwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [OpenAwardBtn setTitle:@"" forState:UIControlStateNormal];
    [OpenAwardBtn setBackgroundColor:[UIColor redColor]];
    [OpenAwardBtn addTarget:self action:@selector(openAward:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:AwardContent];
    [self.view addSubview:OpenAward];
    [OpenAward addSubview:OpenAwardBtn];
    
    [AwardContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.titleView.mas_bottom);
        make.height.equalTo(@0);
    }];
    [OpenAward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AwardContent.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@20);
    }];
    [OpenAwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.height.equalTo(OpenAward);
        make.width.equalTo(@40);
    }];
    
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(OpenAward.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.text = @"标题123";
    [titleLbl setTextColor:[UIColor whiteColor]];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cb_mono_on"]];
    [navTitleView addSubview:titleLbl];
    [navTitleView addSubview:icon];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(navTitleView);
    }];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLbl);
        make.leading.equalTo(titleLbl.mas_trailing).offset(8);
        make.width.height.equalTo(@14);
    }];
    UITapGestureRecognizer *nav_Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openOrClose:)];
    [navTitleView addGestureRecognizer:nav_Tap];
    self.navigationItem.titleView = navTitleView;
    
    /* 添加盘面信息 */
    [self.view addSubview:self.customDisk];
    [self.view bringSubviewToFront:self.customDisk];
}


#pragma mark - 打开____ 关闭 盘面信息
- (void)openOrClose:(UITapGestureRecognizer *)sender{
    if(_customDisk.hidden){
        // 显示
        [self show];
    }else{
        // 隐藏
        [self dismiss];
    }
}

#pragma mark - 显示。隐藏
- (void)show{
    [_customDisk setHidden:NO];
    [UIView animateWithDuration:0.25 animations:^{
        _customDisk.alpha = 1.0;
    } completion:nil];
}
- (void) dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        _customDisk.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_customDisk setHidden:YES];
    }];
}

#pragma mark - Action
- (IBAction)Add_Number:(id)sender {
}
- (IBAction)subtract_Number:(id)sender {
}
- (void)openAward:(UIButton *)sender{
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [AwardContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(sender.selected?0:100));
        }];
        [self.view layoutIfNeeded];
    }];
    sender.selected = ! sender.selected;
}

// 投注
- (IBAction)cathectic:(id)sender {
    NSLog(@"%@",selectedDic);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"");
    if([string isEqualToString:@"\n"]){
        NSLog(@"a");
    }
    
    return YES;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return collectionView == self.shortcutCollection ? shortcutArr.count : 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    shortcutCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shortcutCollectionViewID" forIndexPath:indexPath];
    cell.cionLbl.text = shortcutArr[indexPath.row];
    return cell;
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView == self.shortcutCollection ? CGSizeMake(70, 40) : CGSizeMake(20, 20);
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return CommonDataBaseModel.playeds[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    playingTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([playingTypeCell class])];
    cell.entity = CommonDataBaseModel.playeds[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    playTypeModel *model = CommonDataBaseModel.playeds[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][indexPath.row];
    NSArray *dataSourceArr = CommonDataBaseModel.numcs[[NSString stringWithFormat:@"%ld",model.id]];
    float height = (((dataSourceArr.count - 1) / KColumn) + 1) * KNumberCellHeight + 10;
    return height;
}

#pragma mark - Lazy Loding
- (CustomDiskInfoView *)customDisk{
    if(!_customDisk){
        CGRect rect = CGRectMake(0, CGRectStatus.size.height +CGRectNav.size.height, kScreenWidth, kScreenHeight - CGRectStatus.size.height - CGRectNav.size.height);
        __weak typeof(self) weakSelf = self;
        _customDisk = [[CustomDiskInfoView alloc] initWithFrame:rect withClickCall_Black:^() {
            [weakSelf dismiss];
            
//            /* 添加一个新的盘面 */
//            if(![[selectedDic allKeys] containsObject:[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]]){
//                [selectedDic setValue:[NSMutableArray array] forKey:[persistenceData valueForKey:PD_Items_id]];
//            }
            [weakSelf.table reloadData];
        } withDismiss:^{
            [weakSelf dismiss];
        }];
        [_customDisk setBackgroundColor:RGBACOLOR(15, 15, 15, 0.4)];
        _customDisk.alpha = 0.0;
        [_customDisk setHidden:YES];
    }
    return _customDisk;
}
- (UITableView *)table{
    if(!_table){
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerNib:[UINib nibWithNibName:@"playingTypeCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([playingTypeCell class])];
    }
    return _table;
}

@end
