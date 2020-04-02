//
//  TOBaseReqModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TOGetWardhtiwConfigList.h"
NS_ASSUME_NONNULL_BEGIN

@interface TOBaseReqModel : NSObject
@property (nonatomic, copy) NSString *api;
@property (nonatomic, copy) NSString *caller;
@property (nonatomic, copy) NSString *requestId;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *traceId;
@end

NS_ASSUME_NONNULL_END
