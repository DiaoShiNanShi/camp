//
//  MyAccountControl.m
//  camp
//
//  Created by 张三好 on 2017/5/15.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "MyAccountControl.h"
#import "MyAccountHeaderCell.h"
#import "MyAccountSettingCell.h"
#import "LogOutCell.h"
#import "RechargeControl.h"

@interface MyAccountControl ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *menuArray1;
    NSArray *menuArray2;
    
    NSArray *iconFilePath1;
    NSArray *iconFilePath2;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation MyAccountControl

- (void)viewDidLoad {
    [super viewDidLoad];
    menuArray1 = @[@"投注记录",@"充值/提现记录",@"结算记录",@"转账记录",@"赠送记录",@"账变记录",@"个人盈亏",@"操作记录"];
    menuArray2 = @[@"绑定银行卡",@"设置密码",@"手势密码"];
    iconFilePath1 = @[@"bet",@"withdrawDeposit",@"squaring-up",@"transfer accounts",@"give",@"accountChang",@"profitAndLoss",@"operation"];
    iconFilePath2 = @[@"图层-131",@"setPassWord",@"gesturePassWord"];
    
    /* 注册Cell */
    [self.table registerNib:[UINib nibWithNibName:@"MyAccountHeaderCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyAccountHeaderCell class])];
    [self.table registerNib:[UINib nibWithNibName:@"MyAccountSettingCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyAccountSettingCell class])];
    [self.table registerNib:[UINib nibWithNibName:@"LogOutCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([LogOutCell class])];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 9 : 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            /* 返回头信息视图 */
            MyAccountHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyAccountHeaderCell class])];
            cell.entity = ((UserModel *)[NSKeyedUnarchiver unarchiveObjectWithData:[persistenceData objectForKey:PD_UserInfo]]);
            
            __weak typeof(self) weakSelf = self;
            cell.AccountOperate = ^(NSInteger type) {
                
                switch (type) {
                    case 0:{
                        /* 提现 */
                    }
                        break;
                    case 1:{
                        /* 额度转换 */
                    }
                        break;
                    case 2:{
                        /* 充值 */
                        RechargeControl *Vc = [KMainStoryboard instantiateViewControllerWithIdentifier:@"RechargeControlID"];
                        [Vc setHidesBottomBarWhenPushed:YES];
                        [weakSelf.navigationController pushViewController:Vc animated:YES];
                    }
                        break;
                    default:
                        break;
                }
            };
            return cell;
        }
    }
    /*  登出 */
    if(indexPath.section == 1){
        if(indexPath.row == 3){
            LogOutCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogOutCell class])];
            cell.AppLogOutAction = ^{
                /* 登出 */
                NSLog(@"");
            };
            return cell;
        }
    }
    
    MyAccountSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyAccountSettingCell class])];
    [cell.icon setImage:[UIImage imageNamed:indexPath.section == 0 ? iconFilePath1[indexPath.row - 1]:iconFilePath1[indexPath.row]]];
    [cell.titleName setText:indexPath.section == 0 ? menuArray1[indexPath.row - 1] : menuArray2[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            return kScreenWidth * 0.4 + 40;
        }
    }
    /*  登出 */
    if(indexPath.section == 1){
        if(indexPath.row == 3){
            return 70;
        }
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        UIView *vc = [[UIView alloc] init];
        vc.frame = CGRectMake(0, 0, kScreenWidth, 10);
        vc.backgroundColor = RGBACOLOR(72, 72, 72, 1);
        return vc;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 1 ? 10 : 0;
}
@end
