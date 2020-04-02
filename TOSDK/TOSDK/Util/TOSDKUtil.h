//
//  TOSDKUtil.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SDKUtilCallback)(id obj);
@interface TOSDKUtil : NSObject
/**  生成num位随机字母和数字的随机数 */
+ (NSString *)getRandomStringWithNum:(NSInteger)num;
//获取当前时间戳
+ (NSString *)getCurrentTime;
+ (NSString *)stringWithMSTimestamp:(NSInteger)timestamp;
+ (NSString *)sortedDictionary:(NSMutableDictionary *)dict;
+ (NSString *)signMd5:(NSString *)sortString;
+ (UIViewController*)currentViewController;
+ (NSString*)uuid;
+ (NSString *)getIUUIDMD5;
+ (void)imageWithName:(NSString *)name callback:(SDKUtilCallback)callback;
@end

NS_ASSUME_NONNULL_END
