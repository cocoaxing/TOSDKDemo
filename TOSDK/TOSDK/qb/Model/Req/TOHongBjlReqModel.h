//
//  TOHongBjlReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/26.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TORedPacketAwardParam;
@interface TOHongBjlReqModel : TOBaseReqModel
@property (nonatomic, strong) TORedPacketAwardParam *param;
@end

@interface TORedPacketAwardParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *awardValue;
@property (nonatomic, copy) NSString *sysUserId;
@end

NS_ASSUME_NONNULL_END
