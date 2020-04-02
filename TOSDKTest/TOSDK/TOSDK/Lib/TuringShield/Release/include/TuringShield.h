//
//  TuringShield.h
//  TuringShield
//
//  Created by Sensheng Xu on 2019/6/24.
//  Copyright © 2019 Tecent Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TuringServiceDefine.h"

#import "TuringAnalysisRecord.h"
#import "TuringAnalysisPrediction.h"
#import "TuringPostRule.h"
#import "TuringAnalysisTask.h"
#import "TuringAnalysisPolicy.h"
#import "TuringAppContext.h"



#pragma mark - Description / Documentation

/*
!!!: 一、图灵盾服务接口概览
 
 图灵盾SDK可以为你的App提供三大类型的服务：风险预测、身份识别、年龄识别
 */

/*
 !!!: 二、主要接口类介绍
 
 
        TuringShieldService
                  |
                  |          指定分析策略
                  |      +---------- TuringAnalysisPolicy
                  |      v
                  | 创建分析任务
                  v
        TuringAnalysisTask
                  |
                  | 产生记录
                  v
        TuringAnalysisRecord
                  |
                  |          指定上报策略
                  |      +---------- TuringPostRule
                  |      v
                  | 预测结果
                  v
        TuringAnalysisPrediction
 */


/*
 !!!: 三、开始使用图灵盾
 
 使用图灵盾自动采集策略，只需要在合适的位置添加一行代码（例如applicationDidFinishLaunching）即可以启动：
    [[TuringShieldService standardService] startRiskDetectingWithUserID:YOUR_USER_ID];
 
 特别的，如果你需要为特定的使用图灵盾只需要在你的代码中添加数行代码即可。以人机分析为例：
     // 1. 选择一种分析策略（以人机为例）
     TuringAnalysisPolicy *humanPolicy = [TuringAnalysisPolicy humanPolicy];
     // 2. 绑定需要跟踪的p视图（下例是点击button1时触发采集）
     humanPolicy.associatedView = self.button1;
     // 2. 创建一个分析任务
     TuringAnalysisTask *humanTask = [[TuringShieldService standardService] analysisTaskForSceneID:YOUR_SCENE_ID withUserID:YOUR_USER_ID policy:humanPolicy];
     // 3. 在任何合适的时机（例如viewDidLoad）开始任务
     [humanTask startWithPostRule:TuringDefaultAutoPostRule];
     // 4. 在任何正确的时机（例如dealloc）结束任务
     [humanTask stop];
 
 在`TuringAnalysisPolicy`中有更多的分析参数和选项可供你因应不同环境和场景而作出细微调整。
 
 |<-- 为正确显示下面的图表，请拉伸你的代码窗口以确保下面的横线显示在同一行 ----------------------------------------->|

                               +------------------+
                               |                  |
           +------------+------+      Service     +------------------------+        +------------------+
           |            |      |                  |                        |        |                  |
           |            |      +---------+--------+                        |        |  AnalysisPolicy  |
           |            |                |                                 |        |                  |
           |            |                |                                 |        +-------+----------+
           |            |                |                                 |                |
           +            |                +                                 +                |
  [PREDICTION FEATURE]  |       [RECORD MANAGEMENT]               [ANALYSING FEATURE]       v
  -predictForRecord:    |   -managedRecords              -analysisTaskForSceneID:userID:policy:
  -predictForRecords:   |   -managedRecordsForSceneID:                     +
           +            |   -removeRecords:                                |
           |            |                +                        +--------v---------+
  +--------v---------+  |                |                        |                  |
  |                  |  |                |                        |   AnalysisTask   |
  |    Prediction    |  |                |                        |                  |
  |                  |  |                |                        +--------+---------+
  +------------------+  |                |                                 |
                        |                |                                 +
                        |                |                           [TASK OPERATION]
                        |                |                         -start
                        |                |                         -startWithRecordHandler:
                        +                |                         -startWithPostRule: <------+
               [Device FP FEATURE]       |                                 +                  |
              -getDeviceFingerprint      |                                 |                  |
                        +                |                                 |         +--------+--------+
                        |                |                                 |         |                 |
                        |                |                                 |         |     PostRule    |
                        |                |                                 |         |                 |
                        |                |                                 |         +-----------------+
                        |                |                                 |
               +--------v---------+      |                        +--------v---------+
               |                  |      |                        |                  |
               |    Device FP     |      +------------------------>      Record      |
               |                  |                               |                  |
               +------------------+                               +------------------+

 */

#pragma mark - Main
// !!!: 主接口

