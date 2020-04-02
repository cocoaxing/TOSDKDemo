//
//  TOTxManager.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/28.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOTiXiInfo.h"
NS_ASSUME_NONNULL_BEGIN
@protocol TOTxManagerDelegate <NSObject>
/**
 * 提现申请成功
 * @param txXj 本次提现金额
 * @param consumedJinb 本次提现消费的金币
 */
- (void)onTxApplySuccess:(NSInteger)txXj
                 consumedJinb:(NSInteger)consumedJinb;

/**
 * 提现申请失败
 * @param msg 失败原因
 */
- (void)onTxApplyFailed:(NSString *)msg;

@end

@protocol TOXjinJliDelegate <NSObject>
/**
 * 领取成功
 * @param cashBalance 当前现金红包余额
 */
- (void)onXjinJliSuccess:(CGFloat)cashBalance;

/**
 * 领取失败
 * @param msg 失败原因
 */
- (void)onXjinJliFailed:(NSString *)msg;

@end

@protocol TOJiBinReDelegate <NSObject>
/**
 * 领取成功
 * @param coJbinsBalance 当前金币余额
 */
- (void)onJiBinReSuccess:(NSInteger)coJbinsBalance;

/**
 * 领取失败
 * @param msg 失败原因
 */
- (void)onJiBinReFailed:(NSString *)msg;

@end

@protocol TOCoJbinsBalanceDelegate <NSObject>
/**
 * 领取成功
 * @param coJbinsBalance 当前金币余额
 */
- (void)onCoJbinsBalancedSuccess:(NSInteger)coJbinsBalance;

/**
 * 领取失败
 * @param msg 失败原因
 */
- (void)onCoJbinsBalanceFailed:(NSString *)msg;

@end

@protocol TOCheckInDelegate <NSObject>
/**
 * 领取成功
 * @param coJbinsBalance 当前金币余额
 */
- (void)onCheckInSuccessWithCheckInDays:(NSInteger)continuousCheckInDays coJbinsBalance:(NSInteger)coJbinsBalance;

/**
 * 领取失败
 * @param msg 失败原因
 */
- (void)onCheckInFailed:(NSString *)msg;

@end

@protocol TOTiXiInfoDelegate <NSObject>
/**
 * 获取成功
 * @param info 提现信息
 */
- (void)onGetTiXiInfoSuccess:(ToTiXiInfo *)info;

/**
 * 获取失败
 * @param msg 失败原因
 */
- (void)onGetTiXiInfoFailed:(NSString *)msg;
@end

@interface TOTxManager : NSObject

@property (nonatomic, weak) id<TOXjinJliDelegate> cashRewardDelegate;

+ (instancetype)sharedInstance;

/**
 *  展示提现页
 *  @param delegate 提现回调
 */
- (void)showTxPageWithDeleagte:(id<TOTxManagerDelegate>) delegate;

/**
 * 领取现金红包
 * @param delegate 领取回调
 */
- (void)showXjinJliWithDelegate:(id<TOXjinJliDelegate>) delegate;

/**
 * 是否可以领取现金红包
 */
- (BOOL)isCasRewrdAvailable;

/**
 * 展示现金红包余额
 */
- (void)showXiJinBalance;

/**
 * 领取金币
 * @param coJbins 金币数额
 * @param delegate 领取回调接口
 */
- (void)getJiBinRe:(NSInteger)coJbins delegate:(id<TOJiBinReDelegate>) delegate;

/**
 * 获取领取
 * @param delegate 领取回调接口
 */
- (void)getCoJbinsBalanceWithDelegate:(id<TOCoJbinsBalanceDelegate>) delegate;

/**
 * 签到接口
 * @param coJbins 本次签到奖励的金币
 * @param delegate 回调
 */
- (void)doCheckInWithCoJbins:(NSInteger)coJbins delegate:(id<TOCheckInDelegate>)delegate;

/**
 * 获取用户提现信息
 * @param delegate 回调
 */
- (void)getTiXiInfoWithDelegate:(id<TOTiXiInfoDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
