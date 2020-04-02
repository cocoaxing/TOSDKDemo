//
//  TOPayAppReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOPayAppReqParam;
@interface TOPayAppReqModel : TOBaseReqModel

@property (nonatomic, strong) TOPayAppReqParam *param;
@end

@interface TOPayAppReqParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@end

NS_ASSUME_NONNULL_END
