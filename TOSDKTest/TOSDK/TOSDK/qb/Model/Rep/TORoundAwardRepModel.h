//
//  TORoundAwardRepModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TORoundAwardData;
@interface TORoundAwardRepModel : TOBaseRepModel
@property (nonatomic, strong) TORoundAwardData *data;
@end

@interface TORoundAwardData : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *leftJB;
@property (nonatomic, copy) NSString *leftRP;
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, copy) NSString *currentRP;
@property (nonatomic, assign) NSInteger isNURP;
@end

NS_ASSUME_NONNULL_END
