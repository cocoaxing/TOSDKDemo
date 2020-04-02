//
//  TOWxLoManager.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOWxLoManager.h"
#import "TOUserDefault.h"
#define WX_ACCESS_TOKEN @"access_token"
#define WX_OPEN_ID @"openid"
#define WX_REFRESH_TOKEN @"refresh_token"

@interface TOWxLoManager ()
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) WXLoginCallback loginCallback;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *appSecret;
@end

@implementation TOWxLoManager
singleton_implementation(TOWxLoManager)

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxLogin:) name:@"wxLogin" object:nil];
    }
    return self;
}

/***************************w x L o g i nstart*****************************/

- (void)wxAuthAccessTokenCallback:(WXLoginCallback)callback {
    self.loginCallback = callback;
    //验证accessToken是否是成功
//    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *accessToken = @"";
    NSString *openid = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    if(!accessToken || [accessToken isEqualToString:@""] || !openid || [openid isEqualToString:@""]){
        //如果没登陆过，则登陆
        TOLog(@"TOSDK_LOG: w x L o g i n--> 没登陆过，则登陆");
        [self login];
    }else{
        TOLog(@"TOSDK_LOG: w x L o g i n--> 验证access token 是否还有效");
        //否则验证access token 是否还有效
        NSString *urlStr = [NSString stringWithFormat:@"%@/sns/auth?access_token=%@&openid=%@",_NSStringFromBbString(TO_Awqqc), accessToken,openid];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        //创建session单例
        NSURLSession*session = [NSURLSession sharedSession];
        [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSURLSessionDataTask*task = [session dataTaskWithRequest:request completionHandler:^(NSData*_Nullable data,NSURLResponse*_Nullable response,NSError*_Nullable error) {
            if (error) {
                TOLog(@"TOSDK_LOG: %@", error);
                callback(nil, 0, error);
                return;
            }
            //数据解析 json - >字典
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            TOLog(@"TOSDK_LOG: <<<<<<<<<%@>>>>>>>>>>",object);
            //刷新数据(返回主线程刷新数据)
            TOLog(@"TOSDK_LOG: success");
            NSDictionary *resp = (NSDictionary*)object;
            if([resp[@"errcode"] intValue] == 0){
                //有效则直接获取信息
                [self getUserInfo];
            }else{
                //否则使用refreshtoken来刷新accesstoken
                [self refreshAccessToken];
            }
        }];
        
        //开始数据请求
        [task resume];
    }
}

- (void)login{
    //判断w .x.是否安装
    if([WXApi isWXAppInstalled]){
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"App";
        [WXApi sendReq:req completion:^(BOOL success) {
            TOLog(@"TOSDK_LOG: w x L o g i n %d", success);
        }];
    }else{
        [self setupAlertController];
    }
}

- (void)onResp:(BaseResp *)resp{
    if([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *resp2 = (SendAuthResp *)resp;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"wxLogin" object:resp2];
        TOLog(@"TOSDK_LOG: w .x.授权成功");
    }else{
        TOLog(@"TOSDK_LOG: w .x.授权失败");
    }
}

- (void)setupAlertController{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"请先安装%@客户端", _NSStringFromBbString(TO_BB_WX)]  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfim = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfim];
    UIViewController *vc = [TOWxLoManager currentViewController];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [vc presentViewController:alert animated:YES completion:nil];
}

