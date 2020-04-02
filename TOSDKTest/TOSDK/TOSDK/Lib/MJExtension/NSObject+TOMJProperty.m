//
//  NSObject+TOMJProperty.m
//  TOMJExtensionExample
//
//  Created by TOMJ Lee on 15/4/17.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "NSObject+TOMJProperty.h"
#import "NSObject+TOMJKeyValue.h"
#import "NSObject+TOMJCoding.h"
#import "NSObject+TOMJClass.h"
#import "TOMJProperty.h"
#import "TOMJFoundation.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

static const char TOMJReplacedKeyFromPropertyNameKey = '\0';
static const char TOMJReplacedKeyFromPropertyName121Key = '\0';
static const char TOMJNewValueFromOldValueKey = '\0';
static const char TOMJObjectClassInArrayKey = '\0';

static const char TOMJCachedPropertiesKey = '\0';

@implementation NSObject (Property)

static NSMutableDictionary *replacedKeyFromPropertyNameDict_;
static NSMutableDictionary *replacedKeyFromPropertyName121Dict_;
static NSMutableDictionary *newValueFromOldValueDict_;
static NSMutableDictionary *objectClassInArrayDict_;
static NSMutableDictionary *cachedPropertiesDict_;

+ (void)load
{
    replacedKeyFromPropertyNameDict_ = [NSMutableDictionary dictionary];
    replacedKeyFromPropertyName121Dict_ = [NSMutableDictionary dictionary];
    newValueFromOldValueDict_ = [NSMutableDictionary dictionary];
    objectClassInArrayDict_ = [NSMutableDictionary dictionary];
    cachedPropertiesDict_ = [NSMutableDictionary dictionary];
}

+ (NSMutableDictionary *)dictForKey:(const void *)key
{
    @synchronized (self) {
        if (key == &TOMJReplacedKeyFromPropertyNameKey) return replacedKeyFromPropertyNameDict_;
        if (key == &TOMJReplacedKeyFromPropertyName121Key) return replacedKeyFromPropertyName121Dict_;
        if (key == &TOMJNewValueFromOldValueKey) return newValueFromOldValueDict_;
        if (key == &TOMJObjectClassInArrayKey) return objectClassInArrayDict_;
        if (key == &TOMJCachedPropertiesKey) return cachedPropertiesDict_;
        return nil;
    }
}

#pragma mark - --私有方法--
+ (id)propertyKey:(NSString *)propertyName
{
    TOMJExtensionAssertParamNotNil2(propertyName, nil);
    
    __block id key = nil;
    // 查看有没有需要替换的key
    if ([self respondsToSelector:@selector(TOMJ_replacedKeyFromPropertyName121:)]) {
        key = [self TOMJ_replacedKeyFromPropertyName121:propertyName];
    }
    // 兼容旧版本
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName121:)]) {
        key = [self performSelector:@selector(replacedKeyFromPropertyName121) withObject:propertyName];
    }
    
    // 调用block
    if (!key) {
        [self TOMJ_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
            TOMJReplacedKeyFromPropertyName121 block = objc_getAssociatedObject(c, &TOMJReplacedKeyFromPropertyName121Key);
            if (block) {
                key = block(propertyName);
            }
            if (key) *stop = YES;
        }];
    }
    
    // 查看有没有需要替换的key
    if ((!key || [key isEqual:propertyName]) && [self respondsToSelector:@selector(TOMJ_replacedKeyFromPropertyName)]) {
        key = [self TOMJ_replacedKeyFromPropertyName][propertyName];
    }
    // 兼容旧版本
    if ((!key || [key isEqual:propertyName]) && [self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = [self performSelector:@selector(replacedKeyFromPropertyName)][propertyName];
    }
    
    if (!key || [key isEqual:propertyName]) {
        [self TOMJ_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
            NSDictionary *dict = objc_getAssociatedObject(c, &TOMJReplacedKeyFromPropertyNameKey);
            if (dict) {
                key = dict[propertyName];
            }
            if (key && ![key isEqual:propertyName]) *stop = YES;
        }];
    }
    
    // 2.用属性名作为key
    if (!key) key = propertyName;
    
    return key;
}

+ (Class)propertyObjectClassInArray:(NSString *)propertyName
{
    __block id clazz = nil;
    if ([self respondsToSelector:@selector(TOMJ_objectClassInArray)]) {
        clazz = [self TOMJ_objectClassInArray][propertyName];
    }
    // 兼容旧版本
    if ([self respondsToSelector:@selector(objectClassInArray)]) {
        clazz = [self performSelector:@selector(objectClassInArray)][propertyName];
    }
    
    if (!clazz) {
        [self TOMJ_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
            NSDictionary *dict = objc_getAssociatedObject(c, &TOMJObjectClassInArrayKey);
            if (dict) {
                clazz = dict[propertyName];
            }
            if (clazz) *stop = YES;
        }];
    }
    
    // 如果是NSString类型
    if ([clazz isKindOfClass:[NSString class]]) {
        clazz = NSClassFromString(clazz);
    }
    return clazz;
}

