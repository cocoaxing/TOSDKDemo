//
//  UIImage+Extension.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/14.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)
+ (UIImage *)imageInBundleWithName:(NSString *)imageName class:(Class)class;
@end

NS_ASSUME_NONNULL_END
