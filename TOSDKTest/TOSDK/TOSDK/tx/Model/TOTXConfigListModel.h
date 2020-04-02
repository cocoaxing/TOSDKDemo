//
//  TOTXConfigListModel.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseRepModel.h"

NS_ASSUME_NONNULL_BEGIN
@class TOTXConfigListDataModel;
@interface TOTXConfigListModel : TOBaseRepModel
@property (nonatomic, strong) NSArray <TOTXConfigListDataModel *> *data;
@end

@interface TOTXConfigListDataModel : NSObject
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
@property (nonatomic, assign) NSInteger leftCount;
@end

NS_ASSUME_NONNULL_END
