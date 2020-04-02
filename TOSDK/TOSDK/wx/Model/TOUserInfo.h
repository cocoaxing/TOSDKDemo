//
//  TOUserInfo.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/10.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOUserInfo : NSObject
/**
 * 获取用户Id
 */
@property (nonatomic, copy) NSString *userId;
/**
 * 是否绑定了微信
 */
@property (nonatomic, assign) BOOL bindingWx;
/**
 * 获取用户名，微信绑定后才有值
 */
@property (nonatomic, copy) NSString *userName;
/**
 * 获取用户头像，微信绑定后才有值
 */
@property (nonatomic, copy) NSString *userImagUrl;
/**
 * 是否已经获取过新手现金红包
 */
@property (nonatomic, assign) BOOL hasGotNewUserXjjl;
/**
 * 今天是否已签到
 */
@property (nonatomic, assign) BOOL isTodayCheckIn;
/**
 * 签到天数
 */
@property (nonatomic, assign) NSInteger chekckInDays;
/**
 * 是否完成新手提现
 */
@property (nonatomic, assign) BOOL isNewUserTx;
@end

NS_ASSUME_NONNULL_END