//获取手机当前显示的ViewController
+ (UIViewController*)currentViewController{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

- (void)wxLogin:(NSNotification*)noti{
    //获取到code
    SendAuthResp *resp = noti.object;
    NSLog(@"TOSDK_LOG: w .x.获得code%@",resp.code);
    _code = resp.code;
    //否则验证access token 是否还有效
    NSString *urlStr = [NSString stringWithFormat:@"%@/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=%@",_NSStringFromBbString(TO_Awqqc),self.appid,self.appSecret,_code,@"authorization_code"];
    NSURL *url = [NSURL URLWithString:urlStr];
    //        NSURLRequest *request = [NSURLRequest requestWithURL:url];//默认为GET
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //创建session单例
    NSURLSession*session = [NSURLSession sharedSession];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask*task = [session dataTaskWithRequest:request completionHandler:^(NSData*_Nullable data,NSURLResponse*_Nullable response,NSError*_Nullable error) {
        
        if (error) {
            self.loginCallback(nil, 0, error);
            return;
        }
        
        //数据解析 json - >字典
        id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"TOSDK_LOG: <<<<<<<<<%@>>>>>>>>>>",object);
        //刷新数据(返回主线程刷新数据)
        NSLog(@"TOSDK_LOG: success");
        NSDictionary *resp = (NSDictionary*)object;
        NSString *openid = resp[@"openid"];
        NSString *unionid = resp[@"unionid"];
        NSString *accessToken = resp[@"access_token"];
        NSString *refreshToken = resp[@"refresh_token"];
        if(accessToken && ![accessToken isEqualToString:@""] && openid && ![openid isEqualToString:@""]){
            [[NSUserDefaults standardUserDefaults] setObject:openid forKey:WX_OPEN_ID];
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self getUserInfo];
    }];
    
    //开始数据请求
    
    [task resume];
    
}


- (void)refreshAccessToken {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/sns/oauth2/refresh_token?appid=%@&refresh_token=%@&grant_type=%@",_NSStringFromBbString(TO_Awqqc),[[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID],[[NSUserDefaults standardUserDefaults] objectForKey:WX_REFRESH_TOKEN],@"REFRESH_TOKEN"];
    NSURL *url = [NSURL URLWithString:urlStr];
    //        NSURLRequest *request = [NSURLRequest requestWithURL:url];//默认为GET
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //创建session单例
    NSURLSession*session = [NSURLSession sharedSession];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask*task = [session dataTaskWithRequest:request completionHandler:^(NSData*_Nullable data,NSURLResponse*_Nullable response,NSError*_Nullable error) {
        
        if (error) {
            NSLog(@"TOSDK_LOG: fail");
            NSLog(@"TOSDK_LOG: %@",error);
            self.loginCallback(nil, 0, error);
            return;
        }
        //数据解析 json - >字典
        id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"TOSDK_LOG: success");
        NSDictionary *resp = (NSDictionary*)object;
        NSString *openid = resp[@"openid"];
        NSString *accessToken = resp[@"access_token"];
        NSString *refreshToken = resp[@"refresh_token"];
        if(refreshToken){
            if(accessToken && ![accessToken isEqualToString:@""] && openid && ![openid isEqualToString:@""]){
                [[NSUserDefaults standardUserDefaults] setObject:openid forKey:WX_OPEN_ID];
                [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
                [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            self.loginCallback(resp, 1, nil);
        }else{
            //如果refreshToken为空，说明refreshToken也过期了，需要重新登陆
            [self login];
        }
    }];
    
    //开始数据请求
    
    [task resume];
}

- (void)getUserInfo {
    //获取个人信息
    NSString *urlStr = [NSString stringWithFormat:@"%@/sns/userinfo?access_token=%@&openid=%@",_NSStringFromBbString(TO_Awqqc),[[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN],[[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID]];
    NSURL *url = [NSURL URLWithString:urlStr];
    //        NSURLRequest *request = [NSURLRequest requestWithURL:url];//默认为GET
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //创建session单例
    NSURLSession*session = [NSURLSession sharedSession];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask*task = [session dataTaskWithRequest:request completionHandler:^(NSData*_Nullable data,NSURLResponse*_Nullable response,NSError*_Nullable error) {
        
        if (error) {
            NSLog(@"TOSDK_LOG: %@",error);
            return;
        }
        //数据解析 json - >字典
        id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        TOLog(@"TOSDK_LOG: success");
        NSLog(@"TOSDK_LOG: %@",object);
        NSDictionary *resp = (NSDictionary*)object;
        self.loginCallback(resp, 1, nil);
    }];
    
    //开始数据请求
    
    [task resume];
}


- (BOOL)handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

- (NSString *)appid {
    if (_appid == nil) {
        _appid = [[TOUserDefault sharedTOUserDefault] getWxId];
    }
    return _appid;
}

- (NSString *)appSecret {
    if (_appSecret == nil) {
        _appSecret = [[TOUserDefault sharedTOUserDefault] getSecretKey];
    }
    return _appSecret;
}

/***************************w x L o g i nend*****************************/

@end
