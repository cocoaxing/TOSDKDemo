//
//  TOWxSignInManager.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/9.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOWxSignInManager.h"
#import "TOWxLoManager.h"
//#import "MJExtension.h"
#import "TOUserInfo.h"
#import "TOUserDefault.h"
#import "TOSysUserInfoRepModel.h"
#import "TOViewModel.h"
#import "UIView+MAToast.h"
static TOWxSignInManager *_instance;
@implementation TOWxSignInManager

+ (instancetype)sharedInstance {
    if (_instance == nil) {
        _instance = [[TOWxSignInManager alloc] init];
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

- (void)wxSignInWithDelegate:(id<TOWxSignInDelegate>) delegate {
    [[TOWxLoManager sharedTOWxLoManager] wxAuthAccessTokenCallback:^(NSDictionary * _Nullable userInfo, NSInteger login, NSError * _Nullable error) {
        if (error) {
            if ([delegate respondsToSelector:@selector(onWxSignInFailed:)]) {
                [delegate onWxSignInFailed:error.description];
            }
        } else {
            if (login == 1) {
                
                NSString *localUserInfo = [[TOUserDefault sharedTOUserDefault] getUserInfo];
                NSDictionary *localUserInfoDic = [localUserInfo TOMJ_JSONObject];
                
                TOSysUserInfoRepModel *model = [TOSysUserInfoRepModel TOMJ_objectWithKeyValues:localUserInfoDic];
                if (model.status == 200) {
                    
                    TOUserInfo *userInfoModel = [[TOUserInfo alloc]init];
                    userInfoModel.userName = userInfo[@"nickname"];
                    userInfoModel.userImagUrl = userInfo[@"headimgurl"];
//                    NSString *sysUserId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
                    TOSysUserInfoBo *bo = model.data.payUserRedpacketInfoBo;
                    userInfoModel.userId = [TOSDKUtil getIUUIDMD5];
                    userInfoModel.bindingWx = model.data.nickname.length>0 ? YES : NO;
                    userInfoModel.userName = model.data.nickname;
                    userInfoModel.userImagUrl = model.data.headImgurl;
                    userInfoModel.isTodayCheckIn = bo.isTodayChekcin;
                    userInfoModel.hasGotNewUserXjjl = bo.isNURP;
                    userInfoModel.chekckInDays = bo.continuousChekcinDays;
                    userInfoModel.isNewUserTx = bo.isNewUserTx;
                    
                    NSString *userInfoJson = [userInfoModel TOMJ_JSONString];
                    [[TOUserDefault sharedTOUserDefault] setUserInfo:userInfoJson];
                    
                    if ([delegate respondsToSelector:@selector(onWxSignInSuccess:)]) {
                        [delegate onWxSignInSuccess:userInfoModel];
                    }
                } else {
                    if ([delegate respondsToSelector:@selector(onWxSignInFailed:)]) {
                        [delegate onWxSignInFailed:model.msg];
                    }
                }
                
            } else {
                if ([delegate respondsToSelector:@selector(onWxSignInFailed:)]) {
                    [delegate onWxSignInFailed:error.description];
                }
            }
        }
    }];
}

- (void)getToUserInfo:(id<TOUserInfoDelegate>)delegate {
    
        //有完成绑定, 调后台接口
        TOViewModel *viewModel = [[TOViewModel alloc]init];
        [viewModel to_getSysUserInfoWithCallback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
            if (error) {
                if ([delegate respondsToSelector:@selector(onGetUserInfoFailed:)]) {
                    [delegate onGetUserInfoFailed:error.description];
                }
            } else {
                
                TOSysUserInfoRepModel *model = [TOSysUserInfoRepModel TOMJ_objectWithKeyValues:jsonDic];
                
                if (model.status == 200) {
                    
                    NSString *userInfoJson = [jsonDic TOMJ_JSONString];
                    TOSysUserInfoBo *bo = model.data.payUserRedpacketInfoBo;
                    TOUserInfo *userInfo = [[TOUserInfo alloc]init];
                    userInfo.userId = [TOSDKUtil getIUUIDMD5];
                    userInfo.bindingWx = model.data.nickname.length>0 ? YES : NO;
                    userInfo.userName = model.data.nickname;
                    userInfo.userImagUrl = model.data.headImgurl;
                    userInfo.isTodayCheckIn = bo.isTodayChekcin;
                    userInfo.hasGotNewUserXjjl = bo.isNURP;
                    userInfo.chekckInDays = bo.continuousChekcinDays;
                    userInfo.isNewUserTx = bo.isNewUserTx;
                    
                    [[TOUserDefault sharedTOUserDefault] setTotalRound:[model.data.payUserRedpacketInfoBo.leftJb integerValue]];
                    [[TOUserDefault sharedTOUserDefault] setOpenId:model.data.openId];
                    [[TOUserDefault sharedTOUserDefault] setUserInfo:userInfoJson];
                    [[TOUserDefault sharedTOUserDefault]setNewUserFlag:bo.isNURP];
                    [[TOUserDefault sharedTOUserDefault] setSysUserId:model.data.sysUserId];
                    
                    if ([delegate respondsToSelector:@selector(onGetUserInfoSuccess:)]) {
                        [delegate onGetUserInfoSuccess:userInfo];
                    }
                    
                } else {
                    if ([delegate respondsToSelector:@selector(onGetUserInfoFailed:)]) {
                        [delegate onGetUserInfoFailed:model.msg];
                    }
                }
            }
        }];
    
}

@end
