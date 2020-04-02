//
//  TuringAnalysisPolicy.h
//  TuringShield
//
//  Created by Sensheng Xu on 2019/8/1.
//  Copyright © 2019 Tecent Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuringServiceDefine.h"
#import <UIKit/UIKit.h>


#pragma mark -

@interface UIView (TSGetSystemKeyboardView)

+ (nullable UIView *)getSystemKeyboardView;
+ (nullable UIView *)getApplicationRootView;

@end

#pragma mark -

@tsclass(TuringAnalysisPolicy);
@interface TuringAnalysisPolicy : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;

+ (nonnull instancetype)gamePolicy TS_AVAILABLE_IF(TS_AGE_PROJECT);
+ (nonnull instancetype)ownerPolicy TS_AVAILABLE_IF(TS_OWNER_PROJECT);
+ (nonnull instancetype)ownerSecurityInputPolicy TS_AVAILABLE_IF(TS_OWNER_PROJECT);
+ (nonnull instancetype)ownerSecurityPatternPolicy TS_AVAILABLE_IF(TS_OWNER_PROJECT);
+ (nonnull instancetype)humanPolicy TS_AVAILABLE_IF(TS_HUMAN_PROJECT);

@property (nonatomic, weak, nullable) UIView *associatedView;

@property (nonatomic, assign) NSTimeInterval motionSamplingInterval;
@property (nonatomic, assign) NSTimeInterval expectedTotalTrackingTime;
@property (nonatomic, assign) NSTimeInterval extraTrackingTime;

/// 每天（按最近24小时计算）最大采集次数
@property (nonatomic, assign) NSUInteger maximumNumberOfAlysisRecordsPerDay;
/// 每小时（按最近60分钟内计算）最大采集次数
@property (nonatomic, assign) NSUInteger maximumNumberOfAlysisRecordsPerHour;
/// 每次创建任务最大采集次数
@property (nonatomic, assign) NSUInteger maximumNumberOfAlysisRecordsPerTask;
///每次采集之间间隔的时间，单位为秒
@property (nonatomic, assign) NSTimeInterval intervalBetweenRecords;

@end
