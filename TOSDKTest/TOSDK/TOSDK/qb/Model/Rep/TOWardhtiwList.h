//
//  TOWardhtiwList.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/23.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOWardhtiwListData;
@interface TOWardhtiwList : TOBaseRepModel
@property (nonatomic, strong) NSArray <TOWardhtiwListData *> *data;
@end

@interface TOWardhtiwListData : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *applyTime;
@property (nonatomic, copy) NSString *createdDate;
@property (nonatomic, copy) NSString *failErrorMsg;
@property (nonatomic, copy) NSString *finishedTime;
@property (nonatomic, copy) NSString *ppjb;
@property (nonatomic, copy) NSString *ppinc;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, assign) NSInteger orderStatus;
@property (nonatomic, copy) NSString *orderStatusName;
@property (nonatomic, copy) NSString *sysUserId;
@end

NS_ASSUME_NONNULL_END
