//
//  NSObject+TOMJProperty.h
//  TOMJExtensionExample
//
//  Created by TOMJ Lee on 15/4/17.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOMJExtensionConst.h"

@class TOMJProperty;

/**
 *  遍历成员变量用的block
 *
 *  @param property 成员的包装对象
 *  @param stop   YES代表停止遍历，NO代表继续遍历
 */
typedef void (^TOMJPropertiesEnumeration)(TOMJProperty *property, BOOL *stop);

/** 将属性名换为其他key去字典中取值 */
typedef NSDictionary * (^TOMJReplacedKeyFromPropertyName)();
typedef id (^TOMJReplacedKeyFromPropertyName121)(NSString *propertyName);
/** 数组中需要转换的模型类 */
typedef NSDictionary * (^TOMJObjectClassInArray)();
/** 用于过滤字典中的值 */
typedef id (^TOMJNewValueFromOldValue)(id object, id oldValue, TOMJProperty *property);

/**
 * 成员属性相关的扩展
 */
@interface NSObject (TOMJProperty)
#pragma mark - 遍历
/**
 *  遍历所有的成员
 */
+ (void)TOMJ_enumerateProperties:(TOMJPropertiesEnumeration)enumeration;

#pragma mark - 新值配置
/**
 *  用于过滤字典中的值
 *
 *  @param newValueFormOldValue 用于过滤字典中的值
 */
+ (void)TOMJ_setupNewValueFromOldValue:(TOMJNewValueFromOldValue)newValueFormOldValue;
+ (id)TOMJ_getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained TOMJProperty *)property;

#pragma mark - key配置
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @param replacedKeyFromPropertyName 将属性名换为其他key去字典中取值
 */
+ (void)TOMJ_setupReplacedKeyFromPropertyName:(TOMJReplacedKeyFromPropertyName)replacedKeyFromPropertyName;
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @param replacedKeyFromPropertyName121 将属性名换为其他key去字典中取值
 */
+ (void)TOMJ_setupReplacedKeyFromPropertyName121:(TOMJReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121;

#pragma mark - array model class配置
/**
 *  数组中需要转换的模型类
 *
 *  @param objectClassInArray          数组中需要转换的模型类
 */
+ (void)TOMJ_setupObjectClassInArray:(TOMJObjectClassInArray)objectClassInArray;
@end

@interface NSObject (TOMJPropertyDeprecated_v_2_5_16)
+ (void)enumerateProperties:(TOMJPropertiesEnumeration)enumeration TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (void)setupNewValueFromOldValue:(TOMJNewValueFromOldValue)newValueFormOldValue TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (id)getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained TOMJProperty *)property TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (void)setupReplacedKeyFromPropertyName:(TOMJReplacedKeyFromPropertyName)replacedKeyFromPropertyName TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (void)setupReplacedKeyFromPropertyName121:(TOMJReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121 TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (void)setupObjectClassInArray:(TOMJObjectClassInArray)objectClassInArray TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
@end

