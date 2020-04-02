//
//  TOTxManager.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/28.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOTxManager.h"
#import "TOWalletViewController.h"
#import "TOLoViewController.h"
#import "TONewUserPage.h"
#import "TORewardHUD.h"
#import "TOUserDefault.h"
#import "TOViewModel.h"
#import "TOUserRPInfo.h"
#import "UIView+MAToast.h"
#import "TORoundAwardRepModel.h"
#import "TOBalanceHUD.h"
#import "TOSysUserInfoRepModel.h"
#import "TOCheckInRepModel.h"
#import "TOTXConfigListModel.h"
@interface TOTxManager ()<TOWalletViewControllerDelegate, TONewUserPageDelegate, TORewardHUDDelegate>

@property (nonatomic, weak) id<TOTxManagerDelegate> delegate;
@property (nonatomic, weak) id<TOJiBinReDelegate> coJbinsRewardDelegate;
@property (nonatomic, weak) id<TOCoJbinsBalanceDelegate> coJbinsBalanceDelegate;
@property (nonatomic, weak) id<TOTiXiInfoDelegate> wradhtiwInfoDelegate;

@end

static TOTxManager *_instance;
@implementation TOTxManager
+ (instancetype)sharedInstance {
    if (_instance == nil) {
        _instance = [[TOTxManager alloc] init];
    }
   
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
   
    return _instance;
}

- (void)showTxPageWithDeleagte:(id<TOTxManagerDelegate>)delegate {
    
    self.delegate = delegate;
    TOWalletViewController *wVC = [[TOWalletViewController alloc]init];
    wVC.delegate = self;
    UIViewController *targetVc = [TOSDKUtil currentViewController];
    if ([targetVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)targetVc;
        [navi pushViewController:wVC animated:YES];
    } else {
        [wVC setModalPresentationStyle:UIModalPresentationFullScreen];
        [targetVc presentViewController:wVC animated:YES completion:nil];
    }
}

- (void)txViewControllerTxApplySuccess:(NSInteger)txXj consumedJinb:(NSInteger)consumedJinb {
    if ([self.delegate respondsToSelector:@selector(onTxApplySuccess:consumedJinb:)]) {
        [self.delegate onTxApplySuccess:txXj consumedJinb:consumedJinb];
    }
}

- (void)txViewControllerTxApplyFailed:(NSString *)msg {
    if ([self.delegate respondsToSelector:@selector(onTxApplyFailed:)]) {
        [self.delegate onTxApplyFailed:msg];
    }
}

- (void)showXjinJliWithDelegate:(id<TOXjinJliDelegate>) delegate {
    self.cashRewardDelegate = delegate;
    BOOL isN = [[TOUserDefault sharedTOUserDefault] getUserFlag];
    UIViewController *vc = [TOSDKUtil currentViewController];
    if (!isN) {
        TONewUserPage *hud = [[TONewUserPage alloc]initWithFrame:vc.view.bounds];
        hud.alpha = 0.0f;
        [vc.view addSubview:hud];
        hud.delegate = self;
        [UIView animateWithDuration:0.3 animations:^{
            hud.alpha = 1.0f;
        }];
    } else {
        TORewardHUD *hud = [[TORewardHUD alloc]initWithFrame:vc.view.bounds];
        hud.alpha = 0.0f;
        hud.delegate = self;
        [vc.view addSubview:hud];
        [UIView animateWithDuration:0.3 animations:^{
            hud.alpha = 1.0f;
        }];
    }
}

- (void)userPage:(TONewUserPage *)page onXjinJliSuccess:(CGFloat)cashBalance {
    if ([self.cashRewardDelegate respondsToSelector:@selector(onXjinJliSuccess:)]) {
        [self.cashRewardDelegate onXjinJliSuccess:cashBalance];
    }
}

- (void)userPage:(TONewUserPage *)page onXjinJliFailed:(NSString *)msg {
    if ([self.cashRewardDelegate respondsToSelector:@selector(onXjinJliFailed:)]) {
        [self.cashRewardDelegate onXjinJliFailed:msg];
    }
}

