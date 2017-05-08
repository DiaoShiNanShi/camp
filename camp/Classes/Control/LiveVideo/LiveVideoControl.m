//
//  LiveVideoControl.m
//  camp
//
//  Created by 张三好 on 2017/5/5.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "LiveVideoControl.h"
#import "PopContentView.h"
@interface LiveVideoControl ()<UIScrollViewDelegate>
{
    KLCPopup *PopView_one;
    KLCPopup *PopView_two;
    PopContentView *popCv_one;
    PopContentView *popCv_two;
    
    /* 当前停留的页面 */
    NSInteger selectPageIndex;
}
@property (nonatomic, weak) IBOutlet UIScrollView *scroll;
@property (nonatomic, weak) IBOutlet UIPageControl *page;
@property (nonatomic, weak) IBOutlet UIButton *loginGameBtn;

 /* 生成弹出视图 */
- (void) CreatePopContentView;
@end

@implementation LiveVideoControl

- (void)viewDidLoad {
    [super viewDidLoad];
    selectPageIndex = 0;
    /* 把分页控制器放到视图最前面 */
    [self.view bringSubviewToFront:self.page];
    [self.view bringSubviewToFront:self.loginGameBtn];
    
    float img_height = kScreenHeight - CGRectStatus.size.height - CGRectNav.size.height - CGRectTab.size.height;
    for (int i = 1; i <= 6; i++) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_Video_pic%d.jpg",i]]];
        [img setFrame:CGRectMake(kScreenWidth * (i - 1), 0, kScreenWidth, img_height)];
        [self.scroll addSubview:img];
    }
    [self.scroll setContentSize:CGSizeMake(kScreenWidth * 6, img_height)];
    [self CreatePopContentView];
}
- (void)CreatePopContentView{
    
    popCv_one = [[PopContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, KGamePopViewHeight)];
    popCv_one.layer.cornerRadius = 3.0;
    popCv_one.layer.masksToBounds = YES;
    
    popCv_two = [[PopContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, (KGamePopViewHeight - 30) / 2 + 30)];
    popCv_two.layer.cornerRadius = 3.0;
    popCv_two.layer.masksToBounds = YES;
    
    PopView_one = [KLCPopup popupWithContentView:popCv_one showType:KLCPopupShowTypeFadeIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeNone dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    PopView_two = [KLCPopup popupWithContentView:popCv_two showType:KLCPopupShowTypeFadeIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeNone dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((scrollView.contentOffset.x - kScreenWidth / 2) / kScreenWidth) + 1;
    [self.page setCurrentPage:currentPage];
    selectPageIndex = currentPage;
}
- (IBAction)OpenGamePopContentView:(UIButton *)sender {
    if(selectPageIndex == 0){
        [PopView_two dismiss:YES];
        [PopView_one show];
    }else{
        [PopView_one dismiss:YES];
        [PopView_two show];
    }
}
@end
