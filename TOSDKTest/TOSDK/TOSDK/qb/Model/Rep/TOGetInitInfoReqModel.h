//
//  TOGetInitInfoReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/27.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOGetInitInfoParam;
@interface TOGetInitInfoReqModel : TOBaseReqModel
@property (nonatomic, strong) TOGetInitInfoParam *param;
@end

@interface TOGetInitInfoParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *sdkVersionCode;
@end

NS_ASSUME_NONNULL_END