- (void)rewardHUD:(TORewardHUD *)page onXjinJliSuccess:(CGFloat)cashBalance {
    if ([self.cashRewardDelegate respondsToSelector:@selector(onXjinJliSuccess:)]) {
        [self.cashRewardDelegate onXjinJliSuccess:cashBalance];
    }
}

- (void)rewardHUD:(TORewardHUD *)page onXjinJliFailed:(NSString *)msg {
    if ([self.cashRewardDelegate respondsToSelector:@selector(onXjinJliFailed:)]) {
        [self.cashRewardDelegate onXjinJliFailed:msg];
    }

}

- (void)showXiJinBalance {
    
    NSString *sysUserId = [[TOUserDefault sharedTOUserDefault] getOpenId];
    if (sysUserId.length>0) {
        //登陆成功
        [self getYe];
    } else {
        //未登录
        [[TOTxManager sharedInstance] showXjinJliWithDelegate:nil];
        
    }
    
}

- (void)login {
    
    //跳转到登陆提示界面
    UIViewController *vc = [TOSDKUtil currentViewController];
    TOLoViewController *loVc = [[TOLoViewController alloc]init];
    [loVc setCallback:^(BOOL isAuth, NSError * _Nullable error) {
        if (error) {
            TOLog(@"TOSDK_LOG: w .x.授权出错: %@", error);
        } else {
            if (isAuth) {
                TOLog(@"TOSDK_LOG: w .x.授权成功");
                [self getYe];
            } else {
                TOLog(@"TOSDK_LOG: w .x.授权或绑定失败");
                
            }
        }
    }];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [vc presentViewController:loVc animated:YES completion:nil];
    
}

- (void)getYe {
    TOViewModel *viewModel = [[TOViewModel alloc]init];
    [viewModel to_getYongHuHBInfoWithCallback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        UIViewController *vc = [TOSDKUtil currentViewController];
        if (error) {
            [vc.view makeToast:error.description duration:0.5 position:MAToastPositionCenter];
        } else {
            
            TOUserRPInfo *info = [TOUserRPInfo TOMJ_objectWithKeyValues:jsonDic];
            if (info.status == 200) {
                TOBalanceHUD *hud = [[TOBalanceHUD alloc]initWithFrame:vc.view.bounds];
                hud.alpha = 0.0f;
                hud.ye = info.data.leftRP;
                [vc.view addSubview:hud];
                
                [[TOUserDefault sharedTOUserDefault] setCurrentLeftRP:[info.data.leftRP floatValue]];
                
                [UIView animateWithDuration:0.3 animations:^{
                    hud.alpha = 1.0f;
                }];
            } else {
                [vc.view makeToast:info.msg duration:0.5 position:MAToastPositionCenter];
            }
            
        }
        
    }];
}

- (void)getJiBinRe:(NSInteger)coJbins delegate:(nonnull id<TOJiBinReDelegate>)delegate {
    self.coJbinsRewardDelegate = delegate;
    [self uploadCoJbins:coJbins];
 
}

