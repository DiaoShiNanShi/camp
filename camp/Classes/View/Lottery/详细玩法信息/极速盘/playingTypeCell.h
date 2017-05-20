//
//  playingTypeCell.h
//  camp
//
//  Created by 张三好 on 2017/5/16.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface playingTypeCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UICollectionView *collection;
@property (nonatomic, strong) playTypeModel *entity;
@end
