//
//  verticalLayoutControl.m
//  camp
//
//  Created by 张三好 on 2017/5/12.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "verticalLayoutControl.h"
#import "GroupSettingCell.h"
#import "verticalLayoutCell.h"

@interface verticalLayoutControl ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    /* 数据源 */
    DataBaseModel *dataBase;
    
    /* 选择的游戏分组模型 */
    gameGroupModel *groupModel;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation verticalLayoutControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    /** 默认第一个 */
    groupModel = CommonDataBaseModel.gameGroups.firstObject;
    
    /** 注册Nib */
    [self.table registerNib:[UINib nibWithNibName:@"GroupSettingCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([GroupSettingCell class])];
    /* 注册collectionCell */
    [self.collection registerNib:[UINib nibWithNibName:@"verticalLayoutCell" bundle:nil] forCellWithReuseIdentifier:KGamesCollectionViewCell];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataBase.gameGroups.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GroupSettingCell class])];
    cell.groupLbl.text = dataBase.gameGroups[indexPath.row].name;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    groupModel = dataBase.gameGroups[indexPath.row];
    [self.collection reloadData];
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [dataBase.games[groupModel.code] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    gameModel *game_ = dataBase.games[groupModel.code][indexPath.row];
    verticalLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KGamesCollectionViewCell forIndexPath:indexPath];
    cell.gameName.text = game_.name1;
    [cell.gameIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,game_.picPath1]] placeholderImage:[UIImage imageNamed:@"cb_mono_on"]];
    return cell;
}

/** 返回每个Item的Size */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = kScreenWidth  * 0.75 / 4 - 10 ;
    return CGSizeMake(width, width * 1.5);
}
@end
