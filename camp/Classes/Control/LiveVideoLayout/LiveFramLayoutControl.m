//
//  LiveFramLayoutControl.m
//  camp
//
//  Created by 张三好 on 2017/5/12.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "LiveFramLayoutControl.h"
#import "LiveVideoCollectionCell.h"

@interface LiveFramLayoutControl ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collection;
@end

@implementation LiveFramLayoutControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /* 注册collectionCell */
    [self.collection registerNib:[UINib nibWithNibName:@"LiveVideoCollectionCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([LiveVideoCollectionCell class])];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveVideoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LiveVideoCollectionCell class]) forIndexPath:indexPath];
    [cell.icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_Video_pic%ld.jpg",indexPath.row + 1]]];
    return cell;
}

/** 返回每个Item的Size */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth / 2 - 5, 222);
}
@end
