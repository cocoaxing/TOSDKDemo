//
//  TORPConfigList.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/23.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TORPConfigListData;
@interface TORPConfigList : TOBaseRepModel
@property (nonatomic, strong) NSArray <TORPConfigListData *> *data;
@end

@interface TORPConfigListData : NSObject
@property (nonatomic, copy) NSString *adIcon;
@property (nonatomic, copy) NSString *adId;
@property (nonatomic, assign) NSInteger adIsWatchFirst;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, assign) NSInteger applyCount;
@property (nonatomic, copy) NSString *ppjb;
@property (nonatomic, copy) NSString *goneMessage;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *ppinc;
@property (nonatomic, assign) NSInteger isNewUser;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, assign) NSInteger typeValue;
@end

NS_ASSUME_NONNULL_END