#pragma mark - --公共方法--
+ (void)TOMJ_enumerateProperties:(TOMJPropertiesEnumeration)enumeration
{
    // 获得成员变量
    NSArray *cachedProperties = [self properties];
    
    // 遍历成员变量
    BOOL stop = NO;
    for (TOMJProperty *property in cachedProperties) {
        enumeration(property, &stop);
        if (stop) break;
    }
}

#pragma mark - 公共方法
+ (NSMutableArray *)properties
{
    NSMutableArray *cachedProperties = [self dictForKey:&TOMJCachedPropertiesKey][NSStringFromClass(self)];
    
    if (cachedProperties == nil) {
        cachedProperties = [NSMutableArray array];
        
        [self TOMJ_enumerateClasses:^(__unsafe_unretained Class c, BOOL *stop) {
            // 1.获得所有的成员变量
            unsigned int outCount = 0;
            objc_property_t *properties = class_copyPropertyList(c, &outCount);
            
            // 2.遍历每一个成员变量
            for (unsigned int i = 0; i<outCount; i++) {
                TOMJProperty *property = [TOMJProperty cachedPropertyWithProperty:properties[i]];
                // 过滤掉Foundation框架类里面的属性
                if ([TOMJFoundation isClassFromFoundation:property.srcClass]) continue;
                property.srcClass = c;
                [property setOriginKey:[self propertyKey:property.name] forClass:self];
                [property setObjectClassInArray:[self propertyObjectClassInArray:property.name] forClass:self];
                [cachedProperties addObject:property];
            }
            
            // 3.释放内存
            free(properties);
        }];
        
        [self dictForKey:&TOMJCachedPropertiesKey][NSStringFromClass(self)] = cachedProperties;
    }
    
    return cachedProperties;
}

#pragma mark - 新值配置
+ (void)TOMJ_setupNewValueFromOldValue:(TOMJNewValueFromOldValue)newValueFormOldValue
{
    objc_setAssociatedObject(self, &TOMJNewValueFromOldValueKey, newValueFormOldValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (id)TOMJ_getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(TOMJProperty *__unsafe_unretained)property{
    // 如果有实现方法
    if ([object respondsToSelector:@selector(TOMJ_newValueFromOldValue:property:)]) {
        return [object TOMJ_newValueFromOldValue:oldValue property:property];
    }
    // 兼容旧版本
    if ([self respondsToSelector:@selector(newValueFromOldValue:property:)]) {
        return [self performSelector:@selector(newValueFromOldValue:property:)  withObject:oldValue  withObject:property];
    }
    
    // 查看静态设置
    __block id newValue = oldValue;
    [self TOMJ_enumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
        TOMJNewValueFromOldValue block = objc_getAssociatedObject(c, &TOMJNewValueFromOldValueKey);
        if (block) {
            newValue = block(object, oldValue, property);
            *stop = YES;
        }
    }];
    return newValue;
}

#pragma mark - array model class配置
+ (void)TOMJ_setupObjectClassInArray:(TOMJObjectClassInArray)objectClassInArray
{
    [self TOMJ_setupBlockReturnValue:objectClassInArray key:&TOMJObjectClassInArrayKey];
    
    [[self dictForKey:&TOMJCachedPropertiesKey] removeAllObjects];
}

#pragma mark - key配置
+ (void)TOMJ_setupReplacedKeyFromPropertyName:(TOMJReplacedKeyFromPropertyName)replacedKeyFromPropertyName
{
    [self TOMJ_setupBlockReturnValue:replacedKeyFromPropertyName key:&TOMJReplacedKeyFromPropertyNameKey];
    
    [[self dictForKey:&TOMJCachedPropertiesKey] removeAllObjects];
}

+ (void)TOMJ_setupReplacedKeyFromPropertyName121:(TOMJReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121
{
    objc_setAssociatedObject(self, &TOMJReplacedKeyFromPropertyName121Key, replacedKeyFromPropertyName121, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[self dictForKey:&TOMJCachedPropertiesKey] removeAllObjects];
}
@end

@implementation NSObject (TOMJPropertyDeprecated_v_2_5_16)
+ (void)enumerateProperties:(TOMJPropertiesEnumeration)enumeration
{
    [self TOMJ_enumerateProperties:enumeration];
}

+ (void)setupNewValueFromOldValue:(TOMJNewValueFromOldValue)newValueFormOldValue
{
    [self TOMJ_setupNewValueFromOldValue:newValueFormOldValue];
}

+ (id)getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained TOMJProperty *)property
{
    return [self TOMJ_getNewValueFromObject:object oldValue:oldValue property:property];
}

+ (void)setupReplacedKeyFromPropertyName:(TOMJReplacedKeyFromPropertyName)replacedKeyFromPropertyName
{
    [self TOMJ_setupReplacedKeyFromPropertyName:replacedKeyFromPropertyName];
}

+ (void)setupReplacedKeyFromPropertyName121:(TOMJReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121
{
    [self TOMJ_setupReplacedKeyFromPropertyName121:replacedKeyFromPropertyName121];
}

+ (void)setupObjectClassInArray:(TOMJObjectClassInArray)objectClassInArray
{
    [self TOMJ_setupObjectClassInArray:objectClassInArray];
}
@end

#pragma clang diagnostic pop
