//
//  ToLogHisReqModel.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/10.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "ToLogHisReqModel.h"
#import "AdSupport/ASIdentifierManager.h"
#import "TOUserDefault.h"
#include <net/if.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <sys/sysctl.h>
#import "sys/utsname.h"
#import <sys/sockio.h>
#import <sys/ioctl.h>
#include <sys/socket.h>
#include <net/if_dl.h>

@implementation ToLogHisReqModel

@end

@implementation ToLogHisParam

- (instancetype)init {
    if (self = [super init]) {
        NSUUID *afdi = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        NSString *afdiStr = [afdi UUIDString];
        _androidID = @"";
        _installedList = @"[0]";
        _isRoot = [self isJailBreak];
        _appId = [[TOUserDefault sharedTOUserDefault] getAppId];
        _appPackageName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        _appReqType = @"iOS";
        _appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        _appVersionName = @"";
        _channel = @"";
        _city = @"";
        _imei = afdiStr;
        _internetType = @"";//
        _ip = [self getIPAddress];
        _latitude = @"";
        _longitude = @"";
        _mac = [self getMacAddress];
        _phoneBrand = @"iPhone";
        _phoneModel = [UIDevice currentDevice].model;
        _position = @"";
        _province = @"";
        _sdkVersionCode = TOSDK_Version;
        _sdkVersionName = TOSDK_Version_Name;
        _sysUserId = [[TOUserDefault sharedTOUserDefault] getSysUserId];
        NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        _systemLang = [appLanguages objectAtIndex:0];
        _systemVersion = [UIDevice currentDevice].systemVersion;
        _wifiMac = @"";
        _wifiName = @"";
        _traceId = [[TOUserDefault sharedTOUserDefault] getTraceId];
        _appUserId = [TOSDKUtil getIUUIDMD5];
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
    return nil;
}
- (NSString *) isJailBreak {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return @"1";
    } else {
        return @"0";
    }
    
}

- (NSString *)getMacAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    // MAC地址带冒号
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2),
                           *(ptr+3), *(ptr+4), *(ptr+5)];
    
    // MAC地址不带冒号
    //    NSString *outstring = [NSString
    //                           stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    
    free(buf);
    
    return [outstring uppercaseString];
}

@end
