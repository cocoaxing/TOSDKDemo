//
//  TOSysUserInfoReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOSysUserInfoReqParam;
@interface TOSysUserInfoReqModel : TOBaseReqModel
@property (nonatomic, strong) TOSysUserInfoReqParam *param;
@end

@interface TOSysUserInfoReqParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@end

NS_ASSUME_NONNULL_END
