//
//  TOBaseReqModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseReqModel.h"

#import "TOUserDefault.h"
@implementation TOBaseReqModel
- (instancetype)init {
    if (self = [super init]) {
        _time = [NSString stringWithFormat:@"%@000", [TOSDKUtil getCurrentTime]];
        _traceId = [[TOUserDefault sharedTOUserDefault] getTraceId];
    }
    return self;
}

@end
