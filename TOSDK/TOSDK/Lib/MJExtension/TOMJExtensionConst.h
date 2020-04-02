
#ifndef __TOMJExtensionConst__H__
#define __TOMJExtensionConst__H__

#import <Foundation/Foundation.h>

// 过期
#define TOMJExtensionDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 构建错误
#define TOMJExtensionBuildError(clazz, msg) \
NSError *error = [NSError errorWithDomain:msg code:250 userInfo:nil]; \
[clazz setTOMJ_error:error];

// 日志输出
#ifdef DEBUG
#define TOMJExtensionLog(...) NSLog(__VA_ARGS__)
#else
#define TOMJExtensionLog(...)
#endif

/**
 * 断言
 * @param condition   条件
 * @param returnValue 返回值
 */
#define TOMJExtensionAssertError(condition, returnValue, clazz, msg) \
[clazz setTOMJ_error:nil]; \
if ((condition) == NO) { \
    TOMJExtensionBuildError(clazz, msg); \
    return returnValue;\
}

#define TOMJExtensionAssert2(condition, returnValue) \
if ((condition) == NO) return returnValue;

/**
 * 断言
 * @param condition   条件
 */
#define TOMJExtensionAssert(condition) TOMJExtensionAssert2(condition, )

/**
 * 断言
 * @param param         参数
 * @param returnValue   返回值
 */
#define TOMJExtensionAssertParamNotNil2(param, returnValue) \
TOMJExtensionAssert2((param) != nil, returnValue)

/**
 * 断言
 * @param param   参数
 */
#define TOMJExtensionAssertParamNotNil(param) TOMJExtensionAssertParamNotNil2(param, )

/**
 * 打印所有的属性
 */
#define TOMJLogAllIvars \
-(NSString *)description \
{ \
    return [self TOMJ_keyValues].description; \
}
#define TOMJExtensionLogAllProperties TOMJLogAllIvars

/**
 *  类型（属性类型）
 */
extern NSString *const TOMJPropertyTypeInt;
extern NSString *const TOMJPropertyTypeShort;
extern NSString *const TOMJPropertyTypeFloat;
extern NSString *const TOMJPropertyTypeDouble;
extern NSString *const TOMJPropertyTypeLong;
extern NSString *const TOMJPropertyTypeLongLong;
extern NSString *const TOMJPropertyTypeChar;
extern NSString *const TOMJPropertyTypeBOOL1;
extern NSString *const TOMJPropertyTypeBOOL2;
extern NSString *const TOMJPropertyTypePointer;

extern NSString *const TOMJPropertyTypeIvar;
extern NSString *const TOMJPropertyTypeMethod;
extern NSString *const TOMJPropertyTypeBlock;
extern NSString *const TOMJPropertyTypeClass;
extern NSString *const TOMJPropertyTypeSEL;
extern NSString *const TOMJPropertyTypeId;

#endif
