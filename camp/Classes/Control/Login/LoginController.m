//
//  LoginController.m
//  camp
//
//  Created by 张三好 on 2017/5/2.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "LoginController.h"
#import "MainTabBarControl.h"

@interface LoginController ()<UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UITextField *userNameTxt;
@property (nonatomic, weak) IBOutlet UITextField *passWordTxt;
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
    [self.checkBox setImage:[UIImage imageNamed: [[persistenceData valueForKey:PD_IsRememberAccount] boolValue]?@"cb_mono_on":@"cb_mono_off"]];
    /* 选中的状态下添加账号 */
    NSLog(@"%@",[persistenceData valueForKey:PD_Account]);
    [self.userNameTxt setText:[persistenceData valueForKey:PD_Account]];
}

#pragma mark - ChecjBoxBtnOnClick
- (IBAction)ChecjBoxBtnOnClick:(UIButton *)sender {
    
    /*  保存更新 记住账号*/
    [self.checkBox setImage:[UIImage imageNamed:![[persistenceData valueForKey:PD_IsRememberAccount] boolValue]?@"cb_mono_on":@"cb_mono_off"]];
    [persistenceData setValue:![[persistenceData valueForKey:PD_IsRememberAccount] boolValue]?@(YES):@(NO) forKey:PD_IsRememberAccount];
    [persistenceData setValue:[[persistenceData valueForKey:PD_IsRememberAccount] boolValue]?self.userNameTxt.text:@"" forKey:PD_Account];
    [persistenceData synchronize];
}

#pragma mark - UITextFieldDelegate 编辑结束保存账号
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(![[persistenceData valueForKey:PD_IsRememberAccount] boolValue]) return;
    [persistenceData setValue:textField.text forKey:PD_Account];
}

#pragma mark - Login - 登录
- (IBAction)CheckLogin:(id)sender{
    
    NSString *userName = self.userNameTxt.text;
    NSString *passWord = self.passWordTxt.text;
    
    if(userName.length <= 0 || passWord.length <= 0){
        NSLog(@"账号或者密码不能为空");
        return;
    }
    
    NSMutableDictionary *parment = [NSMutableDictionary dictionary];
    [parment setValue:userName forKey:@"username"];
    [parment setValue:passWord forKey:@"password"];
    [parment setValue:@"0" forKey:@"type"];
    
    NSLog(@"________________开始登陆..........");
    [[CSNetWorkIngManager sharNetWorkManager] Post:Login withCommletionHandler:^(id result, NSError *error) {
    NSLog(@"________________登陆成功..........");
        /* 模型转换成功 ，保存数据跳转*/
        NSError *err;
        UserModel *entity = [[UserModel alloc] initWithDictionary:result[@"member"] error:&err];
        [persistenceData setObject:[NSKeyedArchiver archivedDataWithRootObject:entity] forKey:PD_UserInfo];
        [persistenceData synchronize];
        MainTabBarControl *Vc = [KMainStoryboard instantiateViewControllerWithIdentifier:KMainTabBarIdentFiler];
        [KAppDelegate restoreRootViewController:Vc];
    } withParameters:parment withcompletionHandlerError:^(NSString *code) {
        NSLog(@"%@",code);
    }];
}
- (void)dealloc{
    NSLog(@"成功释放控制器 ============ %@",NSStringFromClass([self class]));
}


@end
