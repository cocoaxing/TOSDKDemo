//
//  TOWalletViewController.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/14.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOWalletViewController.h"
#import "TODetailViewController.h"
#import "TOWdResultViewController.h"
#import "TOFeedViewController.h"
#import "TOPopoverVc.h"
#import "TOWalletView.h"
#import "TOHeader.h"
#import "TONetworking.h"
#import "TOGetWardhtiwConfigList.h"
#import "TODoWardhtiwApplyReqModel.h"

#import "NSString+Extension.h"

#import "TOTXConfigListModel.h"
#import "TOLoViewController.h"
#import "TOWdResultViewController.h"
#import "TOWxLoManager.h"
#import "TOGetUserPRInfoReqModel.h"
#import "TOUserRPInfo.h"
#import "TOPRConfigListReqModel.h"
#import "TORPConfigList.h"
#import "TOViewModel.h"
#import "TOUserDefault.h"
#import "TOBaseRepModel.h"
#import "UIView+MAToast.h"
#import "TOTxManager.h"
#import "TOWvViewController.h"

@interface TOWalletViewController ()<TOWalletViewDelegate, UIPopoverPresentationControllerDelegate>
@property (nonatomic, strong) TOWalletView *walletView;
@property (nonatomic, strong) TOViewModel *viewModel;
@property (nonatomic, strong) TOUserRPInfo *redPacketInfo;
@property (nonatomic, strong) TOTXConfigListDataModel *txModel;
@property (nonatomic, copy) NSString *incValue;
@property (nonatomic, copy) NSString *round;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) TO_TYPE type;
@property(nonatomic, strong) TOPopoverVc *popVC;
@end

@implementation TOWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *vc = [TOSDKUtil currentViewController];
    [[TOUserDefault sharedTOUserDefault] setCurrentVcClass:NSStringFromClass([vc class])];
    self.view.backgroundColor = [UIColor whiteColor];
    _walletView = [[TOWalletView alloc]initWithFrame:self.view.bounds];
    _walletView.delegate = self;
    [self.view addSubview:_walletView];
    
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_ME_POP callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self to_getUserRedPacketInfo];
    [self to_getRedPacketConfigList];
    
}


- (void)to_getWradhtiwConfigList {
    
    @weakify(self);
    [self.viewModel to_getTiXianJbListWithCallback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (error) {
            //出错处理
        } else {
            @strongify(self);
            TOTXConfigListModel *model = [TOTXConfigListModel TOMJ_objectWithKeyValues:jsonDic];
            NSLog(@"TOSDK_LOG: %@", model);
            [self.walletView refreshTxData:model.data];
        }
    }];
    
}

- (void)to_getUserRedPacketInfo {
    //有绑定, 从系统拿
    @weakify(self);
    [self.viewModel to_getYongHuHBInfoWithCallback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (error) {
            
        } else {
            @strongify(self);
            TOUserRPInfo *model = [TOUserRPInfo TOMJ_objectWithKeyValues:jsonDic];
            if (model.status == 200) {
                self.redPacketInfo = model;
                NSLog(@"当前用户金币000:%@", model.data.leftJB); 
                [[TOUserDefault sharedTOUserDefault] setTotalRound:[model.data.leftJB integerValue]];
                [self.walletView refreshxJUserInfoData:model];
                [self to_getWradhtiwConfigList];
            } else {
                NSLog(@"TOSDK_LOG: to_getYongHuHBInfoWithCallback %@", model.msg);
            }
            
        }
    }];
}


- (void)to_getRedPacketConfigList {
    @weakify(self);
    [self.viewModel to_getYongHuHBInfoPeiZListWithTypeValue:@"2" callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (error) {
            
        } else {
            @strongify(self);
            TORPConfigList *model = [TORPConfigList TOMJ_objectWithKeyValues:jsonDic];
            NSLog(@"TOSDK_LOG: %@", model);
            [self.walletView refreshxJConfigInfoData:model.data];
        }
    }];
}

- (void)walletViewClickTx {
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_ME_TXJB_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    [self to_getWradhtiwConfigList];
}

- (void)walletViewClickjx {
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_ME_XJHB_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    [self to_getRedPacketConfigList];
}

- (void)walletViewBack:(TOWalletView *)view {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)walletViewDetail:(TOWalletView *)view {
    
    _popVC = [[TOPopoverVc alloc] init];
    _popVC.modalPresentationStyle = UIModalPresentationPopover;
    _popVC.preferredContentSize = CGSizeMake(80, 70);
    _popVC.popoverPresentationController.delegate = self;
    _popVC.popoverPresentationController.sourceView = view.mxBtn;
    _popVC.popoverPresentationController.sourceRect = view.mxBtn.bounds;
    _popVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    @weakify(self);
    _popVC.didSelectedCellBlock = ^(NSIndexPath * _Nonnull indexPath) {
        NSLog(@"%ld",indexPath.row);
        @strongify(self);
        
        [self.popVC dismissViewControllerAnimated:YES completion:nil];
        if (indexPath.row == 0) {
            TOViewModel *model = [[TOViewModel alloc]init];
            [model to_doDotActionWithEventId:DO_ME_TXMX_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
                
            }];
            TODetailViewController *detailVc = [[TODetailViewController alloc]init];
            [detailVc setModalPresentationStyle:UIModalPresentationFullScreen];
            [self presentViewController:detailVc animated:YES completion:nil];
        } else {
            TOFeedViewController *detailVc = [[TOFeedViewController alloc]init];
            [detailVc setModalPresentationStyle:UIModalPresentationFullScreen];
            [self presentViewController:detailVc animated:YES completion:nil];
        }
        
    };
    [self presentViewController:_popVC animated:YES completion:nil];
    

}

