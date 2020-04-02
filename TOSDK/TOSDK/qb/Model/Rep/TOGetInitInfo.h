//
//  TOGetInitInfo.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/27.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOGetInitInfoData;
@class TOInitConfigBo;
@class TOInitJsonParam;
@interface TOGetInitInfo : TOBaseRepModel
@property (nonatomic, strong) TOGetInitInfoData *data;
@end

@interface TOGetInitInfoData : NSObject
@property (nonatomic, copy) NSString *traceId;
@property (nonatomic, strong) TOInitConfigBo *payInitConfigBo;
@end

@interface TOInitConfigBo : NSObject
@property (nonatomic, strong) TOInitJsonParam *jsonParam;
@end

@interface TOInitJsonParam : NSObject
@property (nonatomic, copy) NSString *canKanKan;
@property (nonatomic, copy) NSString *hongkankan;
@property (nonatomic, copy) NSString *titi;
@end

NS_ASSUME_NONNULL_END
