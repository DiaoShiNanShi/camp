//
//  GameCell.h
//  camp
//
//  Created by 张三好 on 2017/5/5.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *gameName;
@property (weak, nonatomic) IBOutlet UIImageView *gameIcon;
@end