- (void)uploadCoJbins:(NSInteger)coJbins {
    //有完成绑定, 调后台接口
    NSString *lq = _NSStringFromBbString(TO_BB_LQ);
    NSString *jb = _NSStringFromBbString(TO_BB_JB);
    UIViewController *vc = [TOSDKUtil currentViewController];
    TOViewModel *viewModel = [[TOViewModel alloc]init];
    NSString *roundStr = [NSString stringWithFormat:@"%ld", (long)coJbins];
    [viewModel to_doGJbJiangLWithRound:roundStr callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (error) {
            [vc.view makeToast:[NSString stringWithFormat:@"%@%ld%@出错:%@", lq,(long)coJbins,jb, error.description] duration:0.5 position:MAToastPositionCenter];
            if ([self.coJbinsRewardDelegate respondsToSelector:@selector(onJiBinReFailed:)]) {
                [self.coJbinsRewardDelegate onJiBinReFailed:[NSString stringWithFormat:@"%@", error]];
            }
        } else {
            TORoundAwardRepModel *model = [TORoundAwardRepModel TOMJ_objectWithKeyValues:jsonDic];
            if (model.status == 200) {
                if ([self.coJbinsRewardDelegate respondsToSelector:@selector(onJiBinReSuccess:)]) {
                    [self.coJbinsRewardDelegate onJiBinReSuccess:[model.data.leftJB integerValue]];
                }
            } else {
                [vc.view makeToast:[NSString stringWithFormat:@"Server%@%ld%@出错:%@", lq, (long)coJbins, jb,error.description] duration:0.5 position:MAToastPositionCenter];
                if ([self.coJbinsRewardDelegate respondsToSelector:@selector(onJiBinReFailed:)]) {
                    [self.coJbinsRewardDelegate onJiBinReFailed:model.msg];
                }
            }
        }
    }];
}

//cha xun yu e
- (void)getCoJbinsBalanceWithDelegate:(id<TOCoJbinsBalanceDelegate>) delegate {
    //判断是否完成w .x.绑定
    NSString *ye = _NSStringFromBbString(TO_BB_YE);
    NSString *jb = _NSStringFromBbString(TO_BB_JB);
    UIViewController *vc = [TOSDKUtil currentViewController];
    //有完成绑定, 调后台接口
    TOViewModel *viewModel = [[TOViewModel alloc]init];
    [viewModel to_getSysUserInfoWithCallback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (error) {
            [vc.view makeToast:[NSString stringWithFormat:@"获取%@%@出错:%@", jb, ye, error.description] duration:0.5 position:MAToastPositionCenter];
            if ([delegate respondsToSelector:@selector(onCoJbinsBalanceFailed:)]) {
                [delegate onCoJbinsBalanceFailed:[NSString stringWithFormat:@"%@", error]];
            }
        } else {
            TOSysUserInfoRepModel *model = [TOSysUserInfoRepModel TOMJ_objectWithKeyValues:jsonDic];
            if (model.status == 200) {
                if ([delegate respondsToSelector:@selector(onCoJbinsBalancedSuccess:)]) {
                    [delegate onCoJbinsBalancedSuccess:[model.data.payUserRedpacketInfoBo.leftJb integerValue]];
                }
            } else {
                [vc.view makeToast:[NSString stringWithFormat:@"获取%@%@出错:%@", jb, ye, model.msg] duration:0.5 position:MAToastPositionCenter];
                if ([delegate respondsToSelector:@selector(onCoJbinsBalanceFailed:)]) {
                    [delegate onCoJbinsBalanceFailed:model.msg];
                }
            }
        }
    }];
    
}

- (void)doCheckInWithCoJbins:(NSInteger)coJbins delegate:(id<TOCheckInDelegate>)delegate {
    UIViewController *vc = [TOSDKUtil currentViewController];
    TOViewModel *viewModel = [[TOViewModel alloc]init];
    [viewModel to_doCheckInWithJb:[NSString stringWithFormat:@"%ld",coJbins] callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (error) {
            [vc.view makeToast:[NSString stringWithFormat:@"签到出错:%@", error.description] duration:0.5 position:MAToastPositionCenter];
            if ([delegate respondsToSelector:@selector(onCheckInFailed:)]) {
                [delegate onCheckInFailed:[NSString stringWithFormat:@"%@", error]];
            }
        } else {
            TOCheckInRepModel *model = [TOCheckInRepModel TOMJ_objectWithKeyValues:jsonDic];
            if (model.status == 200) {
                if ([delegate respondsToSelector:@selector(onCheckInSuccessWithCheckInDays:coJbinsBalance:)]) {
                    [delegate onCheckInSuccessWithCheckInDays:model.data.continuousChekcinDays coJbinsBalance:[model.data.leftJb integerValue]];
                }
            } else {
                [vc.view makeToast:[NSString stringWithFormat:@"签到出错:%@", model.msg] duration:0.5 position:MAToastPositionCenter];
                if ([delegate respondsToSelector:@selector(onCheckInFailed:)]) {
                    [delegate onCheckInFailed:model.msg];
                }
            }
        }
    }];
}

