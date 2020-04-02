//
//  TOMJPropertyType.m
//  TOMJExtension
//
//  Created by TOMJ on 14-1-15.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "TOMJPropertyType.h"
#import "TOMJExtension.h"
#import "TOMJFoundation.h"
#import "TOMJExtensionConst.h"

@implementation TOMJPropertyType

static NSMutableDictionary *types_;
+ (void)initialize
{
    types_ = [NSMutableDictionary dictionary];
}

+ (instancetype)cachedTypeWithCode:(NSString *)code
{
    TOMJExtensionAssertParamNotNil2(code, nil);
    @synchronized (self) {
        TOMJPropertyType *type = types_[code];
        if (type == nil) {
            type = [[self alloc] init];
            type.code = code;
            types_[code] = type;
        }
        return type;
    }
}

#pragma mark - 公共方法
- (void)setCode:(NSString *)code
{
    _code = code;
    
    TOMJExtensionAssertParamNotNil(code);
    
    if ([code isEqualToString:TOMJPropertyTypeId]) {
        _idType = YES;
    } else if (code.length == 0) {
        _KVCDisabled = YES;
    } else if (code.length > 3 && [code hasPrefix:@"@\""]) {
        // 去掉@"和"，截取中间的类型名称
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
        _fromFoundation = [TOMJFoundation isClassFromFoundation:_typeClass];
        _numberType = [_typeClass isSubclassOfClass:[NSNumber class]];
        
    } else if ([code isEqualToString:TOMJPropertyTypeSEL] ||
               [code isEqualToString:TOMJPropertyTypeIvar] ||
               [code isEqualToString:TOMJPropertyTypeMethod]) {
        _KVCDisabled = YES;
    }
    
    // 是否为数字类型
    NSString *lowerCode = _code.lowercaseString;
    NSArray *numberTypes = @[TOMJPropertyTypeInt, TOMJPropertyTypeShort, TOMJPropertyTypeBOOL1, TOMJPropertyTypeBOOL2, TOMJPropertyTypeFloat, TOMJPropertyTypeDouble, TOMJPropertyTypeLong, TOMJPropertyTypeLongLong, TOMJPropertyTypeChar];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        
        if ([lowerCode isEqualToString:TOMJPropertyTypeBOOL1]
            || [lowerCode isEqualToString:TOMJPropertyTypeBOOL2]) {
            _boolType = YES;
        }
    }
}
@end

