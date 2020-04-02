//
//  ToBindingUserRepModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ToBindingUserData;
@class TOPayUserRedpacketInfoBo;
@interface ToBindingUserRepModel : TOBaseRepModel
@property (nonatomic, strong) ToBindingUserData *data;
@end

@interface ToBindingUserData : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, copy) NSString *headImgurl;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *unionId;
@property (nonatomic, copy) NSString *sysUserId;
@property (nonatomic, strong) TOPayUserRedpacketInfoBo *payUserRedpacketInfoBo;
@end

@interface TOPayUserRedpacketInfoBo : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appUserId;
@property (nonatomic, assign) NSInteger isNURP;//1领过 0未领过
@property (nonatomic, copy) NSString *leftJB;
@property (nonatomic, copy) NSString *leftRP;
@property (nonatomic, copy) NSString *sysUserId;

@end

NS_ASSUME_NONNULL_END
