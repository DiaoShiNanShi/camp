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
    /* 默认选择第一个分组模型 */
    groupModel = CommonDataBaseModel.gameGroups[didSelectIndex];
    
    /* 注册collectionCell */
    [self.collection registerNib:[UINib nibWithNibName:@"GameCell" bundle:nil] forCellWithReuseIdentifier:KGamesCollectionViewCell];
    
    __weak typeof(self)  weakSelf = self;
    self.gameMenu.didSelectGameMenu = ^(NSInteger selectIndex) {
        didSelectIndex = selectIndex;
        groupModel = CommonDataBaseModel.gameGroups[didSelectIndex];
        [weakSelf.collection reloadData];
        [weakSelf.collection setContentOffset:CGPointMake(0, 0) animated:YES];
    };
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [CommonDataBaseModel.games[groupModel.code] count];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    gameModel *game_ = CommonDataBaseModel.games[groupModel.code][indexPath.row];
    GameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KGamesCollectionViewCell forIndexPath:indexPath];
    cell.gameName.text = game_.name1;
    [cell.gameIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,game_.picPath1]]];
    return cell;
}

/** 返回每个Item的Size */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([groupModel.code isEqualToString:@"mg"])return CGSizeMake(KGameCollectionCell_MG_Width, KGameCollectionCellHeight);
    if([groupModel.code isEqualToString:@"pt"])return CGSizeMake(KGameCollectionCell_PT_Width, KGameCollectionCellHeight);
    if([groupModel.code isEqualToString:@"bb"])return CGSizeMake(KGameCollectionCell_BB_Width, KGameCollectionCellHeight);
    if([groupModel.code isEqualToString:@"ag"])return CGSizeMake(KGameCollectionCell_AG_Width, KGameCollectionCellHeight);
    if([groupModel.code isEqualToString:@"xt"])return CGSizeMake(KGameCollectionCell_XT_Width, KGameCollectionCellHeight);
    return CGSizeMake(KGameCollectionCell_MG_Width, KGameCollectionCellHeight);
}
@end
