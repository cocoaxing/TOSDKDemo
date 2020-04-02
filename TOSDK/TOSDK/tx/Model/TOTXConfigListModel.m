//
//  TOTXConfigListModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOTXConfigListModel.h"

@implementation TOTXConfigListModel
+ (NSDictionary *)TOMJ_objectClassInArray {
    return @{
             @"data" : [TOTXConfigListDataModel class],
             };
}
@end

@implementation TOTXConfigListDataModel
+(NSDictionary *)TOMJ_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",
             @"ppjb":_NSStringFromBbString(TO_PP_JB),
             @"ppinc":_NSStringFromBbString(TO_PP_INC)
             };
    
}
@end
