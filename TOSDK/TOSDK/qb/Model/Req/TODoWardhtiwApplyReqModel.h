//
//  TODoWardhtiwApplyReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/22.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TODoWradhtiwApplyReqParam;
@interface TODoWardhtiwApplyReqModel : TOBaseReqModel
@property (nonatomic, strong) TODoWradhtiwApplyReqParam *param;
@end

@interface TODoWradhtiwApplyReqParam : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *gvalue;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *inValue;
@property (nonatomic, copy) NSString *wid;
@end

NS_ASSUME_NONNULL_END
