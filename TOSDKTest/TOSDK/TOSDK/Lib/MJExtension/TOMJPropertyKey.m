//
//  TOMJPropertyKey.m
//  TOMJExtensionExample
//
//  Created by TOMJ Lee on 15/8/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "TOMJPropertyKey.h"

@implementation TOMJPropertyKey

- (id)valueInObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]] && self.type == TOMJPropertyKeyTypeDictionary) {
        return object[self.name];
    } else if ([object isKindOfClass:[NSArray class]] && self.type == TOMJPropertyKeyTypeArray) {
        NSArray *array = object;
        NSUInteger index = self.name.intValue;
        if (index < array.count) return array[index];
        return nil;
    }
    return nil;
}
@end

