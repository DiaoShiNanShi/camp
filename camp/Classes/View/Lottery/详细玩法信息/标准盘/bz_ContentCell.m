//
//  bz_ContentCell.m
//  camp
//
//  Created by 张三好 on 2017/5/19.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "bz_ContentCell.h"
#import "bz_NumberCell.h"

@interface bz_ContentCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray<NumberModel *> *datatSource;
}
@property (nonatomic, weak) IBOutlet UICollectionView *collection;
@end

@implementation bz_ContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.collection registerNib:[UINib nibWithNibName:@"bz_NumberCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([bz_NumberCell class])];
}

- (void)setEntity:(playTypeModel *)entity{
    _entity = entity;
    datatSource = CommonDataBaseModel.numcs[[NSString stringWithFormat:@"%ld",entity.id]];
   dispatch_async(dispatch_get_main_queue(), ^{
        [self.collection reloadData];
   });
}
#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return datatSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    bz_NumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([bz_NumberCell class]) forIndexPath:indexPath];
    cell.plID = self.entity.id;
    cell.entity = datatSource[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(KBZNumberCellHeight, KBZNumberCellHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
@end
