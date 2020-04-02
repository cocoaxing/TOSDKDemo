//
//  TOFeedbackInfoReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOFeedbackInfoParam;
@interface TOFeedbackInfoReqModel : TOBaseReqModel
@property (nonatomic, strong) TOFeedbackInfoParam *param;
@end

@interface TOFeedbackInfoParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *feedBackType;
@property (nonatomic, copy) NSString *phoneMsg;
@property (nonatomic, copy) NSString *questionStr;
@property (nonatomic, copy) NSString *answerStr;
@property (nonatomic, copy) NSString *sysUserId;
@end

NS_ASSUME_NONNULL_END
