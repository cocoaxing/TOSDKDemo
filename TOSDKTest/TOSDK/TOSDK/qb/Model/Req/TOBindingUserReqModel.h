//
//  TOBindingUserReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOBindingUserParam;
@interface TOBindingUserReqModel : TOBaseReqModel
@property (nonatomic, strong) TOBindingUserParam *param;
@end

@interface TOBindingUserParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *whimgurl;
@property (nonatomic, copy) NSString *wnkName;
@property (nonatomic, copy) NSString *wid;
@property (nonatomic, copy) NSString *wuid;
@property (nonatomic, copy) NSString *originGValue;
@end

NS_ASSUME_NONNULL_END
