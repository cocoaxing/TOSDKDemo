//
//  TOJsonParamRepModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/27.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOJsonParam;
@class TOJsonParamData;
@interface TOJsonParamRepModel : TOBaseRepModel
@property (nonatomic, strong) TOJsonParam *data;
@end

@interface TOJsonParam : NSObject
@property (nonatomic, strong) TOJsonParamData *jsonParam;
@end

@interface TOJsonParamData : NSObject
@property (nonatomic, copy) NSString *transferTips;
@property (nonatomic, copy) NSString *goneMsg;
@property (nonatomic, copy) NSString *siInMsg;
@property (nonatomic, strong) NSArray *imgs;
@end

NS_ASSUME_NONNULL_END
