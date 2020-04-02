//
//  TOLoViewController.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/20.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LOLoginCallback)(BOOL isAuth, NSError * _Nullable error);
@interface TOLoViewController : UIViewController
@property (nonatomic, copy) LOLoginCallback callback;
@end

NS_ASSUME_NONNULL_END
