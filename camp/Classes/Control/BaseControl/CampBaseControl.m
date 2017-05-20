//
//  CampBaseControl.m
//  camp
//
//  Created by 张三好 on 2017/5/4.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "CampBaseControl.h"

@interface CampBaseControl ()

@end

@implementation CampBaseControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBarTintColor:RGBACOLOR(12, 12, 12, 1)];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:RGBACOLOR(233, 197, 123, 1)};
    [self updateLanguage];
    
}

- (void)updateLanguage{
}
- (void)comblack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"_____________成功释放：%@",NSStringFromClass([self class]));
}

@end
