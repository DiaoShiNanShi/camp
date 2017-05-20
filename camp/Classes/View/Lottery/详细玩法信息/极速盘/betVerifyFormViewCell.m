//
//  betVerifyFormViewCell.m
//  camp
//
//  Created by 张三好 on 2017/5/18.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "betVerifyFormViewCell.h"

@interface betVerifyFormViewCell()

@property (nonatomic, weak) IBOutlet UILabel *titleName;
@property (nonatomic, weak) IBOutlet UILabel *priceLbl;

@end

@implementation betVerifyFormViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.bounds = [UIScreen mainScreen].bounds;
}

- (void)setEntity:(NSDictionary *)entity{
    _entity = entity;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        __block NSString *titleNameText;
        __block NSString *CenterTxt = @"";
        __block float MaxPrice = 0.0;
        
        [CommonDataBaseModel.playeds enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<playTypeModel *> * _Nonnull obj, BOOL * _Nonnull stop) {
            if([key isEqualToString:weakSelf.diskID]){
                for (playTypeModel *model in obj) {
                    if(model.id == (weakSelf.pid == 0 ? [[entity allKeys].firstObject integerValue] : weakSelf.pid)){
                        titleNameText = model.name;
                    }
                }
            }
        }];

        if([[entity allValues].firstObject isKindOfClass:[NSMutableArray class]]){
                    NSArray *numcsArr = [entity allValues].firstObject;
                    for(int i =0; i < [numcsArr count]; i ++){
                        CenterTxt = [CenterTxt stringByAppendingString:[NSString stringWithFormat:@"、%@",numcsArr[i][@"name"]]];
                        MaxPrice += [numcsArr[i][@"price"] floatValue];
                    }
        }else{
            [entity enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                CenterTxt = [CenterTxt stringByAppendingString:[NSString stringWithFormat:@"、%@",obj[@"name"]]];
                MaxPrice += [obj[@"price"] floatValue];
            }];
        }
    
        if([CenterTxt length] > 0){
            CenterTxt = [CenterTxt substringWithRange:NSMakeRange(1, CenterTxt.length - 1)];
        }
        /* 更新数据 */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.titleName setText:titleNameText];
            [self.centerLbl setText:CenterTxt];
            [self.priceLbl setText:[NSString stringWithFormat:@"%.0f",MaxPrice]];
        });
    });
}

- (void)setIntroductionText{
    //获得当前cell高度
    CGRect frame = [self frame];
//    //文本赋值
//    self.introduction.text = text;
//    //设置label的最大行数
//    self.introduction.numberOfLines = 10;
//    CGSize size = CGSizeMake(300, 1000);
//    CGSize labelSize = [self.introduction.text sizeWithFont:self.introduction.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    self.introduction.frame = CGRectMake(self.introduction.frame.origin.x, self.introduction.frame.origin.y, labelSize.width, labelSize.height);
//    
//    //计算出自适应的高度
//    frame.size.height = labelSize.height+100;
    
    self.frame = frame;
}

@end
