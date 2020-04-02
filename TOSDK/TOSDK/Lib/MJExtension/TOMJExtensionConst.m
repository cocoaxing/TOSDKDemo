#ifndef __TOMJExtensionConst__M__
#define __TOMJExtensionConst__M__

#import <Foundation/Foundation.h>

/**
 *  成员变量类型（属性类型）
 */
NSString *const TOMJPropertyTypeInt = @"i";
NSString *const TOMJPropertyTypeShort = @"s";
NSString *const TOMJPropertyTypeFloat = @"f";
NSString *const TOMJPropertyTypeDouble = @"d";
NSString *const TOMJPropertyTypeLong = @"l";
NSString *const TOMJPropertyTypeLongLong = @"q";
NSString *const TOMJPropertyTypeChar = @"c";
NSString *const TOMJPropertyTypeBOOL1 = @"c";
NSString *const TOMJPropertyTypeBOOL2 = @"b";
NSString *const TOMJPropertyTypePointer = @"*";

NSString *const TOMJPropertyTypeIvar = @"^{objc_ivar=}";
NSString *const TOMJPropertyTypeMethod = @"^{objc_method=}";
NSString *const TOMJPropertyTypeBlock = @"@?";
NSString *const TOMJPropertyTypeClass = @"#";
NSString *const TOMJPropertyTypeSEL = @":";
NSString *const TOMJPropertyTypeId = @"@";

#endif

