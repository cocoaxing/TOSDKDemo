//
//  ToSdkManager.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/14.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TOSdkConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToSdkManager : NSObject

/**
 *  初始化接口
 *
 *  @param config 初始化参数
 */
+ (void)initSdkWithConfig:(TOSdkConfig *)config;

/**
 *  微信登陆回调 旧版
 */
+ (BOOL)handleOpenURL:(NSURL *)url;

/**
 *  微信登陆回调 新版
 */
+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity;
@end

NS_ASSUME_NONNULL_END
