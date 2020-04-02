//
//  TOViewModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^Callback)(NSDictionary * _Nullable jsonDic, NSError * _Nullable error);
@interface TOViewModel : TOBaseViewModel

- (void)to_getTiXianJbListWithCallback:(Callback)callback;

- (void)to_getYongHuHBInfoWithCallback:(Callback)callback;

- (void)to_getYongHuHBInfoPeiZListWithTypeValue:(NSString *)type callback:(Callback)callback;

- (void)to_doTiXApplyWithRound:(NSString *)round incValue:(NSString *)incValue  ID:(NSString *)ID callback:(Callback)callback;

- (void)to_getHqTxListWithCallback:(Callback)callback;

- (void)to_getTXSDKConfigInfoWithAppId:(NSString *)appId callback:(Callback)callback;

- (void)to_getJsonParamWithAppId:appId callback:(Callback)callback;

- (void)to_getSysUserInfoWithCallback:(Callback)callback;

- (void)to_doBindingUserWithUserInfo:(NSDictionary *)info callback:(Callback)callback;

- (void)to_doGJbJiangLWithRound:(NSString*)round callback:(Callback)callback;

- (void)to_doLQHongPaWithCallback:(Callback)callback;

- (void)to_getInitInfoWithAppId:(NSString *)appId callback:(Callback)callback;

- (void)to_getLogHis;

- (void)to_doCheckInWithJb:(NSString *)jb callback:(Callback)back;

- (void)to_doDotActionWithEventId:(NSString *)eventId callback:(_Nullable Callback)callback;

- (void)to_getLogHisWithEventId:(NSString *)eventId b1:(CGFloat)w b2:(CGFloat)h b3:(CGFloat)x b4:(CGFloat)y;

- (void)to_doFeedbackInfoWithFeedbackType:(NSString *)feedbackType phoneMsg:(NSString *)phoneMsg question:(NSString *)question answer:(NSString *)answer callback:(Callback)callback;
@end

NS_ASSUME_NONNULL_END
