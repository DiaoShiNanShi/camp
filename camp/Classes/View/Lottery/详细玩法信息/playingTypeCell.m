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

@property (nonatomic, weak) IBOutlet UILabel *playingName;
@property (nonatomic, weak) IBOutlet UICollectionView *collection;

@end

@implementation playingTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 边距
    CGRect rect = self.collection.frame;
    float magin =2.5;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = magin;
    flowLayout.minimumInteritemSpacing = magin;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake((rect.size.width-(magin * 9))/9, (rect.size.width-(magin * 9))/9);
    
    self.collection.collectionViewLayout = flowLayout;
    // 注册Cell
    [self.collection registerNib:[UINib nibWithNibName:@"NumberCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([NumberCell class])];
    /* 计算每个单元格的大小 */
    self.returnSelfHeight = ^float{
        return 60;
    };
    
}
- (void)setEntity:(playTypeModel *)entity{
    _entity = entity;
    self.playingName.text = entity.name;
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NumberCell class]) forIndexPath:indexPath];
    return cell;
}

@end
