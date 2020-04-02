//
//  NSString+TOMJExtension.h
//  TOMJExtensionExample
//
//  Created by TOMJ Lee on 15/6/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOMJExtensionConst.h"

@interface NSString (TOMJExtension)
/**
 *  驼峰转下划线（loveYou -> love_you）
 */
- (NSString *)TOMJ_underlineFromCamel;
/**
 *  下划线转驼峰（love_you -> loveYou）
 */
- (NSString *)TOMJ_camelFromUnderline;
/**
 * 首字母变大写
 */
- (NSString *)TOMJ_firstCharUpper;
/**
 * 首字母变小写
 */
- (NSString *)TOMJ_firstCharLower;

- (BOOL)TOMJ_isPureInt;

- (NSURL *)TOMJ_url;
@end

@interface NSString (TOMJExtensionDeprecated_v_2_5_16)
- (NSString *)underlineFromCamel TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSString *)camelFromUnderline TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSString *)firstCharUpper TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSString *)firstCharLower TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (BOOL)isPureInt TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
- (NSURL *)url TOMJExtensionDeprecated("请在方法名前面加上TOMJ_前缀，使用TOMJ_***");
@end

