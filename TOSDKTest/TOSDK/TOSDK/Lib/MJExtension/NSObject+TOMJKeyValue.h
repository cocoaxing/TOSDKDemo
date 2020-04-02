//
//  NSObject+TOMJKeyValue.h
//  TOMJExtension
//
//  Created by TOMJ on 13-8-24.
//  Copyright (c) 2013年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOMJExtensionConst.h"
#import <CoreData/CoreData.h>
#import "TOMJProperty.h"

/**
 *  KeyValue协议
 */
@protocol TOMJKeyValue <NSObject>
@optional
/**
 *  只有这个数组中的属性名才允许进行字典和模型的转换
 */
+ (NSArray *)TOMJ_allowedPropertyNames;

/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (NSArray *)TOMJ_ignoredPropertyNames;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)TOMJ_replacedKeyFromPropertyName;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 从字典中取值用的key
 */
+ (id)TOMJ_replacedKeyFromPropertyName121:(NSString *)propertyName;

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)TOMJ_objectClassInArray;

/**
 *  旧值换新值，用于过滤字典中的值
 *
 *  @param oldValue 旧值
 *
 *  @return 新值
 */
- (id)TOMJ_newValueFromOldValue:(id)oldValue property:(TOMJProperty *)property;

/**
 *  当字典转模型完毕时调用
 */
- (void)TOMJ_keyValuesDidFinishConvertingToObject;

/**
 *  当模型转字典完毕时调用
 */
- (void)TOMJ_objectDidFinishConvertingToKeyValues;
@end

@interface NSObject (TOMJKeyValue) <TOMJKeyValue>
#pragma mark - 类方法
/**
 * 字典转模型过程中遇到的错误
 */
+ (NSError *)TOMJ_error;

/**
 *  模型转字典时，字典的key是否参考replacedKeyFromPropertyName等方法（父类设置了，子类也会继承下来）
 */
+ (void)TOMJ_referenceReplacedKeyWhenCreatingKeyValues:(BOOL)reference;

#pragma mark - 对象方法
/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 */
- (instancetype)TOMJ_setKeyValues:(id)keyValues;

/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @param context   CoreData上下文
 */
- (instancetype)TOMJ_setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context;

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)TOMJ_keyValues;
- (NSMutableDictionary *)TOMJ_keyValuesWithKeys:(NSArray *)keys;
- (NSMutableDictionary *)TOMJ_keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys;

/**
 *  通过模型数组来创建一个字典数组
 *  @param objectArray 模型数组
 *  @return 字典数组
 */
+ (NSMutableArray *)TOMJ_keyValuesArrayWithObjectArray:(NSArray *)objectArray;
+ (NSMutableArray *)TOMJ_keyValuesArrayWithObjectArray:(NSArray *)objectArray keys:(NSArray *)keys;
+ (NSMutableArray *)TOMJ_keyValuesArrayWithObjectArray:(NSArray *)objectArray ignoredKeys:(NSArray *)ignoredKeys;

#pragma mark - 字典转模型
/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @return 新建的对象
 */
+ (instancetype)TOMJ_objectWithKeyValues:(id)keyValues;

/**
 *  通过字典来创建一个CoreData模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @param context   CoreData上下文
 *  @return 新建的对象
 */
+ (instancetype)TOMJ_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context;

/**
 *  通过plist来创建一个模型
 *  @param filename 文件名(仅限于mainBundle中的文件)
 *  @return 新建的对象
 */
+ (instancetype)TOMJ_objectWithFilename:(NSString *)filename;

/**
 *  通过plist来创建一个模型
 *  @param file 文件全路径
 *  @return 新建的对象
 */
+ (instancetype)TOMJ_objectWithFile:(NSString *)file;

#pragma mark - 字典数组转模型数组
/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @return 模型数组
 */
+ (NSMutableArray *)TOMJ_objectArrayWithKeyValuesArray:(id)keyValuesArray;

/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @param context        CoreData上下文
 *  @return 模型数组
 */
+ (NSMutableArray *)TOMJ_objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context;

/**
 *  通过plist来创建一个模型数组
 *  @param filename 文件名(仅限于mainBundle中的文件)
 *  @return 模型数组
 */
+ (NSMutableArray *)TOMJ_objectArrayWithFilename:(NSString *)filename;

/**
 *  通过plist来创建一个模型数组
 *  @param file 文件全路径
 *  @return 模型数组
 */
+ (NSMutableArray *)TOMJ_objectArrayWithFile:(NSString *)file;

#pragma mark - 转换为JSON
/**
 *  转换为JSON Data
 */
- (NSData *)TOMJ_JSONData;
/**
 *  转换为字典或者数组
 */
- (id)TOMJ_JSONObject;
/**
 *  转换为JSON 字符串
 */
- (NSString *)TOMJ_JSONString;
@end

@interface NSObject (TOMJKeyValueDeprecated_v_2_5_16)
- (instancetype)setKeyValues:(id)keyValue TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (instancetype)setKeyValues:(id)keyValues error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (instancetype)setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (instancetype)setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (void)referenceReplacedKeyWhenCreatingKeyValues:(BOOL)reference TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSMutableDictionary *)keyValues TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSMutableDictionary *)keyValuesWithError:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSMutableDictionary *)keyValuesWithKeys:(NSArray *)keys TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSMutableDictionary *)keyValuesWithKeys:(NSArray *)keys error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSMutableDictionary *)keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSMutableDictionary *)keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray keys:(NSArray *)keys TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray keys:(NSArray *)keys error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray ignoredKeys:(NSArray *)ignoredKeys TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)keyValuesArrayWithObjectArray:(NSArray *)objectArray ignoredKeys:(NSArray *)ignoredKeys error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (instancetype)objectWithKeyValues:(id)keyValues TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (instancetype)objectWithKeyValues:(id)keyValues error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (instancetype)objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (instancetype)objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (instancetype)objectWithFilename:(NSString *)filename TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (instancetype)objectWithFilename:(NSString *)filename error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (instancetype)objectWithFile:(NSString *)file TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (instancetype)objectWithFile:(NSString *)file error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)objectArrayWithFilename:(NSString *)filename TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)objectArrayWithFilename:(NSString *)filename error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)objectArrayWithFile:(NSString *)file TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
+ (NSMutableArray *)objectArrayWithFile:(NSString *)file error:(NSError **)error TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSData *)JSONData TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (id)JSONObject TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSString *)JSONString TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
@end

