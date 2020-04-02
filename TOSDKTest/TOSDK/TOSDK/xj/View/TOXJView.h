//
//  TOXJView.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/17.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TOXJView;
@class TORPConfigListData;
@protocol TOXJViewDelegate <NSObject>

- (void)xjView:(TOXJView *)view handleTxWithData:(TORPConfigListData *)data;
- (void)xjViewRule:(TOXJView *)view;
@end
@interface TOXJView : UIView
@property (nonatomic, weak) id<TOXJViewDelegate> delegate;
- (void)refreshxJUserInfoData:(NSString *)leftRp;
- (void)refreshxJConfigInfoData:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
