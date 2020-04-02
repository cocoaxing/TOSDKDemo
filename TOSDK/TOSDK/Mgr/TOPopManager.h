//
//  TOPopManager.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/10.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOPopManager : NSObject
+ (instancetype)sharedInstance;
- (void)popRewardWithXj:(NSString *)xj ye:(NSString *)ye isN:(BOOL)isN;
- (void)popOneYuanHud:(NSString *)message applyCount:(NSInteger)applyCount showTip:(BOOL)show;
- (void)popLackHud:(NSString *)message isT:(BOOL)isT;
@end

NS_ASSUME_NONNULL_END