- (void)walletViewRule:(TOWalletView *)view {
    TOWvViewController *wVc = [[TOWvViewController alloc]init];
    wVc.type = 3;
    wVc.title = [NSString stringWithFormat:@"%@规则", _NSStringFromBbString(TO_BB_TX)];
    [wVc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:wVc animated:YES completion:nil];
}

- (void)handleTxWithData:(TOTXConfigListDataModel *)data {
    
    _txModel = data;
    
    self.incValue = data.ppinc;
    self.round = data.ppjb;
    self.ID = data.ID;
    self.type = data.typeValue;
    NSString *userName = [[TOUserDefault sharedTOUserDefault] getOpenId];
    if (userName.length > 0) {
        //登陆成功
        [self totx];
    } else {
        //未登录
        [self login];
    }
}


- (void)handleXjWithData:(TORPConfigListData *)data {
    
    NSInteger leftRed = [self.redPacketInfo.data.leftRP integerValue];
    NSInteger incValueInt = [data.ppinc integerValue];
    if (leftRed < incValueInt) {
        [[TOPopManager sharedInstance] popLackHud:[NSString stringWithFormat:@"抱歉, %@不足", _NSStringFromBbString(TO_BB_YE)] isT:NO];
        return;
    }
    self.incValue = data.ppinc;
    self.round = data.ppjb;
    self.ID = data.ID;
    self.type = data.typeValue;
    NSString *userName = [[TOUserDefault sharedTOUserDefault] getOpenId];
    if (userName.length > 0) {
        //登陆成功
        [self totx];
    } else {
        //未登录
        [self login];
    }
}

- (void)login {
    
    //跳转到登陆提示界面
    UIViewController *vc = [TOSDKUtil currentViewController];
    TOLoViewController *loVc = [[TOLoViewController alloc]init];
    [loVc setCallback:^(BOOL isAuth, NSError * _Nullable error) {
        if (error) {
            TOLog(@"TOSDK_LOG: w x L o g i n出错: %@", error);
        } else {
            if (isAuth) {
                TOLog(@"TOSDK_LOG: 授权成功");
            } else {
                TOLog(@"TOSDK_LOG: 授权或绑定失败");
                
            }
        }
    }];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [vc presentViewController:loVc animated:YES completion:nil];
    
}

- (void)totx{
    
    if (self.incValue == 0) {
        [self.view makeToast:[NSString stringWithFormat:@"请选择%@%@", _NSStringFromBbString(TO_BB_TX), _NSStringFromBbString(TO_BB_JE)] duration:0.5 position:MAToastPositionCenter];
        return;
    }
    @weakify(self);
    [self.viewModel to_doTiXApplyWithRound:self.round incValue:self.incValue ID:self.ID callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        @strongify(self);
        if (error) {
            if ([self.delegate respondsToSelector:@selector(txViewControllerTxApplyFailed:)]) {
                [self.delegate txViewControllerTxApplyFailed:error.description];
            }
        } else {
            
            TOBaseRepModel *model = [TOBaseRepModel TOMJ_objectWithKeyValues:jsonDic];
            if (model.status==100100) {
                
                NSString *msg = [[TOUserDefault sharedTOUserDefault] getGoneTips];
                [[TOPopManager sharedInstance] popOneYuanHud:msg applyCount:self.txModel.applyCount showTip:YES];
                if ([self.delegate respondsToSelector:@selector(txViewControllerTxApplyFailed:)]) {
                    [self.delegate txViewControllerTxApplyFailed:msg];
                }
            } else if (model.status==100017) {
            
                NSString *msg = [[TOUserDefault sharedTOUserDefault] getSignInTips];
                [[TOPopManager sharedInstance] popOneYuanHud:msg applyCount:self.txModel.applyCount showTip:NO];
                if ([self.delegate respondsToSelector:@selector(txViewControllerTxApplyFailed:)]) {
                    [self.delegate txViewControllerTxApplyFailed:model.msg];
                }
            
            } else if (model.status==200) {
                
                    NSString *sysUserId = [[TOUserDefault sharedTOUserDefault] getOpenId];
                    if (sysUserId.length > 0 && self.txModel.leftCount <= 0 && self.txModel.isNewUser == 1) {
                        [[TOPopManager sharedInstance] popOneYuanHud:self.txModel.goneMessage applyCount:0 showTip:NO];
                        return;
                    }
                
                if ([self.delegate respondsToSelector:@selector(txViewControllerTxApplySuccess:consumedJinb:)]) {
                    [self.delegate txViewControllerTxApplySuccess:[self.incValue integerValue] consumedJinb:[self.round integerValue]];
                }
                
                [self gotoTxResult:self.incValue];
            } else  {
                [[TOPopManager sharedInstance] popLackHud:model.msg isT:NO];
                if ([self.delegate respondsToSelector:@selector(txViewControllerTxApplyFailed:)]) {
                    [self.delegate txViewControllerTxApplyFailed:model.msg];
                }
            }
        }
    }];
}

- (void)gotoTxResult:(NSString *)incValue {
//    UIViewController *vc = [TOSDKUtil currentViewController];
    TOWdResultViewController *wdVc = [[TOWdResultViewController alloc]init];
    wdVc.incValue = incValue;
    [wdVc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:wdVc animated:YES completion:nil];
}

#pragma mark - popoverdelegate
// 设置点击蒙版是否消失
- (BOOL) popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}

// 默认返回的是覆盖整个屏幕
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

// 弹出视图消失后调用的方法
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    NSLog(@"dismissed");
}

- (TOViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TOViewModel alloc]init];
    }
    return _viewModel;
}

@end
