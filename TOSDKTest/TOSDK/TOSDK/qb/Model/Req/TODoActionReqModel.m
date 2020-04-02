//
//  TODoActionReqModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/13.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TODoActionReqModel.h"
#import "TOUserdefault.h"
#import "AdSupport/ASIdentifierManager.h"
#include <net/if.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <sys/sysctl.h>
#import "sys/utsname.h"
#import <sys/sockio.h>
#import <sys/ioctl.h>
#include <sys/socket.h>
#include <net/if_dl.h>
@implementation TODoActionReqModel

@end

@implementation TODoActionReqParam

- (instancetype)init {
    if (self = [super init]) {
        _appId = [[TOUserDefault sharedTOUserDefault] getAppId];
        _appReqType = @"iOS";
        _appUserId = [TOSDKUtil getIUUIDMD5];
        _cip = [self getIPAddress];
        _cliTimestamp = [NSString stringWithFormat:@"%@000", [TOSDKUtil getCurrentTime]];
        NSUUID *afdi = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        NSString *afdiStr = [afdi UUIDString];
        _deviceId = afdiStr;
        _traceId = [[TOUserDefault sharedTOUserDefault] getTraceId];
        _appPackageName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        _appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        _appVersionName = @"";
        _b1 = @"";
        _b2 = @"";
        _b3 = @"";
        _b4 = @"";
        _b5 = @"";
        _b6 = @"";
        _channel = @"";
        _imei = @"";
        _jsonParam = @"";
        _sdkVersionCode = TOSDK_Version;
        _sdkVersionName = TOSDK_Version_Name;
        _sysUserId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
    }
    return self;
}

- (NSString *)getIPAddress
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                    NSLog(@"IP:%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)]);
                return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return @"0.0.0.0";
}
@end
