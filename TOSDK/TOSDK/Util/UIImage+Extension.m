//
//  UIImage+Extension.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/14.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageInBundleWithName:(NSString *)imageName class:(Class)class{
    NSString *bundlePath = [[NSBundle bundleForClass:class] pathForResource:@"TOSDK" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *img = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    return img;
}
@end
