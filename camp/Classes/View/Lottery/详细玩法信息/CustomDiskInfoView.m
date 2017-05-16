//
//  CustomDiskInfoView.m
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "CustomDiskInfoView.h"
#import "DiskViewCollectionView.h"

@interface CustomDiskInfoView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    diskClick disk_;
    dismiss dis_;
    /* 背景视图 */
    UIView *backGroudView;
    
    NSArray<quotationInfoModel *> *DataSourceArray;
}

@property (nonatomic, strong) UICollectionView *collection;
@end

@implementation CustomDiskInfoView

- (instancetype)initWithFrame:(CGRect)frame withClickCall_Black:(diskClick)disk withDismiss:(dismiss)dis
{
    self = [super initWithFrame:frame];
    if(self){
        disk_ = disk;
        disk_ = dis;
        DataSourceArray = [NSArray arrayWithArray:CommonDataBaseModel.items[[[persistenceData valueForKey:PD_DiskID] stringValue]]];
        backGroudView = [[UIView alloc] initWithFrame:self.bounds];
        [backGroudView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:backGroudView];
        
        UITapGestureRecognizer* back_Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNullArea_Dismiss:)];
        [backGroudView addGestureRecognizer:back_Tap];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        float collectionHeight = DataSourceArray.count / 2 * 40 + (DataSourceArray.count % 2) * 40;
        CGRect rect = CGRectMake(0, 0, kScreenWidth, collectionHeight);
        self.collection = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        self.collection.dataSource=self;
        self.collection.delegate=self;
        [self.collection setBackgroundColor:[UIColor clearColor]];
        
        //注册Cell，必须要有
        [self.collection registerNib:[UINib nibWithNibName:@"DiskViewCollectionView" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DiskViewCollectionView class])];
        [backGroudView addSubview:self.collection];
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, collectionHeight, kScreenWidth, 30)];
        [footerView setBackgroundColor:[UIColor orangeColor]];
        
        UILabel *hintLbl = [[UILabel alloc] init];
        [hintLbl setText:@"请选择玩法信息"];
        hintLbl.font = [UIFont systemFontOfSize:14];
        [footerView addSubview:hintLbl];
        [self addSubview:footerView];
        
        [hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(footerView);
        }];
    }
    return self;
}
#pragma mark - 点击空白区域消失
- (void)clickNullArea_Dismiss:(UITapGestureRecognizer *)tap{
    disk_();
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return DataSourceArray.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiskViewCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DiskViewCollectionView class]) forIndexPath:indexPath];
    [cell.diskLbl setText:DataSourceArray[indexPath.row].name];
    return cell;
}
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/2, 40);
}

@end
