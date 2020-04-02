//
//  TORPConfigList.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/23.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TORPConfigList.h"

@implementation TORPConfigList
+ (NSDictionary *)TOMJ_objectClassInArray {
    return @{
             @"data" : [TORPConfigListData class],
             };
}
@end

@implementation TORPConfigListData
+(NSDictionary *)TOMJ_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",
             @"ppjb":_NSStringFromBbString(TO_PP_JB),
             @"ppinc":_NSStringFromBbString(TO_PP_INC)
             };
}
@end
