//
//  TOViewModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOViewModel.h"
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
#import "TOWardhtiwListReqModel.h"
#import "TOWardhtiwList.h"
#import "TOPayAppReqModel.h"
#import "TOSysUserInfoReqModel.h"
#import "TOBindingUserReqModel.h"
#import "TORoundAwardReqModel.h"
#import "TOUserDefault.h"
#import "TOHongBjlReqModel.h"
#import "TOGetJsonParamReqModel.h"
#import "TOGetInitInfoReqModel.h"
#import "ToLogHisReqModel.h"
#import "TOCheckInReqModel.h"
#import "TODoActionReqModel.h"
#import "TOFeedbackInfoReqModel.h"
@interface TOViewModel ()

@end

@implementation TOViewModel
- (void)to_getTiXianJbListWithCallback:(Callback)callback {
    NSString *api = _NSStringFromBbString(FI_HQ_TX_ConfigList);
    TOGetWardhtiwConfigList *config = [[TOGetWardhtiwConfigList alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOGetWardhtiwConfigListParam *paramModel = [[TOGetWardhtiwConfigListParam alloc]init];
    paramModel.appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    NSString *sysUserId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
    paramModel.sysUserId = sysUserId.length > 0 ? sysUserId : @"";
    paramModel.typeValue = @"1";
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_getYongHuHBInfoWithCallback:(Callback)callback {
    NSString *api = _NSStringFromBbString(FI_HQ_YH_HB_Info);
    NSString *appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    TOGetUserPRInfoReqModel *config = [[TOGetUserPRInfoReqModel alloc]init];
    config.api = api;
    config.caller = appId;
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOGetUserRedPacketInfoReqParam *paramModel = [[TOGetUserRedPacketInfoReqParam alloc]init];
    paramModel.appId = appId;
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_getYongHuHBInfoPeiZListWithTypeValue:(NSString *)type callback:(Callback)callback {
    NSString *api = _NSStringFromBbString(FI_HQ_YH_HB_Info_List);
    NSString *appId = [[TOUserDefault sharedTOUserDefault] getAppId];;
    TOPRConfigListReqModel *config = [[TOPRConfigListReqModel alloc]init];
    config.api = api;
    config.caller = appId;
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TORPConfigListParam *paramModel = [[TORPConfigListParam alloc]init];
    paramModel.appId = appId;
    paramModel.sysUserId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
    paramModel.typeValue = type;
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_doTiXApplyWithRound:(NSString *)round incValue:(NSString *)incValue ID:(NSString *)ID callback:(Callback)callback {

    NSString *api = _NSStringFromBbString(FI_QU_TX_SQ);
    NSString *appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    TODoWardhtiwApplyReqModel *config = [[TODoWardhtiwApplyReqModel alloc]init];
    config.api = api;
    config.caller = appId;
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TODoWradhtiwApplyReqParam *paramModel = [[TODoWradhtiwApplyReqParam alloc]init];
    paramModel.appId = appId;
    paramModel.sysUserId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
    paramModel.id = ID;
    paramModel.inValue = incValue;
    paramModel.wid = [[TOUserDefault sharedTOUserDefault] getOpenId];
    paramModel.gvalue = round.length > 0 ? round : @"0";
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_getHqTxListWithCallback:(Callback)callback {
    NSString *api = _NSStringFromBbString(FI_HQ_TX_List);
    NSString *appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    TOWardhtiwListReqModel *config = [[TOWardhtiwListReqModel alloc]init];
    config.api = api;
    config.caller = appId;
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOWardhtiwListParam *paramModel = [[TOWardhtiwListParam alloc]init];
    paramModel.appId = appId;
    paramModel.sysUserId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
    paramModel.current = @"1";
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_getTXSDKConfigInfoWithAppId:(NSString *)appId callback:(Callback)callback {
    NSString *api = _NSStringFromBbString(FI_HQ_APP_ConfigInfo);
    TOPayAppReqModel *config = [[TOPayAppReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOPayAppReqParam *paramModel = [[TOPayAppReqParam alloc]init];
    paramModel.appId = appId;
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_getSysUserInfoWithCallback:(Callback)callback {
    NSString *api = FI_GetSysUserInfo;
    NSString *appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    TOSysUserInfoReqModel *config = [[TOSysUserInfoReqModel alloc]init];
    config.api = api;
    config.caller = appId;
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOSysUserInfoReqParam *paramModel = [[TOSysUserInfoReqParam alloc]init];
    paramModel.appId = appId;
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_doBindingUserWithUserInfo:(NSDictionary *)info callback:(Callback)callback {
    NSString *api = FI_DoBindingUser;
    TOBindingUserReqModel *config = [[TOBindingUserReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOBindingUserParam *paramModel = [[TOBindingUserParam alloc]init];
    paramModel.appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    paramModel.wid = info[@"openid"];
    [[TOUserDefault sharedTOUserDefault] setOpenId:info[@"openid"]];
    NSString *userName = info[@"nickname"];
    NSString *imgUrl = info[@"headimgurl"];
    [[TOUserDefault sharedTOUserDefault] setUserName:userName];
    [[TOUserDefault sharedTOUserDefault] setUserImgUrl:imgUrl];
    paramModel.wuid = info[@"unionid"];
    paramModel.wnkName = userName;
    paramModel.whimgurl = imgUrl;
    paramModel.originGValue = @"0";
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_doGJbJiangLWithRound:(NSString*)round callback:(Callback)callback {
    NSString *api = _NSStringFromBbString(FI_QU_JB_JL);
    TORoundAwardReqModel *config = [[TORoundAwardReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TORoundAwardParam *paramModel = [[TORoundAwardParam alloc]init];
    paramModel.appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    paramModel.awardValue =  round.length > 0 ? round : @"0";
    NSString *userId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
    paramModel.sysUserId = userId.length > 0 ? userId : @"";
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_doLQHongPaWithCallback:(Callback)callback {
    NSString *api = _NSStringFromBbString(FI_QU_HB_LQ);
    TOHongBjlReqModel *config = [[TOHongBjlReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TORedPacketAwardParam *paramModel = [[TORedPacketAwardParam alloc]init];
    paramModel.appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    paramModel.sysUserId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_getJsonParamWithAppId:(NSString *)appId callback:(Callback)callback {
    NSString *api = FI_GetJsonParam;
    TOGetJsonParamReqModel *config = [[TOGetJsonParamReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOGetJsonParam *paramModel = [[TOGetJsonParam alloc]init];
    paramModel.appId = appId;
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_getInitInfoWithAppId:(NSString *)appId callback:(Callback)callback {
    NSString *api = FI_GetInitInfo;
    TOGetInitInfoReqModel *config = [[TOGetInitInfoReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOGetInitInfoParam *paramModel = [[TOGetInitInfoParam alloc]init];
    paramModel.appId = appId;
    paramModel.sdkVersionCode = TOSDK_Version;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    paramModel.appVersion = app_Version;
    paramModel.channel = @"ios";
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    paramModel.deviceId = [TOSDKUtil getIUUIDMD5];
    paramModel.sysUserId = @"";
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_getLogHis {
    NSString *api = _NSStringFromBbString(FI_DoLogHis);
    ToLogHisReqModel *config = [[ToLogHisReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    ToLogHisParam *paramModel = [[ToLogHisParam alloc]init];
    config.param = paramModel;

    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];

    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];

    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
}

- (void)to_doCheckInWithJb:(NSString *)jb callback:(Callback)callback {
    NSString *api = FI_DoCheckIn;
    TOCheckInReqModel *config = [[TOCheckInReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOCheckInReqParam *paramModel = [[TOCheckInReqParam alloc]init];
    paramModel.sysUserId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
    paramModel.appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    paramModel.awardValue = jb;
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

- (void)to_doDotActionWithEventId:(NSString *)eventId callback:(_Nullable Callback)callback {
    NSString *api = FI_DoDotAction;
    TODoActionReqModel *config = [[TODoActionReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TODoActionReqParam *paramModel = [[TODoActionReqParam alloc]init];
    paramModel.eventId = eventId;
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (callback) {
            callback(jsonDic, error);
        }
    }];
}

- (void)to_getLogHisWithEventId:(NSString *)eventId b1:(CGFloat)w b2:(CGFloat)h b3:(CGFloat)x b4:(CGFloat)y {
    NSString *api = FI_DoDotAction;
    TODoActionReqModel *config = [[TODoActionReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TODoActionReqParam *paramModel = [[TODoActionReqParam alloc]init];
    paramModel.eventId = eventId;
    paramModel.b1 = [NSString stringWithFormat:@"%lf", w];
    paramModel.b2 = [NSString stringWithFormat:@"%lf", h];
    paramModel.b3 = [NSString stringWithFormat:@"%lf", x];
    paramModel.b4 = [NSString stringWithFormat:@"%lf", y];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
}

- (void)to_doFeedbackInfoWithFeedbackType:(NSString *)feedbackType phoneMsg:(NSString *)phoneMsg question:(NSString *)question answer:(NSString *)answer callback:(Callback)callback {
    NSString *api = FI_DoFeedbackInfo;
    TOFeedbackInfoReqModel *config = [[TOFeedbackInfoReqModel alloc]init];
    config.api = api;
    config.caller = [[TOUserDefault sharedTOUserDefault] getAppId];
    config.requestId = [TOSDKUtil getRandomStringWithNum:8];
    TOFeedbackInfoParam *paramModel = [[TOFeedbackInfoParam alloc]init];
    paramModel.feedBackType = feedbackType;
    paramModel.phoneMsg = phoneMsg;
    paramModel.questionStr = question;
    paramModel.answerStr = answer;
    paramModel.appId = [[TOUserDefault sharedTOUserDefault] getAppId];
    paramModel.appUserId = [TOSDKUtil getIUUIDMD5];
    config.param = paramModel;
    
    NSMutableDictionary *baseDic = [config TOMJ_JSONObject];
    [baseDic removeObjectForKey:@"param"];
    [baseDic removeObjectForKey:@"sign"];
    NSMutableArray *configDic = [paramModel TOMJ_JSONObject];
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    [mutableDic addEntriesFromDictionary:[baseDic copy]];
    [mutableDic addEntriesFromDictionary:[configDic copy]];
    
    NSString *sortString = [TOSDKUtil sortedDictionary:mutableDic];
    sortString  = [TOSDKUtil signMd5:sortString];
    config.sign = sortString;
    NSDictionary *param = [config TOMJ_JSONObject];
    [[TONetworking sharedTONetworking] post:param api:api callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        callback(jsonDic, error);
    }];
}

@end
