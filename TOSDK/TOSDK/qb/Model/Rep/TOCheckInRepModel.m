//
//  TOCheckInRepModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/11.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOCheckInRepModel.h"

@implementation TOCheckInRepModel

@end

@implementation TOCheckInData

+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName {
    return @{@"currentRP":_NSStringFromBbString(TO_PP_CurrentRP),
             @"isNURP":_NSStringFromBbString(TO_PP_NURP),
             @"leftJb":_NSStringFromBbString(TO_PP_LeftJB),
             @"leftRp":_NSStringFromBbString(TO_PP_LeftRP)
             };
}

@end
