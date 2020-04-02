//
//  TORewardHUD.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseHUD.h"

NS_ASSUME_NONNULL_BEGIN
@class TORewardHUD;

@protocol TORewardHUDDelegate <NSObject>

/**
 * 领取成功
 * @param cashBalance 当前现金红包余额
 */
- (void)rewardHUD:(TORewardHUD *)page onXjinJliSuccess:(CGFloat)cashBalance;

/**
 * 领取失败
 * @param msg 失败原因
 */
- (void)rewardHUD:(TORewardHUD *)page onXjinJliFailed:(NSString *)msg;

@end
@interface TORewardHUD : TOBaseHUD
@property (nonatomic, weak) id<TORewardHUDDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
