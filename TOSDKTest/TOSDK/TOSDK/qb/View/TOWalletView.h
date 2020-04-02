//
//  TOWalletView.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/14.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class TOUserRPInfo;
@class TOWalletView;
@class TOTXConfigListDataModel;
@class TORPConfigListData;
@protocol TOWalletViewDelegate <NSObject>
- (void)walletViewClickTx;
- (void)walletViewClickjx;
- (void)walletViewBack:(TOWalletView *)view;
- (void)walletViewDetail:(TOWalletView *)view;
- (void)handleTxWithData:(TOTXConfigListDataModel *)data;
- (void)handleXjWithData:(TORPConfigListData *)data;
- (void)walletViewRule:(TOWalletView *)view;
@end

@interface TOWalletView : UIView
@property (nonatomic, weak) id<TOWalletViewDelegate> delegate;
@property (nonatomic, strong) UIButton *mxBtn;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)refreshTxData:(NSArray *)data;
- (void)refreshxJUserInfoData:(TOUserRPInfo *)leftRp;
- (void)refreshxJConfigInfoData:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
