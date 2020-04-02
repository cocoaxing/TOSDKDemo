//
//  TOCheckInRepModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/11.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOCheckInData;
@interface TOCheckInRepModel : TOBaseRepModel
@property (nonatomic, strong) TOCheckInData *data;
@end

@interface TOCheckInData : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, assign) NSInteger continuousChekcinDays;
@property (nonatomic, copy) NSString *currentRP;
@property (nonatomic, assign) NSInteger isNURP;
@property (nonatomic, copy) NSString *leftJb;
@property (nonatomic, copy) NSString *leftRp;
@property (nonatomic, copy) NSString *sysUserId;
@end

NS_ASSUME_NONNULL_END
