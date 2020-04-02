//
//  TOSysUserInfoRepModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOSysUserInfoData;
@class TOSysUserInfoBo;
@interface TOSysUserInfoRepModel : TOBaseRepModel
@property (nonatomic, strong) TOSysUserInfoData *data;
@end

@interface TOSysUserInfoData : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *headImgurl;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *unionId;
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, strong) TOSysUserInfoBo *payUserRedpacketInfoBo;
@end

@interface TOSysUserInfoBo : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, assign) NSInteger continuousChekcinDays;
@property (nonatomic, assign) NSInteger isTodayChekcin;
@property (nonatomic, assign) NSInteger isNewUserTx;
@property (nonatomic, copy) NSString *currentRP;
@property (nonatomic, assign) NSInteger isNURP;
@property (nonatomic, copy) NSString *leftJb;
@property (nonatomic, copy) NSString *leftRp;
@property (nonatomic, copy) NSString *sysUserId;
@end

NS_ASSUME_NONNULL_END
