//
//  TOSDKUtil.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOSDKUtil.h"

#import "NSString+Extension.h"
#import <Security/Security.h>
#import "SAMKeychain.h"
#import "TOUserDefault.h"
@implementation TOSDKUtil
+ (NSString *)getRandomStringWithNum:(NSInteger)num{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
            string = [string uppercaseString];
        }
    }
    return string;
}
+ (NSString *)getCurrentTime{
    
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate  date] timeIntervalSince1970]];
    
    return timestamp;
}

+ (NSString *)GMTdateString:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Etc/GMT"];//东八区时间
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

+ (NSDate *)dateWithMSTimestamp:(NSInteger)timestamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)(timestamp / 1000)];
    return date;
}

+ (NSString *)stringWithMSTimestamp:(NSInteger)timestamp {
    NSDate *date = [TOSDKUtil dateWithMSTimestamp:timestamp];
    NSString *dateStr = [TOSDKUtil GMTdateString:date];
    return dateStr;
}

/** 对字典(Key-Value)排序
  @param dict 要排序的字典
  */
+ (NSString *)sortedDictionary:(NSMutableDictionary *)dict {
    NSMutableString *contentString =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    //拼接 把排序后的字典拼接成string
    for (NSString *keyStr in sortedArray) {
        if (![[dict objectForKey:keyStr] isEqualToString:@""] && ![[dict objectForKey:keyStr] isEqualToString:@"key"] ) {
            [contentString appendFormat:@"%@=%@&", keyStr, [dict objectForKey:keyStr]];
        }
    }
    contentString = (NSMutableString *)[contentString substringToIndex:contentString.length-1];
    
    return contentString;
}

//对排序后的参数进行加密
+ (NSString *)signMd5:(NSString *)sortString {
    NSString *key = TO_SecretKey_Debug;
    if (TO_RELEASE_FLAG) {
        key = TO_SecretKey_Release;
    }
    if ([[TOUserDefault sharedTOUserDefault] getUseServer]) {
        key = TO_SecretKey_Debug;
    } else {
        key = TO_SecretKey_Release;
    }
    sortString  = [NSString stringWithFormat:@"%@&secretKey=%@", sortString, key];
    NSLog(@"TOSDK_LOG: TOSDK排序后的字符串%@", sortString);
    NSString *mdStr = [sortString md5];
    mdStr = [mdStr uppercaseString];
    return mdStr;
}

//获取手机当前显示的ViewController
+ (UIViewController*)currentViewController{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}


//获取一个UUID
+ (NSString*)uuid {
    
    NSString * uuid = [TOSDKUtil getContentFromKeyChain:TO_UUID_KEY service:TO_UUID_SERVICE];
    if (uuid.length > 0) {
        return uuid;
    } else {
        CFUUIDRef uuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, uuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(uuid);
        CFRelease(uuidString);
        [TOSDKUtil saveContentToKeyChain:result forKey:TO_UUID_KEY service:TO_UUID_SERVICE];
        return result;
    }
    
}

+ (BOOL) saveContentToKeyChain: (NSString *) content
                        forKey: (NSString *) key
                       service: (NSString *) service {
    return [SAMKeychain setPassword:content forService:service account:key];
}

// 传2个参数，service：服务名，key：键名
// 一般情况1个服务下，会包含多个内容
+ (NSString *) getContentFromKeyChain:(NSString *) key
                              service: (NSString *) service {
    return [SAMKeychain passwordForService:service account:key];
}

+ (NSString *)getIUUIDMD5 {
    
    NSString * uuid = [TOSDKUtil getContentFromKeyChain:TO_UUID_KEY service:TO_UUID_SERVICE];
    if (uuid.length > 0) {
        return uuid;
    } else {
        NSString *uuid = [TOSDKUtil uuid];
        NSString *uuidMd5 = [uuid md5];
        [TOSDKUtil saveContentToKeyChain:uuidMd5 forKey:TO_UUID_KEY service:TO_UUID_SERVICE];
        return uuidMd5;
    }
}

+ (void)imageWithName:(NSString *)name callback:(SDKUtilCallback)callback {
    NSArray *arr = [[TOUserDefault sharedTOUserDefault] getImgs];
    for (NSString *img in arr) {
        if ([img containsString:name]) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:img]];
                UIImage *image = [[UIImage alloc] initWithData:data];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (image) {
                        callback(image);
                    } else {
                        callback(nil);
                    }
                });
            });
        }
    }
}

@end
