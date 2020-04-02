//
//  TOOneYuanHUD.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/25.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOOneYuanHUD : UIView
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger applyCount;
@property (nonatomic, assign) BOOL isShowTip;
@end

NS_ASSUME_NONNULL_END