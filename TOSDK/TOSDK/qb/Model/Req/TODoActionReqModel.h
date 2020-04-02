//
//  TODoActionReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/13.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TODoActionReqParam;
@interface TODoActionReqModel : TOBaseReqModel

@property (nonatomic, strong) TODoActionReqParam *param;

@end

@interface TODoActionReqParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appReqType;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *cip;
@property (nonatomic, copy) NSString *cliTimestamp;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *eventId;
@property (nonatomic, copy) NSString *traceId;
@property (nonatomic, copy) NSString *appPackageName;
@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *appVersionName;
@property (nonatomic, copy) NSString *b1;
@property (nonatomic, copy) NSString *b2;
@property (nonatomic, copy) NSString *b3;
@property (nonatomic, copy) NSString *b4;
@property (nonatomic, copy) NSString *b5;
@property (nonatomic, copy) NSString *b6;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *imei;
@property (nonatomic, copy) NSString *jsonParam;
@property (nonatomic, copy) NSString *sdkVersionCode;
@property (nonatomic, copy) NSString *sdkVersionName;
@property (nonatomic, copy) NSString *sysUserId;
@end

NS_ASSUME_NONNULL_END
