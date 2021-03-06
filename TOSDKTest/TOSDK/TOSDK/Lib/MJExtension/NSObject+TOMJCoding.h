//
//  NSObject+TOMJCoding.h
//  TOMJExtension
//
//  Created by TOMJ on 14-1-15.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOMJExtensionConst.h"

/**
 *  Codeing协议
 */
@protocol TOMJCoding <NSObject>
@optional
/**
 *  这个数组中的属性名才会进行归档
 */
+ (NSArray *)TOMJ_allowedCodingPropertyNames;
/**
 *  这个数组中的属性名将会被忽略：不进行归档
 */
+ (NSArray *)TOMJ_ignoredCodingPropertyNames;
@end

@interface NSObject (TOMJCoding) <TOMJCoding>
/**
 *  解码（从文件中解析对象）
 */
- (void)TOMJ_decode:(NSCoder *)decoder;
/**
 *  编码（将对象写入文件中）
 */
- (void)TOMJ_encode:(NSCoder *)encoder;
@end

/**
 归档的实现
 */
#define TOMJCodingImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self TOMJ_decode:decoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self TOMJ_encode:encoder]; \
}

#define TOMJExtensionCodingImplementation TOMJCodingImplementation

