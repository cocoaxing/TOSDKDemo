//
//  TOTXView.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/17.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TOTXView;
@class TOTXConfigListDataModel;
@protocol TOTXViewDelegate <NSObject>

- (void)txView:(TOTXView *)view handleTxWithItemModel:(TOTXConfigListDataModel *)model;
- (void)txViewRule:(TOTXView *)view;

@end
@interface TOTXView : UIView
@property (nonatomic, weak) id<TOTXViewDelegate> delegate;
- (void)refreshTxUserInfoData:(NSString *)round;
- (void)refreshDatas:(NSArray *)datas;
@end

NS_ASSUME_NONNULL_END
