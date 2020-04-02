//
//  TOUserDefault.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOUserDefault.h"

@implementation TOUserDefault
singleton_implementation(TOUserDefault)

//appId
- (void)setAppId:(NSString *)appId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:appId forKey:TO_APP_ID];
    [defaults synchronize];
}
- (NSString *)getAppId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *appId = [defaults objectForKey:TO_APP_ID];
    return appId.length > 0 ? appId : @"";
}

- (void)setOpenId:(NSString *)openId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:openId forKey:TO_OPEN_ID];
    [defaults synchronize];
}

- (NSString *)getOpenId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *openId = [defaults objectForKey:TO_OPEN_ID];
    return openId;
}


- (void)setWxId:(NSString *)wxId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:wxId forKey:TO_WX_APP_ID];
    [defaults synchronize];
}
- (NSString *)getWxId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *openId = [defaults objectForKey:TO_WX_APP_ID];
    return openId;
}

- (void)setSecretKey:(NSString *)secretKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:secretKey forKey:TO_WX_SECRET_KEY];
    [defaults synchronize];
}
- (NSString *)getSecretKey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *openId = [defaults objectForKey:TO_WX_SECRET_KEY];
    return openId;
}

- (void)setUniversalLink:(NSString *)link {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:link forKey:TO_WX_UNIVERSAL_LINK];
    [defaults synchronize];
}
- (NSString *)getUniversalLink {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *openId = [defaults objectForKey:TO_WX_UNIVERSAL_LINK];
    return openId;
}

- (void)setSysUserId:(NSString *)sysUserId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sysUserId forKey:TO_SYS_USER_ID];
    [defaults synchronize];
}

- (NSString *)getSysUserId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:TO_SYS_USER_ID];
    return userId.length > 0 ? userId : @"";
}

- (void)setTotalRound:(NSInteger)round {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:round forKey:TO_STORE_GOLD];
    [defaults synchronize];
}

- (NSInteger)getTotalRound {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger totalRound = [defaults integerForKey:TO_STORE_GOLD];
    return totalRound;
}

- (void)setNewUserFlag:(BOOL)flag {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:flag forKey:TO_NEW_USER_FLAG];
    [defaults synchronize];
}

- (BOOL)getUserFlag {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL flag = [defaults boolForKey:TO_NEW_USER_FLAG];
    return flag;
}

- (void)setLogEnable:(BOOL)logEnable {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:logEnable forKey:TO_LOG_ENABLE];
    [defaults synchronize];
}

- (BOOL)getLogEnable {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL logEnable = [defaults boolForKey:TO_LOG_ENABLE];
    return logEnable;
}

- (void)setUseServer:(BOOL)useServer {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:useServer forKey:TO_USE_SERVER];
    [defaults synchronize];
}

- (BOOL)getUseServer {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL useServer = [defaults boolForKey:TO_USE_SERVER];
    return useServer;
}

- (void)setTransferTips:(NSString *)transferTips {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:transferTips forKey:TO_TXWA_TRAN_TIPS];
    [defaults synchronize];
}

- (NSString *)getTransferTips {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *transferTips = [defaults objectForKey:TO_TXWA_TRAN_TIPS];
    return transferTips;
}

- (void)setGoneTips:(NSString *)goneTips {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:goneTips forKey:TO_TXWA_GONE_TIPS];
    [defaults synchronize];
}

- (NSString *)getGoneTips {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *goneTips = [defaults objectForKey:TO_TXWA_GONE_TIPS];
    return goneTips;
}

- (void)setSignInTips:(NSString *)signInTips {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:signInTips forKey:TO_TXWA_SIGNIN_TIPS];
    [defaults synchronize];
}

- (NSString *)getSignInTips {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *signInTips = [defaults objectForKey:TO_TXWA_SIGNIN_TIPS];
    return signInTips;
}

- (void)setTraceId:(NSString *)traceId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:traceId forKey:TO_TRACE_ID];
    [defaults synchronize];
}

- (NSString *)getTraceId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *traceId = [defaults objectForKey:TO_TRACE_ID];
    
    return traceId.length>0 ? traceId : @"";
}

- (void)setHongKK:(NSString *)hongKK {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:hongKK forKey:TO_HONG_KAN];
    [defaults synchronize];
}

- (NSString *)getHongKK {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *hongKK = [defaults objectForKey:TO_HONG_KAN];
    
    return hongKK.length>0 ? hongKK : @"";
}

- (void)setCanKanKan:(NSString *)canKanKan {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:canKanKan forKey:TO_CAN_KAN];
    [defaults synchronize];
}

- (NSString *)getCanKanKan {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *canKanKan = [defaults objectForKey:TO_CAN_KAN];
    return canKanKan.length>0 ? canKanKan : @"";
}

- (void)setTiti:(NSString *)titi {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:titi forKey:TO_TITI];
    [defaults synchronize];
}

- (NSString *)getTiti {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *titi = [defaults objectForKey:TO_TITI];
    return titi.length>0 ? titi : @"";
}

- (void)setCurrentVcClass:(NSString *)currentVcClass {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentVcClass forKey:TO_CURRENT_VC_CLASS];
    [defaults synchronize];
}

- (NSString *)getCurrentVcClass {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentVcClass = [defaults objectForKey:TO_CURRENT_VC_CLASS];
    
    return currentVcClass;
}

- (void)setImgs:(NSArray *)imgs {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:imgs forKey:TO_IMGS_RE];
    [defaults synchronize];
}

- (NSArray *)getImgs {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *imgs = [defaults objectForKey:TO_IMGS_RE];
    return imgs;
}

- (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

- (void)setUserName:(NSString *)userName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userName forKey:TO_USER_NAME];
    [defaults synchronize];
}

- (NSString *)getUserName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:TO_USER_NAME];
    return userName.length>0 ? userName : @"";
}

- (void)setUserImgUrl:(NSString *)imgUrl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:imgUrl forKey:TO_USER_IMG_URL];
    [defaults synchronize];
}

- (NSString *)getUserImgUrl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *imgUrl = [defaults objectForKey:TO_USER_IMG_URL];
    return imgUrl.length>0 ? imgUrl : @"";
}

- (void)setUserInfo:(NSString *)userInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userInfo forKey:TO_USER_INFO];
    [defaults synchronize];
}

- (NSString *)getUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userInfo = [defaults objectForKey:TO_USER_INFO];
    return userInfo.length>0 ? userInfo : @"";
}

- (void)setCurrentLeftRP:(CGFloat)leftRp {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:leftRp forKey:TO_LEFT_RP];
    [defaults synchronize];
}

- (CGFloat)getCurrentLeftRP {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat leftRp = [defaults floatForKey:TO_LEFT_RP];
    return leftRp;
}

@end
