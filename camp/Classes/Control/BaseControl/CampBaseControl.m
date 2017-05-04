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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"_____________成功释放：%@",NSStringFromClass([self class]));
}

@end
