//
//  ToBindingUserRepModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "ToBindingUserRepModel.h"

@implementation ToBindingUserRepModel

@end

@implementation ToBindingUserData
+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName {
    return @{@"headImgurl":_NSStringFromBbString(TO_PP_TransferTips),
             @"nickname":_NSStringFromBbString(TO_PP_GoneMsg),
             @"openId":_NSStringFromBbString(TO_PP_SiInMsg),
             @"unionId":_NSStringFromBbString(TO_PP_UnionId)
             };
}
@end

@implementation TOPayUserRedpacketInfoBo
+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName {
    return @{@"isNURP":_NSStringFromBbString(TO_PP_NURP),
             @"leftJB":_NSStringFromBbString(TO_PP_LeftJB),
             @"leftRP":_NSStringFromBbString(TO_PP_LeftRP)
             };
}
@end
