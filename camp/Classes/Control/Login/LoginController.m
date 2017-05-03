//
//  LoginController.m
//  camp
//
//  Created by 张三好 on 2017/5/2.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "LoginController.h"
@interface LoginController ()

@property (nonatomic, weak) IBOutlet UIImageView *checkBox;
@property (nonatomic, weak) IBOutlet UIButton *checkBoxBtn;
- (void)Basiclayout;
@end
@implementation LoginController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self Basiclayout];
}

- (void)Basiclayout{
    [self.checkBox setImage:[UIImage imageNamed: self.checkBoxBtn.selected?@"cb_mono_on":@"cb_mono_off"]];
    
}

#pragma mark - ChecjBoxBtnOnClick
- (IBAction)ChecjBoxBtnOnClick:(UIButton *)sender {
    
    [self.checkBox setImage:[UIImage imageNamed:!sender.selected?@"cb_mono_on":@"cb_mono_off"]];
    sender.selected  =! sender.selected;
}


@end
