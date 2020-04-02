//
//  TOBaseHUD.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TOBaseHUDLoginCallback)(BOOL isAuth, NSError * _Nullable error);
@interface TOBaseHUD : UIView
@property (nonatomic, strong) UIImageView *bgImageView;
- (void)clickWxLogin:(TOBaseHUDLoginCallback)callback;
@end

NS_ASSUME_NONNULL_END
