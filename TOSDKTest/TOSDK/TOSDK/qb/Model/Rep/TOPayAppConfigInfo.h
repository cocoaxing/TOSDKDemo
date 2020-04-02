//
//  TOPayAppConfigInfo.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/24.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOPayAppConfigInfoData;
@class TOPayAppConfigInfoDataJsonParam;
@interface TOPayAppConfigInfo : TOBaseRepModel
@property (nonatomic, strong) TOPayAppConfigInfoData *data;
@end

@interface TOPayAppConfigInfoData : NSObject
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *contactAddress;
@property (nonatomic, copy) NSString *contactName;
@property (nonatomic, copy) NSString *contactTel;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *wxAppId;
@property (nonatomic, copy) NSString *wxAppKey;
@property (nonatomic, copy) NSString *wxUniversalLink;
@end

NS_ASSUME_NONNULL_END
