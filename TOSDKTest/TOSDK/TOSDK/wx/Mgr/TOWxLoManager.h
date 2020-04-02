//
//  TOWxLoManager.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^WXLoginCallback)(NSDictionary *_Nullable userInfo, NSInteger login, NSError  * _Nullable error);
@interface TOWxLoManager : NSObject<WXApiDelegate>
singleton_interface(TOWxLoManager)
- (void)wxAuthAccessTokenCallback:(WXLoginCallback)callback;
@end

NS_ASSUME_NONNULL_END
