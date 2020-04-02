//
//  TOUserDefault.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOUserDefault : NSObject
singleton_interface(TOUserDefault)
//appId
- (void)setAppId:(NSString *)appId;
- (NSString *)getAppId;

//appUserId
- (void)setSysUserId:(NSString *)sysUserId;
- (NSString *)getSysUserId;

//openId
- (void)setOpenId:(NSString *)openId;
- (NSString *)getOpenId;
//wxId
- (void)setWxId:(NSString *)wxId;
- (NSString *)getWxId;
//secret
- (void)setSecretKey:(NSString *)secretKey;
- (NSString *)getSecretKey;
//universal link
- (void)setUniversalLink:(NSString *)link;
- (NSString *)getUniversalLink;

- (void)setHongKK:(NSString *)hongKK;
- (NSString *)getHongKK;

- (void)setCanKanKan:(NSString *)canKanKan;
- (NSString *)getCanKanKan;

- (void)setTiti:(NSString *)titi;
- (NSString *)getTiti;

- (void)setTransferTips:(NSString *)transferTips;
- (NSString *)getTransferTips;

- (void)setGoneTips:(NSString *)goneTips;
- (NSString *)getGoneTips;

- (void)setSignInTips:(NSString *)signInTips;
- (NSString *)getSignInTips;

- (void)setTotalRound:(NSInteger)round;

- (NSInteger)getTotalRound;

//新人标识
- (void)setNewUserFlag:(BOOL)flag;
- (BOOL)getUserFlag;

//log控制
- (void)setLogEnable:(BOOL)logEnable;
- (BOOL)getLogEnable;

//正测试服切换
- (void)setUseServer:(BOOL)useServer;
- (BOOL)getUseServer;

//跟踪id
- (void)setTraceId:(NSString *)traceId;
- (NSString *)getTraceId;

//当前控制器类型
- (void)setCurrentVcClass:(NSString *)currentVcClass;
- (NSString *)getCurrentVcClass;

- (void)setImgs:(NSArray *)imgs;
- (NSArray *)getImgs;

//app
- (NSString *)getAppVersion;

- (void)setUserName:(NSString *)userName;
- (NSString *)getUserName;

- (void)setUserImgUrl:(NSString *)imgUrl;
- (NSString *)getUserImgUrl;

- (void)setUserInfo:(NSString *)userInfo;
- (NSString *)getUserInfo;

- (void)setCurrentLeftRP:(CGFloat)leftRp;
- (CGFloat)getCurrentLeftRP;

@end

NS_ASSUME_NONNULL_END
