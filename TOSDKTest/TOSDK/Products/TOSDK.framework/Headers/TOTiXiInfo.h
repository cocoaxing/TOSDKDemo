//
//  ToTiXiInfo.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/17.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToTiXiInfo : NSObject
/**
 * 当前可提现额度(单位：元)
 */
@property (nonatomic, assign) CGFloat curWradhtiwXiJin;

/**
 * 下一个可提现额度，如果没有下一个提现额度则返回0(单位：元)
 */
@property (nonatomic, assign) CGFloat nextWradhtiwXiJin;

/**
 * 离下一个可提现额度还需要多少金币，如果没有下一个提现额度则返回0
 */
@property (nonatomic, assign) CGFloat nextWradhtiwNeedCoJbins;
@end

NS_ASSUME_NONNULL_END
