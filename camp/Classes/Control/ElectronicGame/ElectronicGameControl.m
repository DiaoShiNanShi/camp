//
//  ElectronicGameControl.m
//  camp
//
//  Created by 张三好 on 2017/5/4.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "ElectronicGameControl.h"
#import "GameElectronicMenu.h"
#import "GameCell.h"

@interface ElectronicGameControl ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    /* 数据源 */
    DataBaseModel *dataBase;
    
    /* 选择的游戏分组模型 */
    gameGroupModel *groupModel;
    
    /* 保存菜单选中下标 */
    NSInteger didSelectIndex;
}
@property (nonatomic, weak) IBOutlet UICollectionView *collection;
@property (nonatomic, weak) IBOutlet GameElectronicMenu *gameMenu;
@end

@implementation ElectronicGameControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /* 解档数据 */
    NSData *UnarchiveDataBase = [NSData dataWithContentsOfFile:LocalDataBaseModelFilePath];
    dataBase = [NSKeyedUnarchiver unarchiveObjectWithData:UnarchiveDataBase];
    
    /* 默认选择第一个分组模型 */
    groupModel = dataBase.gameGroups[didSelectIndex];
    
    /* 注册collectionCell */
    [self.collection registerNib:[UINib nibWithNibName:@"GameCell" bundle:nil] forCellWithReuseIdentifier:KGamesCollectionViewCell];
    
    __weak typeof(self)  weakSelf = self;
    self.gameMenu.didSelectGameMenu = ^(NSInteger selectIndex) {
        didSelectIndex = selectIndex;
        groupModel = dataBase.gameGroups[didSelectIndex];
        [weakSelf.collection reloadData];
    };
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [dataBase.games[groupModel.code] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    gameModel *game_ = dataBase.games[groupModel.code][indexPath.row];
    GameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KGamesCollectionViewCell forIndexPath:indexPath];
    cell.gameName.text = game_.name1;
    return cell;
}

/** 返回每个Item的Size */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    float magin = 10.0;
    size = CGSizeMake((kScreenWidth - (magin * 8)) / 4, (kScreenWidth - (magin * 8)) / 4);
    return size;
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
