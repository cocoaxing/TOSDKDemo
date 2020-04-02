//
//  ToLogHisReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/10.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ToLogHisParam;
@interface ToLogHisReqModel : TOBaseReqModel
@property (nonatomic, strong) ToLogHisParam *param;
@end

@interface ToLogHisParam : NSObject
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *androidID;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appPackageName;
@property (nonatomic, copy) NSString *appReqType;
@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *appVersionName;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *imei;
@property (nonatomic, copy) NSString *installedList;
@property (nonatomic, copy) NSString *internetType;
@property (nonatomic, copy) NSString *ip;
@property (nonatomic, copy) NSString *isRoot;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *mac;
@property (nonatomic, copy) NSString *phoneBrand;
@property (nonatomic, copy) NSString *phoneModel;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *sdkVersionCode;
@property (nonatomic, copy) NSString *sdkVersionName;
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, copy) NSString *systemLang;
@property (nonatomic, copy) NSString *systemVersion;
@property (nonatomic, copy) NSString *traceId;
@property (nonatomic, copy) NSString *wifiMac;
@property (nonatomic, copy) NSString *wifiName;
@property (nonatomic, copy) NSString *highScreen;
@property (nonatomic, copy) NSString *wideScreen;
@property (nonatomic, copy) NSString *ordinate;
@property (nonatomic, copy) NSString *abscissa;
@end

NS_ASSUME_NONNULL_END
