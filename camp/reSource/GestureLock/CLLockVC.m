//
//  CLLockVC.m
//  CoreLock
//
//  Created by 成林 on 15/4/21.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CLLockVC.h"
#import "CoreLockConst.h"
#import "CoreArchive.h"
#import "CLLockLabel.h"
#import "CLLockNavVC.h"
#import "CLLockView.h"



@interface CLLockVC ()

/** 操作成功：密码设置成功、密码验证成功 */
@property (nonatomic,copy) void (^successBlock)(CLLockVC *lockVC,NSString *pwd);

@property (nonatomic,copy) void (^forgetPwdBlock)();

@property (weak, nonatomic) IBOutlet CLLockLabel *label_camp;

@property (nonatomic,copy) NSString *msg;

@property (weak, nonatomic) IBOutlet CLLockView *lockView_camp;

@property (nonatomic,weak) UIViewController *vc;

@property (nonatomic,copy) NSString *modifyCurrentTitle;


@property (weak, nonatomic) IBOutlet UIView *actionView_camp;

@property (weak, nonatomic) IBOutlet UIButton *modifyBtn_camp;

/** 直接进入修改页面的 */
@property (nonatomic,assign) BOOL isDirectModify;

@end

@implementation CLLockVC

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //控制器准备
    [self vcPrepare];
    
    //数据传输
    [self dataTransfer];
    
    //事件
    [self event];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}


/*
 *  事件
 */
-(void)event{
    
    /*
     *  验证密码
     */
    
    /** 密码长度不够 */
    self.lockView_camp.setPWSErrorLengthTooShortBlock = ^(NSUInteger currentCount){
        
        [self.label_camp showWarnMsg:[NSString stringWithFormat:@"请连接至少%@个点",@(CoreLockMinItemCount)]];
    };
    
    /** 开始 */
    self.lockView_camp.verifyPWBeginBlock = ^(){
        
        [self.label_camp showNormalMsg:CoreLockVerifyNormalTitle];
    };
    
    /** 验证 */
    self.lockView_camp.verifyPwdBlock = ^(NSString *pwd){
    
        //取出本地密码
        NSString *pwdLocal = [CoreArchive strForKey:CoreLockPWDKey];
        
        BOOL res = [pwdLocal isEqualToString:pwd];
        
        if(res){//密码一致
            
            [self.label_camp showNormalMsg:CoreLockVerifySuccesslTitle];
            
            if(CoreLockTypeVeryfiPwd == _type){
                
                //禁用交互
                self.view.userInteractionEnabled = NO;
                
            }else if (CoreLockTypeModifyPwd == _type){//修改密码
                
                [self.label_camp showNormalMsg:CoreLockPWDTitleFirst];
                
                self.modifyCurrentTitle = CoreLockPWDTitleFirst;
            }
            
            if(CoreLockTypeVeryfiPwd == _type) {
                if(_successBlock != nil) _successBlock(self,pwd);
            }
            
        }else{//密码不一致
            
            [self.label_camp showWarnMsg:CoreLockVerifyErrorPwdTitle];

        }
        
        return res;
    };
    
}






/*
 *  数据传输
 */
-(void)dataTransfer{
    
    [self.label_camp showNormalMsg:self.msg];
    
    //传递类型
    self.lockView_camp.type = self.type;
}







/*
 *  控制器准备
 */
-(void)vcPrepare{

    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始情况隐藏
    self.navigationItem.rightBarButtonItem = nil;
    
    self.type = CoreLockTypeVeryfiPwd;
    
    self.title = @"手势解锁";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //默认标题
    self.modifyCurrentTitle = CoreLockModifyNormalTitle;
    
    if(CoreLockTypeModifyPwd == _type) {
        
        _actionView_camp.hidden = YES;
        
        [_actionView_camp removeFromSuperview];

        if(_isDirectModify) return;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    }
    
    if(![self.class hasPwd]){
        [_modifyBtn_camp removeFromSuperview];
    }
}

-(void)dismiss{
    [self dismiss:0];
}


/*
 *  忘记密码
 */
-(void)forgetPwd{
    
}



/*
 *  修改密码
 */
-(void)modiftyPwd{
    
}








/*
 *  是否有本地密码缓存？即用户是否设置过初始密码？
 */
+(BOOL)hasPwd{
    
    NSString *pwd = [CoreArchive strForKey:CoreLockPWDKey];
    
    return pwd !=nil;
}




/*
 *  展示设置密码控制器
 */
+(instancetype)showSettingLockVCInVC:(UIViewController *)vc successBlock:(void(^)(CLLockVC *lockVC,NSString *pwd))successBlock{
    
    CLLockVC *lockVC = [self lockVC:vc];
    
    lockVC.title = @"设置密码";
    
    //设置类型
    lockVC.type = CoreLockTypeSetPwd;
    
    //保存block
    lockVC.successBlock = successBlock;
    
    return lockVC;
}




/*
 *  展示验证密码输入框
 */
+(instancetype)showVerifyLockVCInVC:(UIViewController *)vc forgetPwdBlock:(void(^)())forgetPwdBlock successBlock:(void(^)(CLLockVC *lockVC, NSString *pwd))successBlock{
    
    
    CLLockVC *lockVC = [self lockVC:vc];
    
    lockVC.title = @"手势解锁";
    
    //设置类型
    lockVC.type = CoreLockTypeVeryfiPwd;
    
    //保存block
    lockVC.successBlock = successBlock;
    lockVC.forgetPwdBlock = forgetPwdBlock;
    
    return lockVC;
}




/*
 *  展示验证密码输入框
 */
+(instancetype)showModifyLockVCInVC:(UIViewController *)vc successBlock:(void(^)(CLLockVC *lockVC, NSString *pwd))successBlock{
    
    CLLockVC *lockVC = [self lockVC:vc];
    
    lockVC.title = @"修改密码";
    
    //设置类型
    lockVC.type = CoreLockTypeModifyPwd;
    
    //记录
    lockVC.successBlock = successBlock;
    
    return lockVC;
}





+(instancetype)lockVC:(UIViewController *)vc{
    
    CLLockVC *lockVC = [[CLLockVC alloc] init];

    lockVC.vc = vc;
    
    CLLockNavVC *navVC = [[CLLockNavVC alloc] initWithRootViewController:lockVC];
    
    [vc presentViewController:navVC animated:YES completion:nil];

    
    return lockVC;
}



-(void)setType:(CoreLockType)type{
    
    _type = type;
    
    //根据type自动调整label文字
    [self labelWithType];
}



/*
 *  根据type自动调整label文字
 */
-(void)labelWithType{
    
    if(CoreLockTypeSetPwd == _type){//设置密码
        
        self.msg = CoreLockPWDTitleFirst;
        
    }else if (CoreLockTypeVeryfiPwd == _type){//验证密码
        
        self.msg = CoreLockVerifyNormalTitle;
        
    }else if (CoreLockTypeModifyPwd == _type){//修改密码
        
        self.msg = CoreLockModifyNormalTitle;
    }
}


/*
 *  消失
 */
-(void)dismiss:(NSTimeInterval)interval{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}
- (IBAction)forgetPwdAction:(id)sender {

    [self dismiss:0];
    if(_forgetPwdBlock != nil) _forgetPwdBlock();
}


- (IBAction)modifyPwdAction:(id)sender {
    
    CLLockVC *lockVC = [[CLLockVC alloc] init];
    
    lockVC.title = @"修改密码";
    
    lockVC.isDirectModify = YES;
    
    //设置类型
    lockVC.type = CoreLockTypeModifyPwd;
    
    [self.navigationController pushViewController:lockVC animated:YES];
}












@end
