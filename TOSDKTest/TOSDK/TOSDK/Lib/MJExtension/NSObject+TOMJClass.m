//
//  NSObject+TOMJClass.m
//  TOMJExtensionExample
//
//  Created by TOMJ Lee on 15/8/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "NSObject+TOMJClass.h"
#import "NSObject+TOMJCoding.h"
#import "NSObject+TOMJKeyValue.h"
#import "TOMJFoundation.h"
#import <objc/runtime.h>

static const char TOMJAllowedPropertyNamesKey = '\0';
static const char TOMJIgnoredPropertyNamesKey = '\0';
static const char TOMJAllowedCodingPropertyNamesKey = '\0';
static const char TOMJIgnoredCodingPropertyNamesKey = '\0';

static NSMutableDictionary *allowedPropertyNamesDict_;
static NSMutableDictionary *ignoredPropertyNamesDict_;
static NSMutableDictionary *allowedCodingPropertyNamesDict_;
static NSMutableDictionary *ignoredCodingPropertyNamesDict_;

@implementation NSObject (TOMJClass)

+ (void)load
{
    allowedPropertyNamesDict_ = [NSMutableDictionary dictionary];
    ignoredPropertyNamesDict_ = [NSMutableDictionary dictionary];
    allowedCodingPropertyNamesDict_ = [NSMutableDictionary dictionary];
    ignoredCodingPropertyNamesDict_ = [NSMutableDictionary dictionary];
}

+ (NSMutableDictionary *)dictForKey:(const void *)key
{
    @synchronized (self) {
        if (key == &TOMJAllowedPropertyNamesKey) return allowedPropertyNamesDict_;
        if (key == &TOMJIgnoredPropertyNamesKey) return ignoredPropertyNamesDict_;
        if (key == &TOMJAllowedCodingPropertyNamesKey) return allowedCodingPropertyNamesDict_;
        if (key == &TOMJIgnoredCodingPropertyNamesKey) return ignoredCodingPropertyNamesDict_;
        return nil;
    }
}

+ (void)TOMJ_enumerateClasses:(TOMJClassesEnumeration)enumeration
{
    // 1.没有block就直接返回
    if (enumeration == nil) return;
    
    // 2.停止遍历的标记
    BOOL stop = NO;
    
    // 3.当前正在遍历的类
    Class c = self;
    
    // 4.开始遍历每一个类
    while (c && !stop) {
        // 4.1.执行操作
        enumeration(c, &stop);
        
        // 4.2.获得父类
        c = class_getSuperclass(c);
        
        if ([TOMJFoundation isClassFromFoundation:c]) break;
    }
}

+ (void)TOMJ_enumerateAllClasses:(TOMJClassesEnumeration)enumeration
{
    // 1.没有block就直接返回
    if (enumeration == nil) return;
    
    // 2.停止遍历的标记
    BOOL stop = NO;
    
    // 3.当前正在遍历的类
    Class c = self;
    
    // 4.开始遍历每一个类
    while (c && !stop) {
        // 4.1.执行操作
        enumeration(c, &stop);
        
        // 4.2.获得父类
        c = class_getSuperclass(c);
    }
}

#pragma mark - 属性黑名单配置
+ (void)TOMJ_setupIgnoredPropertyNames:(TOMJIgnoredPropertyNames)ignoredPropertyNames
{
    [self TOMJ_setupBlockReturnValue:ignoredPropertyNames key:&TOMJIgnoredPropertyNamesKey];
}

+ (NSMutableArray *)TOMJ_totalIgnoredPropertyNames
{
    return [self TOMJ_totalObjectsWithSelector:@selector(TOMJ_ignoredPropertyNames) key:&TOMJIgnoredPropertyNamesKey];
}

#pragma mark - 归档属性黑名单配置
+ (void)TOMJ_setupIgnoredCodingPropertyNames:(TOMJIgnoredCodingPropertyNames)ignoredCodingPropertyNames
{
    [self TOMJ_setupBlockReturnValue:ignoredCodingPropertyNames key:&TOMJIgnoredCodingPropertyNamesKey];
}

+ (NSMutableArray *)TOMJ_totalIgnoredCodingPropertyNames
{
    return [self TOMJ_totalObjectsWithSelector:@selector(TOMJ_ignoredCodingPropertyNames) key:&TOMJIgnoredCodingPropertyNamesKey];
}

#pragma mark - 属性白名单配置
+ (void)TOMJ_setupAllowedPropertyNames:(TOMJAllowedPropertyNames)allowedPropertyNames;
{
    [self TOMJ_setupBlockReturnValue:allowedPropertyNames key:&TOMJAllowedPropertyNamesKey];
}

+ (NSMutableArray *)TOMJ_totalAllowedPropertyNames
{
    return [self TOMJ_totalObjectsWithSelector:@selector(TOMJ_allowedPropertyNames) key:&TOMJAllowedPropertyNamesKey];
}

#pragma mark - 归档属性白名单配置
+ (void)TOMJ_setupAllowedCodingPropertyNames:(TOMJAllowedCodingPropertyNames)allowedCodingPropertyNames
{
    [self TOMJ_setupBlockReturnValue:allowedCodingPropertyNames key:&TOMJAllowedCodingPropertyNamesKey];
}

+ (NSMutableArray *)TOMJ_totalAllowedCodingPropertyNames
{
    return [self TOMJ_totalObjectsWithSelector:@selector(TOMJ_allowedCodingPropertyNames) key:&TOMJAllowedCodingPropertyNamesKey];
}
#pragma mark - block和方法处理:存储block的返回值
+ (void)TOMJ_setupBlockReturnValue:(id (^)())block key:(const char *)key
{
    if (block) {
        objc_setAssociatedObject(self, key, block(), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    // 清空数据
    [[self dictForKey:key] removeAllObjects];
}

+ (NSMutableArray *)TOMJ_totalObjectsWithSelector:(SEL)selector key:(const char *)key
{
    NSMutableArray *array = [self dictForKey:key][NSStringFromClass(self)];
    if (array) return array;
    
    // 创建、存储
    [self dictForKey:key][NSStringFromClass(self)] = array = [NSMutableArray array];
    
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSArray *subArray = [self performSelector:selector];
#pragma clang diagnostic pop
        if (subArray) {
            [array addObjectsFromArray:subArray];
        }
    }
    
    [self TOMJ_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
        NSArray *subArray = objc_getAssociatedObject(c, key);
        [array addObjectsFromArray:subArray];
    }];
    return array;
}
@end

