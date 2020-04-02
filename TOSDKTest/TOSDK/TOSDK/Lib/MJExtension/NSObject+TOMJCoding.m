//
//  NSObject+TOMJCoding.m
//  TOMJExtension
//
//  Created by TOMJ on 14-1-15.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "NSObject+TOMJCoding.h"
#import "NSObject+TOMJClass.h"
#import "NSObject+TOMJProperty.h"
#import "TOMJProperty.h"

@implementation NSObject (TOMJCoding)

- (void)TOMJ_encode:(NSCoder *)encoder
{
    Class clazz = [self class];
    
    NSArray *allowedCodingPropertyNames = [clazz TOMJ_totalAllowedCodingPropertyNames];
    NSArray *ignoredCodingPropertyNames = [clazz TOMJ_totalIgnoredCodingPropertyNames];
    
    [clazz TOMJ_enumerateProperties:^(TOMJProperty *property, BOOL *stop) {
        // 检测是否被忽略
        if (allowedCodingPropertyNames.count && ![allowedCodingPropertyNames containsObject:property.name]) return;
        if ([ignoredCodingPropertyNames containsObject:property.name]) return;
        
        id value = [property valueForObject:self];
        if (value == nil) return;
        [encoder encodeObject:value forKey:property.name];
    }];
}

- (void)TOMJ_decode:(NSCoder *)decoder
{
    Class clazz = [self class];
    
    NSArray *allowedCodingPropertyNames = [clazz TOMJ_totalAllowedCodingPropertyNames];
    NSArray *ignoredCodingPropertyNames = [clazz TOMJ_totalIgnoredCodingPropertyNames];
    
    [clazz TOMJ_enumerateProperties:^(TOMJProperty *property, BOOL *stop) {
        // 检测是否被忽略
        if (allowedCodingPropertyNames.count && ![allowedCodingPropertyNames containsObject:property.name]) return;
        if ([ignoredCodingPropertyNames containsObject:property.name]) return;
        
        id value = [decoder decodeObjectForKey:property.name];
        if (value == nil) { // 兼容以前的TOMJExtension版本
            value = [decoder decodeObjectForKey:[@"_" stringByAppendingString:property.name]];
        }
        if (value == nil) return;
        [property setValue:value forObject:self];
    }];
}
@end

