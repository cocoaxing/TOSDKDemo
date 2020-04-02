//
//  TuringPostRule.h
//  TuringShield
//
//  Created by Sensheng Xu on 2019/8/1.
//  Copyright © 2019 Tecent Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuringServiceDefine.h"



@tsclass(TuringPostRule);
TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING)
@interface TuringPostRule : NSObject

+ (nonnull instancetype)postRule;
- (nonnull instancetype)init NS_UNAVAILABLE;

@property (nonatomic, assign) BOOL usesDebugServer;

@end

#define TuringDefaultAutoPostRule ([TuringAutoPostRule autoPostRule])

@tsclass(TuringAutoPostRule);
TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING)
@interface TuringAutoPostRule : TuringPostRule

+ (nonnull instancetype)autoPostRule;
+ (nonnull instancetype)postRule NS_UNAVAILABLE;

@property (nonatomic, assign) BOOL postsThroughWiFiOnly;
@property (nonatomic, assign) NSUInteger maximumPostsThroughCellulerPerDay;
@property (nonatomic, assign) NSUInteger maximumPostsThroughCellulerPerHour;

@property (nonatomic, assign) BOOL cachesRecordInCaseOfReachedMaximumPostsLimitation;
@property (nonatomic, assign) BOOL cachesRecordInCaseOfFailedPosting;
@property (nonatomic, assign) BOOL alsoPostsCachedRecordsIfPossible; // TODO: Havn't applied yet

@end
