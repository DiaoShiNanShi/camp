//
//  Bz_DiskInfoControl.m
//  camp
//
//  Created by 张三好 on 2017/5/19.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "Bz_DiskInfoControl.h"
#import "betVerifyFormView.h"
#import "CustomDiskInfoView.h"
#import "bz_shortcutCollectionView.h"
#import "bz_ContentCell.h"

@interface Bz_DiskInfoControl ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    /* 快捷数组 */
    NSArray *shortcutArr;
    
    /* */
    UIView *AwardContent;
    UIView *OpenAward;
    UIButton *OpenAwardBtn;
    
    
    betVerifyFormView *betView;
    KLCPopup *bet_Pop;
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
@property (strong, nonatomic) UILabel *titleLbl;
@end

NSMutableDictionary *bz_selectedDic;
NSInteger bz_PourNumber;
float bz_Price;
float bz_extendedPrice;
@implementation Bz_DiskInfoControl
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    shortcutArr = @[@"10",@"20",@"50",@"100",@"200",@"500",@"1000",@"2000",@"5000"];
    [self.shortcutCollection registerNib:[UINib nibWithNibName:@"bz_shortcutCollectionView" bundle:nil] forCellWithReuseIdentifier:@"bz_shortcutCollectionViewID"];
    [persistenceData setValue:[NSString stringWithFormat:@"%ld",CommonDataBaseModel.items[[[persistenceData valueForKey:PD_DiskID] stringValue]].firstObject.id]  forKey:PD_Items_id];
    [persistenceData synchronize];
    self.title_Name_Lbl.text = [persistenceData valueForKey:PD_SelectName];
    
    /* 创建投注确认弹出层 */
    betView = [[betVerifyFormView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, kScreenHeight * 0.6)];
    betView.type = DiskType_Bz;
    [betView setBackgroundColor:[UIColor grayColor]];
    bet_Pop = [KLCPopup popupWithContentView:betView showType:KLCPopupShowTypeFadeIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeNone dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    
    /* 选中信息 */
    bz_selectedDic = [NSMutableDictionary dictionary];
    bz_extendedPrice = 0.0;
    bz_PourNumber = 0;
    bz_Price = [self.cion_TextFiled.text floatValue];
    /* 默认添加所有盘面 */
    for (quotationInfoModel *model in CommonDataBaseModel.items[[[persistenceData valueForKey:PD_DiskID] stringValue]]) {
        [bz_selectedDic setValue:[NSMutableDictionary dictionary] forKey:[NSString stringWithFormat:@"%ld",model.id]];
        /* 遍历所有玩法信息 */
        for (playTypeModel *plModel in CommonDataBaseModel.playeds[[NSString stringWithFormat:@"%ld",model.id]]) {
            [bz_selectedDic[[NSString stringWithFormat:@"%ld",model.id]] setValue:[NSMutableDictionary dictionary] forKey:[NSString stringWithFormat:@"%ld",plModel.id]];
        }
    }
    
    [self createUIControls];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePriceInfo:) name:@"updatePriceInfo_Bz" object:nil];
}
- (void)updatePriceInfo:(id)sender{
    [self.pour_Lbl setText:[NSString stringWithFormat:@"共%ld注",bz_PourNumber]];
    [self.cion_Lbl setText:[NSString stringWithFormat:@"%.0f元",bz_extendedPrice]];
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
    UIPanGestureRecognizer *_Pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(PanGes:)];
    [OpenAward addGestureRecognizer:_Pan];
    OpenAwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [OpenAwardBtn setTitle:@"" forState:UIControlStateNormal];
    [OpenAwardBtn setImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];
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
    _titleLbl = [[UILabel alloc] init];
    _titleLbl.text = CommonDataBaseModel.items[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_DiskID]]][0].name;
    [_titleLbl setTextColor:[UIColor whiteColor]];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cb_mono_on"]];
    [navTitleView addSubview:_titleLbl];
    [navTitleView addSubview:icon];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(navTitleView);
    }];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLbl);
        make.leading.equalTo(_titleLbl.mas_trailing).offset(8);
        make.width.height.equalTo(@14);
    }];
    UITapGestureRecognizer *nav_Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openOrClose:)];
    [navTitleView addGestureRecognizer:nav_Tap];
    self.navigationItem.titleView = navTitleView;
    
    /* 添加盘面信息 */
    [self.view addSubview:self.customDisk];
    [self.view bringSubviewToFront:self.customDisk];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return shortcutArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    bz_shortcutCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bz_shortcutCollectionViewID" forIndexPath:indexPath];
    cell.cionLbl.text = shortcutArr[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 40);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.cion_TextFiled setText:shortcutArr[indexPath.row]];
    bz_Price = [shortcutArr[indexPath.row] floatValue];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return CommonDataBaseModel.playeds[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    bz_ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([bz_ContentCell class])];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        cell.entity = CommonDataBaseModel.playeds[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][indexPath.section];
    });
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    playTypeModel *model = CommonDataBaseModel.playeds[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][indexPath.section];
    NSArray *dataSourceArr = CommonDataBaseModel.numcs[[NSString stringWithFormat:@"%ld",model.id]];
    
    float height = (((dataSourceArr.count - 1) / KBZColumn) + 1) * KBZNumberCellHeight + 10;
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // 获取玩法名称
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [headerView setBackgroundColor:RGBACOLOR(15, 15, 15, 1)];
    
    UIView *topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = RGBACOLOR(68, 68, 67, 1);
    
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.text = CommonDataBaseModel.playeds[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][section].name;
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.font = [UIFont systemFontOfSize:14];
    
    [headerView addSubview:titleLbl];
    [headerView addSubview:topLineView];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.leading.equalTo(@5);
    }];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(headerView);
        make.height.equalTo(@1);
    }];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    float price_Number = [textField.text floatValue] <= 0 ? 1 : [textField.text floatValue] ;
    textField.text = [NSString stringWithFormat:@"%.0f",price_Number];
    bz_Price =price_Number;
}
- (void)PanGes:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender translationInView:self.view];
    if(sender.view.tag == 1){
        if(point.y > 0)return;
        if(sender.state == UIGestureRecognizerStateChanged){
            CGPoint point = [sender translationInView:self.view];
            [UIView animateWithDuration:0 animations:^{
                [AwardContent mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(KOpenAwardHeight + point.y < 0 ? 0 : KOpenAwardHeight + point.y));
                }];
                [self.view layoutIfNeeded];
            }];
        }
        if(sender.state == UIGestureRecognizerStateEnded){
            
            [UIView animateWithDuration:0.25 animations:^{
                [AwardContent mas_updateConstraints:^(MASConstraintMaker *make) {
                    sender.view.tag = KOpenAwardHeight + point.y >= KOpenAwardHeight / 0.7 ? 1 : 0;
                     OpenAwardBtn.selected = sender.view.tag == 0 ? YES : NO;
                    [OpenAwardBtn setImage:[UIImage imageNamed:OpenAwardBtn.selected?@"bottom":@"top"] forState:UIControlStateNormal];
                    make.height.equalTo(@(sender.view.tag  == 0 ? KOpenAwardHeight : 0));
                }];
                [self.view layoutIfNeeded];
            }];
        }
    }else{
        if(sender.state == UIGestureRecognizerStateChanged){
            CGPoint point = [sender translationInView:self.view];
            [UIView animateWithDuration:0 animations:^{
                [AwardContent mas_updateConstraints:^(MASConstraintMaker *make) {
                    float height = AwardContent.frame.size.height + point.y<=0?0:AwardContent.frame.size.height + point.y;
                    make.height.equalTo(@(point.y<=0?height:point.y));
                }];
                [self.view layoutIfNeeded];
            }];
        }
        if(sender.state == UIGestureRecognizerStateEnded){
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
                [AwardContent mas_updateConstraints:^(MASConstraintMaker *make) {
                    sender.view.tag = point.y <= KOpenAwardHeight / 2 ? 0 : 1;
                     OpenAwardBtn.selected = sender.view.tag == 0 ? NO : YES;
                    [OpenAwardBtn setImage:[UIImage imageNamed:OpenAwardBtn.selected?@"bottom":@"top"] forState:UIControlStateNormal];
                    make.height.equalTo(@(point.y <= KOpenAwardHeight/2?0:KOpenAwardHeight));
                }];
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
#pragma mark - Action
- (IBAction)Add_Number:(id)sender {
    NSInteger cion_  = [self.cion_TextFiled.text integerValue];
    [self.cion_TextFiled setText:[NSString stringWithFormat:@"%ld",cion_ + 1]];
    bz_Price = cion_ + 1;
    NSLog(@" +++  %.0f",bz_Price);
}
- (IBAction)subtract_Number:(id)sender {
    NSInteger cion_  = [self.cion_TextFiled.text integerValue];
    if(cion_ == 1) return;
    [self.cion_TextFiled setText:[NSString stringWithFormat:@"%ld",cion_ - 1]];
    bz_Price = cion_ - 1;
    NSLog(@" -----  %.0f",bz_Price);
}
- (void)openAward:(UIButton *)sender{
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [AwardContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(sender.selected?0:KOpenAwardHeight));
        }];
        [self.view layoutIfNeeded];
    }];
    sender.selected = ! sender.selected;
    [sender setImage:[UIImage imageNamed:sender.selected?@"bottom":@"top"] forState:UIControlStateNormal];
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
#pragma mark -  投注
- (IBAction)bz_cathectic:(id)sender {
    [betView SyncParseData];
    [bet_Pop show];
}
#pragma mark - 模式切换
- (IBAction)modeSwitch:(UIButton *)sender {
    [sender setTitle:sender.tag == 0 ? @"快捷模式":@"输入模式" forState:UIControlStateNormal];
    sender.tag = sender.tag == 0 ? 1 : 0 ;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"modeSwitch" object:@(sender.tag)];
}
#pragma mark - 退出时重置数据
- (void)dealloc{
    bz_selectedDic = nil;
    bz_Price = 0;
    bz_PourNumber = 0;
    bz_extendedPrice = 0;
}
#pragma mark - Lazy - Loding
- (CustomDiskInfoView *)customDisk{
    if(!_customDisk){
        CGRect rect = CGRectMake(0, CGRectStatus.size.height +CGRectNav.size.height, kScreenWidth, kScreenHeight - CGRectStatus.size.height - CGRectNav.size.height);
        __weak typeof(self) weakSelf = self;
        _customDisk = [[CustomDiskInfoView alloc] initWithFrame:rect withClickCall_Black:^(NSString *DiskName) {
            weakSelf.titleLbl.text = DiskName;
            [weakSelf dismiss];
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
        _table.bounces = NO;
        _table.backgroundColor = RGBACOLOR(15, 15, 15, 1);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerNib:[UINib nibWithNibName:@"bz_ContentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([bz_ContentCell class])];
    }
    return _table;
}


@end
