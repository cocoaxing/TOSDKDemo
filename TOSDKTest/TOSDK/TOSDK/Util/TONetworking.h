//
//  TONetworking.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ResponseCallback)(NSDictionary * _Nullable jsonDic, NSError * _Nullable error);
@interface TONetworking : NSObject
singleton_interface(TONetworking)
- (void)get;
- (void)post:(NSDictionary *)param api:(NSString *)api callback:(ResponseCallback)callback;
@end

NS_ASSUME_NONNULL_END
