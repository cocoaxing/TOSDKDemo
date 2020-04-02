//
//  AppDelegate.m
//  TOSDKDemo
//
//  Created by TopOneAppleNo1 on 2020/2/13.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "AppDelegate.h"
#import <TOSDK/ToSdkManager.h>


@interface AppDelegate ()
@property (nonatomic, strong) ToSdkManager *wallet;
@end

#define APP_KEY @"9AD97A310FC8455A"
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /**
     * 初始化参数使用说明
     */
    TOSdkConfig *config = [[TOSdkConfig alloc]init];
    config.appkey = APP_KEY;      // (必要)TOSDK 分配的 appKey
    config.logEnable = YES;        // (非必要)是否打开 log 日志，默认 false
    config.useTestServer = YES;   // (非必要)是否使用测试服，默认 false
    [ToSdkManager initSdkWithConfig:config];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [ToSdkManager handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [ToSdkManager handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [ToSdkManager handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    
    return [ToSdkManager handleOpenUniversalLink:userActivity];
    
}

@end
