//
//  TORoundAwardReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TORoundAwardParam;
@interface TORoundAwardReqModel : TOBaseReqModel
@property (nonatomic, strong) TORoundAwardParam *param;
@end

@interface TORoundAwardParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *awardValue;
@property (nonatomic, copy) NSString *sysUserId;
@end

NS_ASSUME_NONNULL_END
