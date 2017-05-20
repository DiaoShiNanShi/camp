//
//  playingTypeCell.m
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "playingTypeCell.h"
#import "NumberCell.h"

@interface playingTypeCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray<NumberModel *> *datatSource;
}
@property (nonatomic, weak) IBOutlet UILabel *playingName;
@end

extern NSMutableDictionary *selectedDic;
extern NSInteger pourNumber;
extern float extendedPrice;
@implementation playingTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // 注册Cell
    [self.collection registerNib:[UINib nibWithNibName:@"NumberCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([NumberCell class])];
}
- (void)setEntity:(playTypeModel *)entity{
    _entity = entity;
    self.playingName.text = entity.name;
    datatSource = CommonDataBaseModel.numcs[[NSString stringWithFormat:@"%ld",entity.id]];
    [self.collection reloadData];
}
- (IBAction)clearBtn:(UIButton *)sender {
    NSMutableArray  * arr = selectedDic[[NSString stringWithFormat:@"%@",[persistenceData valueForKey:PD_Items_id]]][[NSString stringWithFormat:@"%ld",self.entity.id]];
    for (NSDictionary *item in arr) {
        extendedPrice -= [item[@"price"] integerValue];
    }
    pourNumber -= arr.count;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePriceInfo" object:nil userInfo:nil];
    [arr removeAllObjects];
    [_collection reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return datatSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NumberCell class]) forIndexPath:indexPath];
    cell.plID = self.entity.id;
    cell.entity = datatSource[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(KNumberCellHeight, KNumberCellHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end
