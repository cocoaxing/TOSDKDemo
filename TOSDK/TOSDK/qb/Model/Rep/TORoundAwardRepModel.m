//
//  TORoundAwardRepModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TORoundAwardRepModel.h"

@implementation TORoundAwardRepModel

@end

@implementation TORoundAwardData
+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName {
    return @{@"leftJB":_NSStringFromBbString(TO_PP_LeftJB),
             @"leftRP":_NSStringFromBbString(TO_PP_LeftRP),
             @"currentRP":_NSStringFromBbString(TO_PP_CurrentRP),
             @"isNURP":_NSStringFromBbString(TO_PP_NURP)
             };
}
@end
