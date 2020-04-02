//
//  TOSysUserInfoRepModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOSysUserInfoRepModel.h"

@implementation TOSysUserInfoRepModel

@end

@implementation TOSysUserInfoData
+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName {
    return @{@"headImgurl":_NSStringFromBbString(TO_PP_HeadImg),
             @"nickname":_NSStringFromBbString(TO_PP_Nickname),
             @"openId":_NSStringFromBbString(TO_PP_OpenId),
             @"unionId":_NSStringFromBbString(TO_PP_UnionId)
             };
}
@end

@implementation TOSysUserInfoBo
+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName {
    return @{@"currentRP":_NSStringFromBbString(TO_PP_CurrentRP),
             @"isNURP":_NSStringFromBbString(TO_PP_NURP),
             @"leftJb":_NSStringFromBbString(TO_PP_LeftJB),
             @"leftRp":_NSStringFromBbString(TO_PP_LeftRP),
             @"isNewUserTx":_NSStringFromBbString(TO_BB_ISNEWUSER_TX)
             };
}
@end
