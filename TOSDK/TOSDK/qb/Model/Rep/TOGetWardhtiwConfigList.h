//
//  TOGetWardhtiwConfigList.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOGetWardhtiwConfigListParam;
@interface TOGetWardhtiwConfigList : TOBaseReqModel
@property (nonatomic, strong) TOGetWardhtiwConfigListParam *param;
@end

@interface TOGetWardhtiwConfigListParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, copy) NSString *typeValue;
@property (nonatomic, copy) NSString *appUserId;
@end

NS_ASSUME_NONNULL_END
