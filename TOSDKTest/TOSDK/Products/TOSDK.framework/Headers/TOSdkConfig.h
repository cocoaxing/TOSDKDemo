//
//  TOSdkConfig.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/28.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSdkConfig : NSObject
/**
 *  AppKey
 */
@property (nonatomic, copy) NSString *appkey;

/**
 *  是否打开 log 日志，默认 false
 */
@property (nonatomic, assign) BOOL logEnable;

/**
 *  是否使用测试服，默认 false
 */
@property (nonatomic, assign) BOOL useTestServer;
@end

NS_ASSUME_NONNULL_END
