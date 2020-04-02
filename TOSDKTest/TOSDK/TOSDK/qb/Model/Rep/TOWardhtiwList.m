//
//  TOWardhtiwList.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/23.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOWardhtiwList.h"

@implementation TOWardhtiwList
+ (NSDictionary *)TOMJ_objectClassInArray {
    return @{
             @"data" : [TOWardhtiwListData class],
             };
}
@end

@implementation TOWardhtiwListData
+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName {
    return @{@"ppjb":_NSStringFromBbString(TO_PP_JB),
             @"ppinc":_NSStringFromBbString(TO_PP_INC)
             };
}
@end
