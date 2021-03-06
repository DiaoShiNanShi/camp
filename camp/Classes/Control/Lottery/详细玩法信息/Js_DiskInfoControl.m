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
#import "betVerifyFormView.h"
#import "PourListControl.h"

@interface Js_DiskInfoControl ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
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
- (void)createUIControls;
@end

/* 全局 */
NSMutableDictionary *selectedDic;
/* 当前价格 */
float price;
/* 当前共多少注 */
NSInteger pourNumber;
/* 总价格 */
float extendedPrice;
@implementation Js_DiskInfoControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    shortcutArr = @[@"10",@"20",@"50",@"100",@"200",@"500",@"1000",@"2000",@"5000"];
    [persistenceData setValue:[NSString stringWithFormat:@"%ld",CommonDataBaseModel.items[[[persistenceData valueForKey:PD_DiskID] stringValue]].firstObject.id]  forKey:PD_Items_id];
    [persistenceData synchronize];
    self.title_Name_Lbl.text = [persistenceData valueForKey:PD_SelectName];
    
    /* 创建投注确认弹出层 */
    betView = [[betVerifyFormView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, kScreenHeight * 0.6)];;
    betView.type = DiskType_Js;
    [betView setBackgroundColor:[UIColor grayColor]];
    bet_Pop = [KLCPopup popupWithContentView:betView showType:KLCPopupShowTypeFadeIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeNone dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    
    /* 选中信息 */
    selectedDic = [NSMutableDictionary dictionary];
    extendedPrice = 0.0;
    pourNumber = 0;
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
    // 注册接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePriceInfo:) name:@"updatePriceInfo" object:nil];
}

- (void)updatePriceInfo:(id)notification{
    [self.pour_Lbl setText:[NSString stringWithFormat:@"共%ld注",pourNumber]];
    [self.cion_Lbl setText:[NSString stringWithFormat:@"%.0f元",extendedPrice]];
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
    
    /* 下注记录 */
    UIButton *BottomPour = [UIButton buttonWithType:UIButtonTypeCustom];
    [BottomPour setTitle:@"下注记录" forState:UIControlStateNormal];
    [BottomPour.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [BottomPour setBackgroundColor:RGBACOLOR(59, 59, 56, 1)];
    [BottomPour setTintColor:[UIColor whiteColor]];
    [BottomPour addTarget:self action:@selector(skipToPourPageControl:) forControlEvents:UIControlEventTouchUpInside];
    [BottomPour sizeToFit];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 15, 15)];
    [leftBtn setImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(comblack:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:BottomPour];
    
    /* 添加盘面信息 */
    [self.view addSubview:self.customDisk];
    [self.view bringSubviewToFront:self.customDisk];
}
- (void)skipToPourPageControl:(UIButton *)sender{
    PourListControl *vc = [[PourListControl alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    NSInteger cion_  = [self.cion_TextFiled.text integerValue];
    [self.cion_TextFiled setText:[NSString stringWithFormat:@"%ld",cion_ + 1]];
    price = cion_ + 1;
    NSLog(@" +++  %.0f",price);
}
- (IBAction)subtract_Number:(id)sender {
    NSInteger cion_  = [self.cion_TextFiled.text integerValue];
    if(cion_ == 1) return;
    [self.cion_TextFiled setText:[NSString stringWithFormat:@"%ld",cion_ - 1]];
    price = cion_ - 1;
    NSLog(@" -----  %.0f",price);
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

// 投注
- (IBAction)cathectic:(id)sender {
    [betView SyncParseData];
    [bet_Pop show];
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
    return shortcutArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    shortcutCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shortcutCollectionViewID" forIndexPath:indexPath];
    cell.cionLbl.text = shortcutArr[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 40);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.cion_TextFiled setText:shortcutArr[indexPath.row]];
    price = [shortcutArr[indexPath.row] floatValue];
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

#pragma mark - 退出时重置数据
- (void)dealloc{
    selectedDic = nil;
    price = 0;
    pourNumber = 0;
    extendedPrice = 0;
}

#pragma mark - Lazy Loding
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
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerNib:[UINib nibWithNibName:@"playingTypeCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([playingTypeCell class])];
    }
    return _table;
}

@end
