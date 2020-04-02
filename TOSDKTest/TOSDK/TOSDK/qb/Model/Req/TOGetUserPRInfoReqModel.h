//
//  TOGetUserPRInfoReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/23.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOGetUserRedPacketInfoReqParam;
@interface TOGetUserPRInfoReqModel : TOBaseReqModel
@property (nonatomic, strong) TOGetUserRedPacketInfoReqParam *param;
@end

@interface TOGetUserRedPacketInfoReqParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@end

NS_ASSUME_NONNULL_END
