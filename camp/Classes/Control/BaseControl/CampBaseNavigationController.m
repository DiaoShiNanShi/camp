//
//  CampBaseNavigationController.m
//  camp
//
//  Created by 张三好 on 2017/5/15.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "CampBaseNavigationController.h"

@interface CampBaseNavigationController ()
{
    /* 渐变色 */
    CAGradientLayer *lineLayer;
}
@end

@implementation CampBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /* 添加渐变色 */
    lineLayer = [CAGradientLayer layer];
    lineLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)RGBACOLOR(234, 167, 39, 1).CGColor,(__bridge id)[UIColor blackColor].CGColor];
    lineLayer.startPoint = CGPointMake(0, 0);
    lineLayer.endPoint = CGPointMake(1, 0);
    lineLayer.frame = CGRectMake(0, 0, kScreenWidth, 1);
    [self.navigationBar.layer addSublayer:lineLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
