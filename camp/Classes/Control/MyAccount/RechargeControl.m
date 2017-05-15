//
//  RechargeControl.m
//  camp
//
//  Created by 张三好 on 2017/5/15.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "RechargeControl.h"
#import "shortcutRechargeCell.h"

@interface RechargeControl ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *cionArray;
    
    /* 渐变色 */
    CAGradientLayer *lineLayer;
    
    /* 上一个选中的Icon */
    UIImageView *prev_icon;
    
    /* 当前选中的Tag */
    NSInteger selectTag;
}
@property (nonatomic, weak) IBOutlet UITextField *money;
@property (nonatomic, weak) IBOutlet UICollectionView *collection;
@property (nonatomic, weak) IBOutlet UIView *lineView;


/* 充值方式 */
@property (nonatomic, weak) IBOutlet UIView *zfb_view;
@property (nonatomic, weak) IBOutlet UIView *yl_view;
@property (nonatomic, weak) IBOutlet UIView *zx_view;
@property (nonatomic, weak) IBOutlet UIView *gs_view;

@property (nonatomic, weak) IBOutlet UIImageView *zfb_icon;
@property (nonatomic, weak) IBOutlet UIImageView *yl_icon;
@property (nonatomic, weak) IBOutlet UIImageView *zx_icon;
@property (nonatomic, weak) IBOutlet UIImageView *gs_icon;


/* 添加选中手势 */
- (void)addGesture;
@end

@implementation RechargeControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cionArray = @[@"10",@"20",@"50",@"100",@"200",@"500",@"1000",@"2000",@"5000",@"10000",@"20000",@"50000",@"100000"];
    
    lineLayer = [CAGradientLayer layer];
    lineLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)RGBACOLOR(234, 167, 39, 1).CGColor,(__bridge id)[UIColor blackColor].CGColor];
    lineLayer.startPoint = CGPointMake(0, 0);
    lineLayer.endPoint = CGPointMake(1, 0);
    lineLayer.frame = CGRectMake(0, 0, kScreenWidth, 1);
    [self.lineView.layer addSublayer:lineLayer];
    
    [self addGesture];
}
- (void)addGesture{
    UITapGestureRecognizer *zfb_Select_Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectPayType:)];
    UITapGestureRecognizer *yl_Select_Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectPayType:)];
    UITapGestureRecognizer *zx_Select_Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectPayType:)];
    UITapGestureRecognizer *gs_Select_Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectPayType:)];
    
    [_zfb_view addGestureRecognizer:zfb_Select_Gesture];
    [_yl_view addGestureRecognizer:yl_Select_Gesture];
    [_zx_view addGestureRecognizer:zx_Select_Gesture];
    [_gs_view addGestureRecognizer:gs_Select_Gesture];
}

- (void)SelectPayType:(UITapGestureRecognizer *)sender{
    selectTag = sender.view.tag;
    if(prev_icon){
        [prev_icon setImage:[UIImage imageNamed:@"select"]];
    }
    switch (sender.view.tag) {
        case 0:
        {
            [_zfb_icon setImage:[UIImage imageNamed:@"selected"]];
            prev_icon = _zfb_icon;
        }
            break;
        case 1:{
            [_yl_icon setImage:[UIImage imageNamed:@"selected"]];
            prev_icon = _yl_icon;
        }
            break;
        case 2:{
            [_zx_icon setImage:[UIImage imageNamed:@"selected"]];
            prev_icon = _zx_icon;
        }
            break;
        case 3:{
            [_gs_icon setImage:[UIImage imageNamed:@"selected"]];
            prev_icon = _gs_icon;
        }
            break;
    }
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return cionArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    shortcutRechargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shortcutRechargeCell" forIndexPath:indexPath];
    cell.limitTxt = [NSString stringWithFormat:@"￥%@",cionArray[indexPath.row]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70, 40);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_money setText:cionArray[indexPath.row]];
}

@end
