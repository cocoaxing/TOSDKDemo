//
//  ToSdkManager.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/14.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "ToSdkManager.h"
#import "TOWalletViewController.h"
#import "WXApi.h"
#import "TOWxLoManager.h"
#import "TOUserDefault.h"
#import "TOViewModel.h"
#import "TOPayAppConfigInfo.h"
#import "TOJsonParamRepModel.h"
//#import "MJExtension.h"
#import "TuringShield.h"
#import "TOGetInitInfo.h"
#import "TOWxSignInManager.h"
@interface ToSdkManager ()<WXApiDelegate>
@end

static TOWxLoManager *wxLoginMgr = nil;
@implementation ToSdkManager


//获取手机当前显示的ViewController
+ (UIViewController*)currentViewController{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+ (void)showWradhtiwPage {
    TOWalletViewController *wVC = [[TOWalletViewController alloc]init];
    UIViewController *targetVc = [ToSdkManager currentViewController];
    
    if ([targetVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)targetVc;
        [navi pushViewController:wVC animated:YES];
    } else {
        [wVC setModalPresentationStyle:UIModalPresentationFullScreen];
        [targetVc presentViewController:wVC animated:YES completion:nil];
    }
}

+ (void)initSdkWithConfig:(TOSdkConfig *)config {
    
    [[TOUserDefault sharedTOUserDefault] setAppId:config.appkey];
    [[TOUserDefault sharedTOUserDefault] setLogEnable:config.logEnable];
    [[TOUserDefault sharedTOUserDefault] setUseServer:config.useTestServer];
    TOLog(@"TOSDK_LOG: TOSDK初始化成功");
    [TOSDKUtil getIUUIDMD5];
    
    
    NSString *ui = [NSString stringWithFormat:@"%@#%@", [TOSDKUtil getIUUIDMD5], config.appkey];
    [[TuringShield standardService] startRiskDetectingWithUserID:ui withPostRule:TuringDefaultAutoPostRule];
    
    TOViewModel *viewModel = [[TOViewModel alloc]init];
    [viewModel to_getInitInfoWithAppId:config.appkey callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (error) {
            TOLog(@"TOSDK_LOG: getInitInfo error = %@", error);
        } else {
            TOGetInitInfo *info = [TOGetInitInfo TOMJ_objectWithKeyValues:jsonDic];
            if (info.status == 200) {
                [[TOUserDefault sharedTOUserDefault] setTraceId:info.data.traceId];
                [[TOUserDefault sharedTOUserDefault] setHongKK:info.data.payInitConfigBo.jsonParam.hongkankan];
                [[TOUserDefault sharedTOUserDefault] setCanKanKan:info.data.payInitConfigBo.jsonParam.canKanKan];
                [[TOUserDefault sharedTOUserDefault] setTiti:info.data.payInitConfigBo.jsonParam.titi];
            } else {
                TOLog(@"TOSDK_LOG: getInitInfo = %@", info.msg);
            }
        }
        
        [viewModel to_getJsonParamWithAppId:config.appkey callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
            if (error) {
                TOLog(@"TOSDK_LOG: getJsonParam error = %@", error);
            } else {
                TOJsonParamRepModel *model = [TOJsonParamRepModel TOMJ_objectWithKeyValues:jsonDic];
                if (model.status == 200) {
                    TOJsonParamData *data = model.data.jsonParam;
                    [[TOUserDefault sharedTOUserDefault]setImgs:data.imgs];
                    [[TOUserDefault sharedTOUserDefault]setTransferTips:data.transferTips];
                    [[TOUserDefault sharedTOUserDefault]setGoneTips:data.goneMsg];
                    [[TOUserDefault sharedTOUserDefault]setSignInTips:data.siInMsg];
                } else {
                    TOLog(@"TOSDK_LOG: getJsonParam  = %@", model.msg);
                }
            }
        }];
        
        [viewModel to_getTXSDKConfigInfoWithAppId:config.appkey callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
            if (error) {
                TOLog(@"TOSDK_LOG: getJsonParam error = %@", error);
            } else {
                TOPayAppConfigInfo *info = [TOPayAppConfigInfo TOMJ_objectWithKeyValues:jsonDic];
                if (info.status == 200) {
                    [[TOUserDefault sharedTOUserDefault] setWxId:info.data.wxAppId];
                    [[TOUserDefault sharedTOUserDefault] setSecretKey:info.data.wxAppKey];
                    [[TOUserDefault sharedTOUserDefault] setUniversalLink:info.data.wxUniversalLink];
                    [WXApi registerApp:info.data.wxAppId universalLink:info.data.wxUniversalLink];
                }
            }
        }];
        
        [viewModel to_getLogHis];
        
        [[TOWxSignInManager sharedInstance] getToUserInfo:nil];
    }];
    
    
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[TOWxLoManager sharedTOWxLoManager]];
}

+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity {
    return [WXApi handleOpenUniversalLink:userActivity delegate:[TOWxLoManager sharedTOWxLoManager]];
}

@end
