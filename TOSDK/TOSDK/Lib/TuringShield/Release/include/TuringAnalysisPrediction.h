//
//  TuringAnalysisPrediction.h
//  TuringShield
//
//  Created by Sensheng Xu on 2019/8/1.
//  Copyright © 2019 Tecent Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuringServiceDefine.h"


@tsclass(TuringAnalysisPrediction);
TS_AVAILABLE_IF(TS_ENABLES_PREDICTION_PROCEEDING)
@interface TuringAnalysisPrediction : NSObject <NSCopying>

- (nonnull instancetype)init NS_UNAVAILABLE;

@property (nonatomic, assign, readonly)   BOOL advice;
@property (nonatomic, assign, readonly)   float posibility;
@property (nonatomic, nullable, readonly) NSError *error;

@end

@tsclass(TuringAnalysisGamePrediction);
TS_AVAILABLE_IFS(TS_ENABLES_PREDICTION_PROCEEDING, TS_AGE_PROJECT)
@interface TuringAnalysisGamePrediction : TuringAnalysisPrediction

@property (nonatomic, assign, getter=advice, readonly) BOOL isTeeny;
@property (nonatomic, assign, getter=posibility, readonly) float teenyPosibility;

@end

@tsclass(TuringAnalysisOwnerPrediction);
TS_AVAILABLE_IFS(TS_ENABLES_PREDICTION_PROCEEDING, TS_OWNER_PROJECT)
@interface TuringAnalysisOwnerPrediction : TuringAnalysisPrediction

@property (nonatomic, assign, getter=advice, readonly) BOOL isOwner;
@property (nonatomic, assign, getter=posibility, readonly) float ownerPosibility;

@end

@tsclass(TuringAnalysisHumanPrediction);
TS_AVAILABLE_IFS(TS_ENABLES_PREDICTION_PROCEEDING, TS_HUMAN_PROJECT)
@interface TuringAnalysisHumanPrediction : TuringAnalysisPrediction

- (BOOL)advice NS_UNAVAILABLE;

@property (nonatomic, assign, getter=posibility, readonly) float machinePosibility;

@end


typedef enum : NSUInteger {
    TuringDeviceFingerprintConditionNone       = -1,
    TuringDeviceFingerprintConditionNew        = 0,
    TuringDeviceFingerprintConditionRecall     = 1,
    TuringDeviceFingerprintConditionUpdate     = 2,
    TuringDeviceFingerprintConditionDelete     = 3,
    TuringDeviceFingerprintConditionQuery      = 4,
    TuringDeviceFingerprintConditionEmulator   = 5,
    TuringDeviceFingerprintConditionCache      = 255,
} TuringDeviceFingerprintCondition;

@tsclass(TuringDeviceFingerprint);
TS_AVAILABLE_IFS(TS_ENABLES_PREDICTION_PROCEEDING, TS_ENABLES_FINGERPRINT_FEATURE)
@interface TuringDeviceFingerprint : TuringAnalysisPrediction <NSCopying, NSSecureCoding>

- (BOOL)advice NS_UNAVAILABLE;

@property (nonatomic, readonly, nullable) NSString *ticket;
@property (nonatomic, readonly, nullable) NSString *deviceID;
@property (nonatomic, readonly, getter=posibility) float confidence;
@property (nonatomic, readonly, assign) NSInteger condition;

@end

TS_AVAILABLE_IF(TS_ENABLES_PREDICTION_PROCEEDING)
@interface NSError (TuringErrorType)

- (BOOL)isValuableForReposting;

@end