- (void)getTiXiInfoWithDelegate:(id<TOTiXiInfoDelegate>)delegate {
    self.wradhtiwInfoDelegate = delegate;
    TOViewModel *viewModel = [[TOViewModel alloc]init];
    @weakify(self);
    [viewModel to_getTiXianJbListWithCallback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (error) {
            //出错处理
            if ([delegate respondsToSelector:@selector(onGetTiXiInfoFailed:)]) {
                [delegate onGetTiXiInfoFailed:error.description];
            }
        } else {
            @strongify(self);
            TOTXConfigListModel *model = [TOTXConfigListModel TOMJ_objectWithKeyValues:jsonDic];
            if (model.status == 200) {
                NSInteger round = [[TOUserDefault sharedTOUserDefault] getTotalRound];
                NSLog(@"当前用户金币111:%ld", round);
                NSArray *arr = model.data;
                NSInteger curValue = 0;
                NSInteger nextValue = 0;
                NSInteger nextJb = 0;
                //区间
                for (int i = 0; i < arr.count; i++) {
                    TOTXConfigListDataModel *dataModel = arr[i];
                    NSInteger ppjb = [dataModel.ppjb integerValue];
                    NSInteger ppinc = [dataModel.ppinc integerValue];
                    if (round < ppjb) {
                        if (i == 0) {
                            curValue = 0;
                        } else {
                            TOTXConfigListDataModel *preDataModel = arr[i-1];
                            curValue = [preDataModel.ppinc integerValue];
                        }
                        TOTXConfigListDataModel *iDataModel = arr[i];
                        nextValue = [iDataModel.ppinc integerValue];
                        nextJb = nextValue * 10000 - round;
                        break;
                    } else if (round == ppjb) {
                        curValue = ppinc;
                        if (i == arr.count - 1) {
                            nextValue = 0;
                            nextJb = 0;
                        } else {
                            TOTXConfigListDataModel *iDataModel = arr[i+1];
                            nextValue = [iDataModel.ppinc integerValue];
                            nextJb = nextValue * 10000 - round;
                        }
                        break;
                    } else {
                        if (i < arr.count - 1) {
                            continue;
                        } else {
                            curValue = ppinc;
                            if (i == arr.count - 1) {
                                nextValue = 0;
                                nextJb = 0;
                            } else {
                                TOTXConfigListDataModel *iDataModel = arr[i+1];
                                nextValue = [iDataModel.ppinc integerValue];
                                nextJb = nextValue * 10000 - round;
                            }
                            break;
                        }
                    }
                }
                
                ToTiXiInfo *info = [[ToTiXiInfo alloc]init];
                info.curWradhtiwXiJin = curValue;
                info.nextWradhtiwXiJin = nextValue;
                info.nextWradhtiwNeedCoJbins = nextJb;
                if ([self.wradhtiwInfoDelegate respondsToSelector:@selector(onGetTiXiInfoSuccess:)]) {
                    [self.wradhtiwInfoDelegate onGetTiXiInfoSuccess:info];
                }
                NSLog(@"当前可y提现额度为: %ld元, 下一个可提现额度:%ld元, 离下一个提现额度还差%ld金币", (long)curValue, (long)nextValue, (long)nextJb);
            } else {
                if ([delegate respondsToSelector:@selector(onGetTiXiInfoFailed:)]) {
                    [delegate onGetTiXiInfoFailed:model.msg];
                }
            }
        }
    }];
}

- (BOOL)isCasRewrdAvailable {
    
    CGFloat rwd = [[TOUserDefault sharedTOUserDefault] getCurrentLeftRP];
    if (rwd >= 95) {
        return NO;
    }
    return YES;
    
}

/************************************************************/

@end
