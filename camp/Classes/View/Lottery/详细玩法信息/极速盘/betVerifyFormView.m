//
//  betVerifyFormView.m
//  camp
//
//  Created by 张三好 on 2017/5/18.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "betVerifyFormView.h"
#import "betVerifyFormViewCell.h"

@interface betVerifyFormView()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *titleName;
    UITableView *table;
    
    
    UILabel *panName;
    UIButton *cancelBtn;
    UIButton *makeBtn;
    UILabel *prouLbl;
    UILabel *qiLbl;
    
    /* 拷贝一份 */
    NSMutableDictionary *selectDic_Copy;
    NSMutableArray *selectArr;
}
@end

/* 全局_js */
extern NSMutableDictionary *selectedDic;
extern NSInteger pourNumber;
extern float extendedPrice;;

/* 全局_bz */
extern NSMutableDictionary *bz_selectedDic;
extern NSInteger bz_PourNumber;
extern float bz_extendedPrice;
@implementation betVerifyFormView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUI];
    }
    return self;
}

- (void)SyncParseData{
    @try {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            selectDic_Copy = [NSMutableDictionary dictionary];
            selectArr = [NSMutableArray array];
            if(self.type == DiskType_Bz){
                [bz_selectedDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    [obj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key_play, id  _Nonnull obj_play, BOOL * _Nonnull stop) {
                        if([obj_play count] > 0){
                            // 判断上一级是否添加过
                            if(![[selectDic_Copy allKeys] containsObject:key]){
                                [selectDic_Copy setValue:[NSMutableDictionary dictionary] forKey:key];
                            }
                            [selectDic_Copy[key] setObject:[NSMutableDictionary dictionary] forKey:key_play];
                        }
                        [obj_play enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key_num, id  _Nonnull obj_num, BOOL * _Nonnull stop) {
                            [selectDic_Copy[key][key_play] setObject:obj_num forKey:[key_num stringByReplacingOccurrencesOfString:key_play withString:@""]];
                        }];
                    }];
                }];
                NSLog(@"a");
                
            }else{
                /* 极速盘解析数据逻辑 */
                [selectedDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key_items, id  _Nonnull obj_Items, BOOL * _Nonnull stop) {
                    [obj_Items enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        if([obj count] != 0){
                            if(![[selectDic_Copy allKeys] containsObject:key_items]){
                                [selectDic_Copy setValue:[NSMutableArray array] forKey:key_items];
                            }
                            [selectDic_Copy[key_items] addObject:[NSDictionary dictionaryWithObject:obj forKey:key]];
                        }
                    }];
                }];
                [selectDic_Copy enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    [selectArr addObject:[NSDictionary dictionaryWithObject:obj forKey:key]];
                }];
            }
           dispatch_async(dispatch_get_main_queue(), ^{
                prouLbl.text = [NSString stringWithFormat:@"共%ld注,共%.0f元",self.type == DiskType_Js?pourNumber:bz_PourNumber,self.type == DiskType_Js?extendedPrice:bz_extendedPrice];
                qiLbl.text = [NSString stringWithFormat:@"距离__期截止"];
                [table reloadData];
           });
        });
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (void)setUI{
    titleName = [[UILabel alloc] init];
    [titleName setTextColor:[UIColor redColor]];
    titleName.text = @"投注确认";
    
    table = [[UITableView alloc] init];
    table.delegate = self;
    table.dataSource = self;
    [table registerNib:[UINib nibWithNibName:@"betVerifyFormViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([betVerifyFormViewCell class])];
    
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor redColor]];
    
    makeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [makeBtn setTitle:@"确认" forState:UIControlStateNormal];
    [makeBtn setBackgroundColor:[UIColor orangeColor]];
    
    panName = [[UILabel alloc] init];
    [panName setTextColor:[UIColor blackColor]];
    panName.font = [UIFont systemFontOfSize:14];
    panName.text = [persistenceData valueForKey:PD_SelectName];
    panName.textAlignment = NSTextAlignmentCenter;
    
    /* 当前公多少注  和 总价*/
    prouLbl = [[UILabel alloc] init];
    [prouLbl setTextColor:[UIColor blackColor]];
    prouLbl.font = [UIFont systemFontOfSize:13];
    prouLbl.textAlignment = NSTextAlignmentCenter;
    
    qiLbl = [[UILabel alloc] init];
    [qiLbl setTextColor:[UIColor blackColor]];
    qiLbl.font = [UIFont systemFontOfSize:13];
    qiLbl.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:titleName];
    [self addSubview:table];
    [self addSubview:cancelBtn];
    [self addSubview:makeBtn];
    [self addSubview:panName];
    [self addSubview:prouLbl];
    [self addSubview:qiLbl];
    
    [titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.trailing.equalTo(self.mas_centerX).offset(-5);
        make.height.equalTo(@30);
    }];
    
    [makeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(cancelBtn);
        make.trailing.equalTo(self).offset(-5);
        make.leading.equalTo(self.mas_centerX).offset(5);
    }];
    
    [prouLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(makeBtn);
        make.bottom.equalTo(makeBtn.mas_top).offset(-8);
    }];
    
    [qiLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(prouLbl);
        make.bottom.equalTo(prouLbl.mas_top);
    }];
    
    [panName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cancelBtn);
        make.centerY.equalTo(prouLbl.mas_top);
        make.width.equalTo(cancelBtn);
    }];
    
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(titleName.mas_bottom).offset(10);
        make.bottom.equalTo(panName.mas_top).offset(-8);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    /* 返回一共需要多少盘 */
    if(self.type == DiskType_Bz){
        return [selectDic_Copy allValues].count;
    }
    return selectArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     /* 返回每个盘面下一共选中了多少种玩法 */
     if(self.type == DiskType_Bz){
         return [selectDic_Copy[[selectDic_Copy allKeys][section]] allValues].count;
     }
    
    NSString *key = [selectArr[section] allKeys].firstObject;
    return [selectArr[section][key] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    betVerifyFormViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([betVerifyFormViewCell class])];
    NSString *key = self.type == DiskType_Bz ? @"" : [selectArr[indexPath.section] allKeys].firstObject;
    cell.diskID = self.type == DiskType_Bz ? [selectDic_Copy allKeys][indexPath.section]: key;
    cell.pid = self.type == DiskType_Bz ? [[selectDic_Copy[[selectDic_Copy allKeys][indexPath.section]] allKeys][indexPath.row] integerValue]: 0;
    cell.entity = self.type == DiskType_Bz ? [selectDic_Copy[[selectDic_Copy allKeys][indexPath.section]] allValues][indexPath.row] : selectArr[indexPath.section][key][indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __block NSString *CenterTxt = @"";
    if(self.type == DiskType_Js){
        NSString *key = [selectArr[indexPath.section] allKeys].firstObject;
        NSDictionary *entity = selectArr[indexPath.section][key][indexPath.row];
        
        NSArray *numcsArr = [entity allValues].firstObject;
        for(int i =0; i < [numcsArr count]; i ++){
            CenterTxt = [CenterTxt stringByAppendingString:[NSString stringWithFormat:@"、%@",numcsArr[i][@"name"]]];
        }
    }else{
        [[selectDic_Copy[[selectDic_Copy allKeys][indexPath.section]] allValues][indexPath.row] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            CenterTxt = [CenterTxt stringByAppendingString:[NSString stringWithFormat:@"、%@",obj[@"name"]]];
        }];
    }
    
    if([CenterTxt length] > 0){
        CenterTxt = [CenterTxt substringWithRange:NSMakeRange(1, CenterTxt.length - 1)];
    }
    
    CGSize size = [CenterTxt boundingRectWithSize:CGSizeMake(kScreenWidth * 0.5 - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height + 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    /* 得到盘面名称 */
    NSString *keyName = @"";
    NSInteger key = self.type == DiskType_Js?[[selectArr[section] allKeys].firstObject integerValue]:[[selectDic_Copy allKeys][section] integerValue];
    for (quotationInfoModel *model in CommonDataBaseModel.items[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_DiskID]]]) {
        if(model.id == key){
            keyName = model.name;
        }
    }
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    [sectionView setBackgroundColor:[UIColor redColor]];
    sectionView.backgroundColor = [UIColor orangeColor];
    
    
    UILabel *titleNamelbl = [[UILabel alloc] init];
    titleNamelbl.text = keyName;
    titleNamelbl.font = [UIFont systemFontOfSize:13];
    
    UILabel *centerLbl = [[UILabel alloc] init];
    centerLbl.text = @"提示";
    centerLbl.font = [UIFont systemFontOfSize:13];
    centerLbl.hidden = section == 0 ? NO : YES;
    
    UILabel *priceLbl = [[UILabel alloc] init];
    priceLbl.text = @"金额";
    priceLbl.font = [UIFont systemFontOfSize:13];
    priceLbl.hidden = section == 0 ? NO : YES;
    
    [sectionView addSubview:titleNamelbl];
    [sectionView addSubview:centerLbl];
    [sectionView addSubview:priceLbl];
    
    [titleNamelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView);
        make.leading.equalTo(sectionView).offset(10);
    }];
    [centerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(sectionView);
    }];
    [priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView);
        make.trailing.equalTo(sectionView).offset(-10);
    }];
    
    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

@end
