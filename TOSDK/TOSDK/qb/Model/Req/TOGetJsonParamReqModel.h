//
//  TOGetPayAppConfigInfoReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/26.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOGetJsonParam;
@interface TOGetJsonParamReqModel : TOBaseReqModel
@property (nonatomic, strong) TOGetJsonParam *param;
@end

@interface TOGetJsonParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@end

NS_ASSUME_NONNULL_END
