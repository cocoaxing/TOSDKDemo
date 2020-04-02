//
//  TOPRConfigListReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/23.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TORPConfigListParam;
@interface TOPRConfigListReqModel : TOBaseReqModel

@property (nonatomic, strong) TORPConfigListParam *param;
@end

@interface TORPConfigListParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, copy) NSString *typeValue;
@property (nonatomic, copy) NSString *appUserId;
@end

NS_ASSUME_NONNULL_END
