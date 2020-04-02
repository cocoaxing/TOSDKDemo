
//
//  TOJsonParamRepModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/27.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOJsonParamRepModel.h"

@implementation TOJsonParamRepModel

@end

@implementation TOJsonParam

@end

@implementation TOJsonParamData
+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName {
    return @{@"transferTips":_NSStringFromBbString(TO_PP_TransferTips),
             @"goneMsg":_NSStringFromBbString(TO_PP_GoneMsg),
             @"siInMsg":_NSStringFromBbString(TO_PP_SiInMsg)
             };
}
@end
