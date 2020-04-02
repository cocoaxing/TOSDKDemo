//
//  TONewUserPage.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseHUD.h"

NS_ASSUME_NONNULL_BEGIN

@class TONewUserPage;

@protocol TONewUserPageDelegate <NSObject>

/**
 * 领取成功
 * @param cashBalance 当前现金红包余额
 */
- (void)userPage:(TONewUserPage *)page onXjinJliSuccess:(CGFloat)cashBalance;

/**
 * 领取失败
 * @param msg 失败原因
 */
- (void)userPage:(TONewUserPage *)page onXjinJliFailed:(NSString *)msg;

@end
@interface TONewUserPage : TOBaseHUD
@property (nonatomic, weak) id<TONewUserPageDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
