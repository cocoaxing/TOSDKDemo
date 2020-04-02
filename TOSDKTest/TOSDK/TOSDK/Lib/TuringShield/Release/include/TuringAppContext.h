//
//  TuringAppContext.h
//  TuringShield
//
//  Created by Sensheng Xu on 2019/8/1.
//  Copyright © 2019 Tecent Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuringServiceDefine.h"


@tsclass(TuringAppContext);
TS_AVAILABLE_IF(TS_ENABLES_FINGERPRINT_FEATURE)
@interface TuringAppContext : NSObject

@property (nonatomic, copy, nullable) NSString *channel;
@property (nonatomic, copy, nullable) NSString *licenseCode;
@property (nonatomic, copy, nullable) NSString *version;
@property (nonatomic, assign) NSUInteger build;
@property (nonatomic, copy, nullable) NSString *metaData;

@end

