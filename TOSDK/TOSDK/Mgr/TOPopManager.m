//
//  TOPopManager.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/10.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOPopManager.h"
#import "TOReceiveHUD.h"
#import "TOOneYuanHUD.h"
#import "TOLackHUD.h"
static TOPopManager *_instance;
@implementation TOPopManager
+ (instancetype)sharedInstance {
    if (_instance == nil) {
        _instance = [[TOPopManager alloc] init];
    }
    
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

- (void)popRewardWithXj:(NSString *)xj ye:(NSString *)ye isN:(BOOL)isN {
    UIViewController *vc = [TOSDKUtil currentViewController];
    TOReceiveHUD *hud = [[TOReceiveHUD alloc]initWithFrame:vc.view.bounds];
    hud.alpha = 0.0f;
    hud.xj = xj;
    hud.isN = isN;
    [vc.view addSubview:hud];
    
    [UIView animateWithDuration:0.3 animations:^{
        hud.alpha = 1.0f;
    }];
}

- (void)popOneYuanHud:(NSString *)message applyCount:(NSInteger)applyCount showTip:(BOOL)show {
    
    message = [message stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    
    UIViewController *vc = [TOSDKUtil currentViewController];
    TOOneYuanHUD *hud = [[TOOneYuanHUD alloc]initWithFrame:vc.view.bounds];
    hud.alpha = 0.0f;
    hud.message = message;
    hud.applyCount = applyCount;
    hud.isShowTip = show;
    [vc.view addSubview:hud];
    [UIView animateWithDuration:0.3 animations:^{
        hud.alpha = 1.0f;
    }];
}

- (void)popLackHud:(NSString *)message isT:(BOOL)isT {
    UIViewController *vc = [TOSDKUtil currentViewController];
    TOLackHUD *hud = [[TOLackHUD alloc]initWithFrame:vc.view.bounds];
    hud.alpha = 0.0f;
    hud.message = message;
    hud.isT = isT;
    [vc.view addSubview:hud];
    [UIView animateWithDuration:0.3 animations:^{
        hud.alpha = 1.0f;
    }];
}

@end
