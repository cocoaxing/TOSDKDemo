//
//  TuringAnalysisTask.h
//  TuringShield
//
//  Created by Sensheng Xu on 2019/8/1.
//  Copyright © 2019 Tecent Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuringServiceDefine.h"
#import "TuringAnalysisPolicy.h"
#import "TuringPostRule.h"
#import "TuringAnalysisRecord.h"
#import "TuringAnalysisPrediction.h"


#pragma mark -

typedef NSUInteger TuringPostIdentifier;
extern const TuringPostIdentifier TuringInvalidPost;

#pragma mark -

typedef TuringAnalysisRecord *_Nullable (^TuringAnalysisRecordHandler)(__kindof TuringAnalysisRecord *_Nonnull record);
typedef void (^TuringPostResponseHandler)(__kindof TuringAnalysisRecord *_Nonnull record, __kindof TuringAnalysisPrediction *_Nonnull prediction) TS_AVAILABLE_IF(TS_ENABLES_PREDICTION_PROCEEDING);

#pragma mark -

@tsclass(TuringAnalysisTask);
@interface TuringAnalysisTask : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;

@property (nonatomic, assign, readonly) NSUInteger sceneID;
@property (nonatomic, strong, nonnull, readonly) TuringAnalysisPolicy *analysisPolicy;
@property (nonatomic, nullable, copy, readonly) NSString *userID;

- (BOOL)start;
- (BOOL)startWithRecordHandler:(nullable TuringAnalysisRecordHandler)handler;
- (BOOL)startWithPostRule:(nullable TuringPostRule *)rule TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING);
- (BOOL)stop;
- (void)cancel;

- (void)addSplittingTimestamp:(NSTimeInterval)timestamp TS_AVAILABLE_IF(TS_OWNER_PROJECT);

@end

