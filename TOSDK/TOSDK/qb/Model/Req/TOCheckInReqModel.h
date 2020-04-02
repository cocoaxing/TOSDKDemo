//
//  TOCheckInReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/11.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOCheckInReqParam;
@interface TOCheckInReqModel : TOBaseReqModel
@property (nonatomic, strong) TOCheckInReqParam *param;
@end

@interface TOCheckInReqParam : NSObject
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *awardValue;
@end

NS_ASSUME_NONNULL_END
