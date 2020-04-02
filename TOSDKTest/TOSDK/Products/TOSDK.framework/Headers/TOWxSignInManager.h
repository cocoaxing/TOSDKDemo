//
//  TOWxSignInManager.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/9.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOUserInfo.h"
NS_ASSUME_NONNULL_BEGIN
@protocol TOWxSignInDelegate <NSObject>
/**
 * wx sign in success
 * @param userInfo 个人信息
 */
- (void)onWxSignInSuccess:(TOUserInfo *)userInfo;

/**
 * wx sign in fail
 * @param msg 失败原因
 */
- (void)onWxSignInFailed:(NSString *)msg;

@end

@protocol TOUserInfoDelegate <NSObject>
/**
 * 获取成功
 * @param userInfo 个人信息
 */
- (void)onGetUserInfoSuccess:(TOUserInfo *)userInfo;

/**
 * 获取失败
 * @param msg 失败原因
 */
- (void)onGetUserInfoFailed:(NSString *)msg;

@end

@interface TOWxSignInManager : NSObject
+ (instancetype)sharedInstance;
/**
 *  微信登陆接口
 *  @param delegate 回调
 */
- (void)wxSignInWithDelegate:(id<TOWxSignInDelegate>)delegate;
/**
 * 获取用户信息
 * @param delegate 回调
 */
- (void)getToUserInfo:(id<TOUserInfoDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
