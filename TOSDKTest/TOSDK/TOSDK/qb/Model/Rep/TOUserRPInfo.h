//
//  TOUserRPInfo.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/23.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOUserRPInfoData;
@interface TOUserRPInfo : TOBaseRepModel

@property (nonatomic, strong) TOUserRPInfoData *data;
@end

@interface TOUserRPInfoData : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *leftRP;
@property (nonatomic, copy) NSString *leftJB;
@property (nonatomic, copy) NSString *sysUserId;
@end
NS_ASSUME_NONNULL_END
