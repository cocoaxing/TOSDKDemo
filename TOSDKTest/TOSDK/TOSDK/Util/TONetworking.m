//
//  TONetworking.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TONetworking.h"
#import "TOUserDefault.h"
@interface TONetworking ()<NSURLSessionDelegate>

@end

@implementation TONetworking
singleton_implementation(TONetworking)
// GET请求
- (void)get {
    NSString *name = @"张三";
    NSString *pwd = @"zhang";
    NSString *strUrl = [NSString stringWithFormat:@"http://127.0.0.1/php/login.php?username=%@&password=%@", name, pwd];
    
    // 对汉字进行转义
    strUrl = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"TOSDK_LOG: %@", strUrl);
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
         if (connectionError) {
             TOLog(@"TOSDK_LOG: 网络连接错误 %@", connectionError);
             return;
         }
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304) {
             // 解析数据
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSLog(@"TOSDK_LOG: %@", dict);
         } else {
             TOLog(@"TOSDK_LOG: 服务器内部错误");
         }
     }];
    
}

// POST请求
- (void)post:(NSDictionary *)param api:(NSString *)api callback:(ResponseCallback)callback {
    
    if (![api isEqualToString:FI_GetInitInfo]) {
        NSString *titi = [[TOUserDefault sharedTOUserDefault] getTiti];
        titi = _NSStringFromBbString(titi);
        //appVersion+appId
        NSString *aId = [NSString stringWithFormat:@"%@%@", [[TOUserDefault sharedTOUserDefault] getAppVersion], [[TOUserDefault sharedTOUserDefault] getAppId]];
        if (titi.length > 0 && [titi isEqualToString:aId]) {
            return;
        }
    }
    
    NSString *domain = _NSStringFromBbString(AppDomain_Debug);
    if (TO_RELEASE_FLAG) {
        domain = _NSStringFromBbString(AppDomain_Release);
    }
    
    if ([[TOUserDefault sharedTOUserDefault] getUseServer]) {
        domain = _NSStringFromBbString(AppDomain_Debug);
    } else {
        domain = _NSStringFromBbString(AppDomain_Release);
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", domain, _NSStringFromBbString(SubAppDomain), api];
    // 创建url
    NSURL *url = [NSURL URLWithString:urlString];
    // 创建网络请求
    NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:url];
    // 设置请求方法
    [requestPost setHTTPMethod:@"POST"];
    // 设置请求json
    NSDictionary *parameters = param;
    NSLog(@"TOSDK_LOG: TOSDK接口请求url = %@", urlString);
    NSLog(@"TOSDK_LOG: TOSDK接口请求param = %@\n%@", [parameters TOMJ_JSONString], parameters);
    NSError *error;
    [requestPost setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted  error:&error]];
    // set headers
    [requestPost setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-type"];
    // 获取会话对象
//    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    // 根据会话对象，创建Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:requestPost completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                TOLog(@"TOSDK_LOG: TOSDK api=%@ 时出错:%@", api, error);
                callback(nil, error);
            } else {
                //Json解析
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *jsonText = [dic TOMJ_JSONString];
                TOLog(@"TOSDK_LOG: TOSDK %@ 获取结果:%@", api, jsonText);
                callback(dic, nil);
            }
        });
        
    }];
    // 执行任务
    [sessionDataTask resume];

}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    //    TOLog(@"TOSDK_LOG: didReceiveChallenge %@", challenge.protectionSpace);
    // 1.判断服务器返回的证书类型, 是否是服务器信任
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        /*
         NSURLSessionAuthChallengeUseCredential = 0,                     使用证书
         NSURLSessionAuthChallengePerformDefaultHandling = 1,            忽略证书(默认的处理方式)
         NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2,     忽略书证, 并取消这次请求
         NSURLSessionAuthChallengeRejectProtectionSpace = 3,            拒绝当前这一次, 下一次再询问
         */
        //        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential , card);
    }
}

@end