/**
 图灵盾服务
 主要功能：
 1. 提供预测能力
 2. 提供记录管理的能力
 3. 分析任务的管理能力
 */
@tsclass(TuringShield);
@interface TuringShield : NSObject

+ (nonnull instancetype)standardService;
- (nonnull instancetype)init NS_UNAVAILABLE;

+ (nonnull NSDictionary *)information;

@end

#pragma mark - Device Risk
// !!!: 设备风险接口

@interface TuringShield (DeviceRisk)

- (void)startRiskDetectingWithUserID:(nullable NSString *)userID withPostRule:(nullable TuringPostRule *)rule TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING);

- (void)startHumanServiceWithUserID:(nullable NSString *)userID withPostRule:(nullable TuringPostRule *)rule TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING);

- (void)startFingerprintServiceWithUserID:(nullable NSString *)userID withPostRule:(nullable TuringPostRule *)rule TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING);

- (void)startRiskDetectingWithUserID:(nullable NSString *)userID withRecordHandler:(nullable TuringAnalysisRecordHandler)recordHandler TS_AVAILABLE_IFS(__TS_NOT(TS_ENABLES_DATA_SENDING), TS_ENABLES_PREDICTION_PROCEEDING);

- (void)stopRiskDetecting TS_AVAILABLE_IF(TS_ENABLES_PREDICTION_PROCEEDING);

- (void)setupAppContext:(nonnull TuringAppContext *)context TS_AVAILABLE_IF(TS_ENABLES_FINGERPRINT_FEATURE);
- (BOOL)getFingerprintWithCompletionHandler:(nonnull void(^)(TuringDeviceFingerprint *_Nullable fingerprint))handler TS_AVAILABLE_IFS(TS_ENABLES_DATA_SENDING, TS_ENABLES_FINGERPRINT_FEATURE);


@end

#pragma mark - Task Management
// !!!: 任务管理

@interface TuringShield (TaskManagement)

- (nullable TuringAnalysisTask *)analysisTaskForSceneID:(NSUInteger)sceneID withUserID:(nonnull NSString *)userID policy:(nonnull TuringAnalysisPolicy *)policy;
- (nullable TuringAnalysisTask *)managedAnalysisTaskForSceneID:(NSUInteger)sceneID;

@end

@protocol TuringShieldServiceTaskDelegate <NSObject>

@optional
- (void)turingShieldService:(nonnull TuringShield *)service task:(nonnull TuringAnalysisTask *)task didReceiveRecord:(nonnull TuringAnalysisRecord *)record;
- (void)turingShieldService:(nonnull TuringShield *)service task:(nullable TuringAnalysisTask *)task didPostRecord:(nonnull TuringAnalysisRecord *)record withPrediction:(nonnull __kindof TuringAnalysisPrediction *)prediction TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING);

@end

#pragma mark - Record Management
// !!!: 记录管理

@interface TuringShield (RecordManagement)

- (nullable NSArray<TuringAnalysisRecord *> *)cachedRecords;
- (nullable NSArray<TuringAnalysisRecord *> *)cachedRecordsForSceneID:(NSUInteger)sceneID;
- (void)removeRecords:(nonnull NSArray<TuringAnalysisRecord *> *)records;

- (TuringPostIdentifier)postRecord:(nonnull TuringAnalysisRecord *)record forRule:(nullable TuringPostRule *)rule TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING);
- (TuringPostIdentifier)postRecords:(nonnull NSArray<TuringAnalysisRecord *> *)records forRule:(nullable TuringPostRule *)rule TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING);

- (void)addDelegate:(nonnull id<TuringShieldServiceTaskDelegate>)delegate;
- (void)removeDelegate:(nonnull id<TuringShieldServiceTaskDelegate>)delegate;

@end

#pragma mark - Advance
// !!!: 高级接口，一般不建议使用

@interface TuringShield (Advance)

@property (class, nonatomic) int32_t customChannelID TS_AVAILABLE_IF(TS_ENABLES_CUSTOM_CHANNEL_ID);

- (TuringPostIdentifier)postRecords:(nonnull NSArray<TuringAnalysisRecord *> *)records forRule:(nullable TuringPostRule *)rule withCompletionHandler:(nonnull TuringPostResponseHandler)handler TS_AVAILABLE_IF(TS_ENABLES_DATA_SENDING);

+ (void)setupTMFAppID:(nonnull NSString *)appID forKey:(nonnull NSString *)appPublicKey serverURL:(nonnull NSString *)serverURLString TS_AVAILABLE_IF(TMF);

@end
