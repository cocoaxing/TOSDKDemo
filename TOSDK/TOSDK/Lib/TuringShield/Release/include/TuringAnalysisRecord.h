//
//  TuringAnalysisRecord.h
//  TuringShield
//
//  Created by Sensheng Xu on 2019/8/1.
//  Copyright © 2019 Tecent Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuringServiceDefine.h"


@tsclass(TuringAnalysisRecord);
@interface TuringAnalysisRecord : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;

@property (nonatomic, assign, readonly) NSUInteger sceneID;
@property (nonatomic, nullable, copy, readonly) NSString *userID;

#if TS_ENABLES_PREDICTION_PROCEEDING && !TS_ENABLES_DATA_SENDING
- (nullable NSData *)requestDataForSharkSashimi;
#endif

@end

@tsclass(TuringAnalysisGameRecord);
TS_AVAILABLE_IF(TS_AGE_PROJECT)
@interface TuringAnalysisGameRecord : TuringAnalysisRecord
@end

@tsclass(TuringAnalysisOwnerRecord);
TS_AVAILABLE_IF(TS_OWNER_PROJECT)
@interface TuringAnalysisOwnerRecord : TuringAnalysisRecord
@end

@tsclass(TuringAnalysisHumanRecord);
TS_AVAILABLE_IF(TS_HUMAN_PROJECT)
@interface TuringAnalysisHumanRecord : TuringAnalysisRecord
@end

@tsclass(TuringAnalysisFingerprintRecord);
TS_AVAILABLE_IF(TS_ENABLES_FINGERPRINT_FEATURE)
@interface TuringAnalysisFingerprintRecord : TuringAnalysisRecord
@end
