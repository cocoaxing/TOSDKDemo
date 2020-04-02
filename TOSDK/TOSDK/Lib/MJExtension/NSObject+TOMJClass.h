//
//  NSObject+TOMJClass.h
//  TOMJExtensionExample
//
//  Created by TOMJ Lee on 15/8/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  遍历所有类的block（父类）
 */
typedef void (^TOMJClassesEnumeration)(Class c, BOOL *stop);

/** 这个数组中的属性名才会进行字典和模型的转换 */
typedef NSArray * (^TOMJAllowedPropertyNames)();
/** 这个数组中的属性名才会进行归档 */
typedef NSArray * (^TOMJAllowedCodingPropertyNames)();

/** 这个数组中的属性名将会被忽略：不进行字典和模型的转换 */
typedef NSArray * (^TOMJIgnoredPropertyNames)();
/** 这个数组中的属性名将会被忽略：不进行归档 */
typedef NSArray * (^TOMJIgnoredCodingPropertyNames)();

/**
 * 类相关的扩展
 */
@interface NSObject (TOMJClass)
/**
 *  遍历所有的类
 */
+ (void)TOMJ_enumerateClasses:(TOMJClassesEnumeration)enumeration;
+ (void)TOMJ_enumerateAllClasses:(TOMJClassesEnumeration)enumeration;

#pragma mark - 属性白名单配置
/**
 *  这个数组中的属性名才会进行字典和模型的转换
 *
 *  @param allowedPropertyNames          这个数组中的属性名才会进行字典和模型的转换
 */
+ (void)TOMJ_setupAllowedPropertyNames:(TOMJAllowedPropertyNames)allowedPropertyNames;

/**
 *  这个数组中的属性名才会进行字典和模型的转换
 */
+ (NSMutableArray *)TOMJ_totalAllowedPropertyNames;

#pragma mark - 属性黑名单配置
/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 *
 *  @param ignoredPropertyNames          这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (void)TOMJ_setupIgnoredPropertyNames:(TOMJIgnoredPropertyNames)ignoredPropertyNames;

/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (NSMutableArray *)TOMJ_totalIgnoredPropertyNames;

#pragma mark - 归档属性白名单配置
/**
 *  这个数组中的属性名才会进行归档
 *
 *  @param allowedCodingPropertyNames          这个数组中的属性名才会进行归档
 */
+ (void)TOMJ_setupAllowedCodingPropertyNames:(TOMJAllowedCodingPropertyNames)allowedCodingPropertyNames;

/**
 *  这个数组中的属性名才会进行字典和模型的转换
 */
+ (NSMutableArray *)TOMJ_totalAllowedCodingPropertyNames;

#pragma mark - 归档属性黑名单配置
/**
 *  这个数组中的属性名将会被忽略：不进行归档
 *
 *  @param ignoredCodingPropertyNames          这个数组中的属性名将会被忽略：不进行归档
 */
+ (void)TOMJ_setupIgnoredCodingPropertyNames:(TOMJIgnoredCodingPropertyNames)ignoredCodingPropertyNames;

/**
 *  这个数组中的属性名将会被忽略：不进行归档
 */
+ (NSMutableArray *)TOMJ_totalIgnoredCodingPropertyNames;

#pragma mark - 内部使用
+ (void)TOMJ_setupBlockReturnValue:(id (^)())block key:(const char *)key;
@end

