//
//  TOUserRPInfo.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/23.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOUserRPInfo.h"

@implementation TOUserRPInfo

@end

@implementation TOUserRPInfoData
+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName {
    return @{@"leftRP":_NSStringFromBbString(TO_PP_LeftRP),
             @"leftJB":_NSStringFromBbString(TO_PP_LeftJB)
             };
}
@end
