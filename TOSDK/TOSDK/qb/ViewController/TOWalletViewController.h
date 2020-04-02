//
//  TOWalletViewController.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/14.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TOWalletViewControllerDelegate <NSObject>
/**
 * 提现申请成功
 * @param txXj 本次提现金额
 * @param consumedJinb 本次提现消费的金币
 */
- (void)txViewControllerTxApplySuccess:(NSInteger)txXj
                              consumedJinb:(NSInteger)consumedJinb;

/**
 * 提现申请失败
 * @param msg 失败原因
 */
- (void)txViewControllerTxApplyFailed:(NSString *)msg;

@end

@interface TOWalletViewController : UIViewController
@property (nonatomic, weak) id<TOWalletViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
