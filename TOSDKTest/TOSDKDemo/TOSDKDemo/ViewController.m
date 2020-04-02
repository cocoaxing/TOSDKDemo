//
//  ViewController.m
//  TOSDKDemo
//
//  Created by TopOneAppleNo1 on 2020/2/13.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "ViewController.h"
#import <TOSDK/TOSDKHeader.h>
@interface ViewController ()<UITextFieldDelegate, TOTxManagerDelegate, TOXjinJliDelegate, TOJiBinReDelegate, TOWxSignInDelegate, TOCoJbinsBalanceDelegate, TOUserInfoDelegate, TOCheckInDelegate, TOTiXiInfoDelegate>
@property (nonatomic, strong) ToSdkManager *wallet;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (nonatomic, strong) UITextView *infoLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"我的钱包" forState:(UIControlStateNormal)];
    btn.layer.cornerRadius = 10;
    [btn setBackgroundColor:[UIColor redColor]];
    btn.frame = CGRectMake(30, 100, self.view.bounds.size.width - 60, 30);
    [btn addTarget:self action:@selector(clickPage) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    UIButton *newUserbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [newUserbtn setTitle:@"新人大礼包" forState:(UIControlStateNormal)];
    newUserbtn.layer.cornerRadius = 10;
    [newUserbtn setBackgroundColor:[UIColor redColor]];
    newUserbtn.frame = CGRectMake(30, 140, self.view.bounds.size.width - 60, 30);
    [newUserbtn addTarget:self action:@selector(clickNewUserPage) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:newUserbtn];
    
    UIButton *getJiBinRebtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [getJiBinRebtn setTitle:@"领取金币" forState:(UIControlStateNormal)];
    getJiBinRebtn.layer.cornerRadius = 10;
    [getJiBinRebtn setBackgroundColor:[UIColor redColor]];
    getJiBinRebtn.frame = CGRectMake(30, 180, self.view.bounds.size.width - 60, 30);
    [getJiBinRebtn addTarget:self action:@selector(clickGetRound) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:getJiBinRebtn];
    
    UIButton *getYeRoundbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [getYeRoundbtn setTitle:@"查看红包余额" forState:(UIControlStateNormal)];
    getYeRoundbtn.layer.cornerRadius = 10;
    [getYeRoundbtn setBackgroundColor:[UIColor redColor]];
    getYeRoundbtn.frame = CGRectMake(30, 220, self.view.bounds.size.width - 60, 30);
    [getYeRoundbtn addTarget:self action:@selector(clickGetYe) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:getYeRoundbtn];
    
//    UIButton *getJbbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [getJbbtn setTitle:@"查看金币余额" forState:(UIControlStateNormal)];
//    getJbbtn.layer.cornerRadius = 10;
//    [getJbbtn setBackgroundColor:[UIColor redColor]];
//    getJbbtn.frame = CGRectMake(30, 260, self.view.bounds.size.width - 60, 30);
//    [getJbbtn addTarget:self action:@selector(clickGetJbYe) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:getJbbtn];
//
//    UIButton *wxLoginbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [wxLoginbtn setTitle:@"微信登陆" forState:(UIControlStateNormal)];
//    wxLoginbtn.layer.cornerRadius = 10;
//    [wxLoginbtn setBackgroundColor:[UIColor redColor]];
//    wxLoginbtn.frame = CGRectMake(30, 300, self.view.bounds.size.width - 60, 30);
//    [wxLoginbtn addTarget:self action:@selector(clickWxLogin) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:wxLoginbtn];
    
    UIButton *userInfobtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [userInfobtn setTitle:@"获取用户信息" forState:(UIControlStateNormal)];
    userInfobtn.layer.cornerRadius = 10;
    [userInfobtn setBackgroundColor:[UIColor redColor]];
    userInfobtn.frame = CGRectMake(30, 260, self.view.bounds.size.width - 60, 30);
    [userInfobtn addTarget:self action:@selector(clickGetUserInfo) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:userInfobtn];
    
    UIButton *checkInbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [checkInbtn setTitle:@"签到" forState:(UIControlStateNormal)];
    checkInbtn.layer.cornerRadius = 10;
    [checkInbtn setBackgroundColor:[UIColor redColor]];
    checkInbtn.frame = CGRectMake(30, 300, self.view.bounds.size.width - 60, 30);
    [checkInbtn addTarget:self action:@selector(clickCheckIn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:checkInbtn];
    
    UIButton *txInfobtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [txInfobtn setTitle:@"提现信息" forState:(UIControlStateNormal)];
    txInfobtn.layer.cornerRadius = 10;
    [txInfobtn setBackgroundColor:[UIColor redColor]];
    txInfobtn.frame = CGRectMake(30, 340, self.view.bounds.size.width - 60, 30);
    [txInfobtn addTarget:self action:@selector(clickTxInfo) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:txInfobtn];
    
    UIButton *countLimitbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [countLimitbtn setTitle:@"红包领取次数限制" forState:(UIControlStateNormal)];
    countLimitbtn.layer.cornerRadius = 10;
    [countLimitbtn setBackgroundColor:[UIColor redColor]];
    countLimitbtn.frame = CGRectMake(30, 380, self.view.bounds.size.width - 60, 30);
    [countLimitbtn addTarget:self action:@selector(clickCountLimit) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:countLimitbtn];
    
    UITextView *infoLabel = [[UITextView alloc]initWithFrame:CGRectMake(30, 420, self.view.bounds.size.width - 60, 500)];
    infoLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    infoLabel.layer.cornerRadius = 10;
    infoLabel.font = [UIFont systemFontOfSize:15];
    infoLabel.textColor = [UIColor blackColor];
    [self.view addSubview:infoLabel];
    _infoLabel = infoLabel;
    self.tf.delegate = self;
    
    
    
}

- (BOOL)clickCountLimit {
    BOOL isaVI = [[TOTxManager sharedInstance] isCasRewrdAvailable];
    if (!isaVI) {
        self.infoLabel.text = @"红包领取次数已达上限";
        return NO;
    } else {
        self.infoLabel.text = @"还可以继续领取红包";
        return YES;
    }
}

- (void)clickTxInfo {
    [[TOTxManager sharedInstance] getTiXiInfoWithDelegate:self];
}

- (void)onGetTiXiInfoSuccess:(ToTiXiInfo *)info {
    self.infoLabel.text = [NSString stringWithFormat:@"当前最大提现额度是:%.02lf元\n下一个可提现额度为:%.02lf元\n离下一个可提现额度还差:%.02lf金币", info.curWradhtiwXiJin, info.nextWradhtiwXiJin, info.nextWradhtiwNeedCoJbins];
}

- (void)onGetTiXiInfoFailed:(NSString *)msg {
    self.infoLabel.text = [NSString stringWithFormat:@"获取提现信息失败:%@", msg];
}

//签到
- (void)clickCheckIn {
    [[TOTxManager sharedInstance] doCheckInWithCoJbins:100 delegate:self];
}

- (void)onCheckInSuccessWithCheckInDays:(NSInteger)continuousCheckInDays coJbinsBalance:(NSInteger)coJbinsBalance {
    NSLog(@"%s:continuousCheckInDays=%ld, coJbinsBalance=%ld", __FUNCTION__, continuousCheckInDays, coJbinsBalance);
    [self clickGetUserInfo];
}

- (void)onCheckInFailed:(NSString *)msg {
    NSLog(@"%s:%@", __FUNCTION__, msg);
    [self clickGetUserInfo];
}

//获取用户接口
- (void)clickGetUserInfo {
    [[TOWxSignInManager sharedInstance] getToUserInfo:self];
}

- (void)onGetUserInfoSuccess:(TOUserInfo *)userInfo {
    NSLog(@"%s:%@", __FUNCTION__, userInfo.userId);
    self.infoLabel.text = [NSString stringWithFormat:@"用户id:%@\n是否绑定微信:%d\n是否领取新人红包:%d\n用户名:%@\n用户头像:%@\n今天是否已签到:%d\n签到天数:%ld\n是否完成新手提现:%d", userInfo.userId, userInfo.bindingWx, userInfo.hasGotNewUserXjjl, userInfo.userName, userInfo.userImagUrl, userInfo.isTodayCheckIn, userInfo.chekckInDays, userInfo.isNewUserTx];
    
    
    
}

- (void)onGetUserInfoFailed:(NSString *)msg {
    NSLog(@"%s:%@", __FUNCTION__, msg);
}

//查看金币余额
- (void)clickGetJbYe {
    [[TOTxManager sharedInstance] getCoJbinsBalanceWithDelegate:self];
}

- (void)onCoJbinsBalancedSuccess:(NSInteger)coJbinsBalance {
    NSLog(@"%s:%ld", __FUNCTION__, (long)coJbinsBalance);
    
}

- (void)onCoJbinsBalanceFailed:(NSString *)msg {
    NSLog(@"%s:%@", __FUNCTION__, msg);
}

//微信登陆
- (void)clickWxLogin {
    [[TOWxSignInManager sharedInstance] wxSignInWithDelegate:self];
}

- (void)onWxSignInSuccess:(TOUserInfo *)userInfo {
    NSLog(@"%s:%@", __FUNCTION__, userInfo);
    [self clickGetUserInfo];
}

- (void)onWxSignInFailed:(NSString *)msg {
    NSLog(@"%s:%@", __FUNCTION__, msg);
    [self clickGetUserInfo];
}

//获取余额
- (void)clickGetYe {
    [[TOTxManager sharedInstance] showXiJinBalance];
}
//获取金币
- (void)clickGetRound {
    [[TOTxManager sharedInstance] getJiBinRe:50000 delegate:self];
}
//我的钱包
- (void)clickPage {
    [[TOTxManager sharedInstance] showTxPageWithDeleagte:self];
}

//获取现金红包
- (void)clickNewUserPage {
   BOOL is = [self clickCountLimit];
    if (is) {
        [[TOTxManager sharedInstance] showXjinJliWithDelegate:self];
    }
}

//提现回调
- (void)onTxApplySuccess:(NSInteger)txXj consumedJinb:(NSInteger)consumedJinb {
    NSLog(@"提现成功, 金额为:%ld, 花费金币为:%ld", (long)txXj, (long)consumedJinb);
    [self clickGetUserInfo];
}

- (void)onTxApplyFailed:(NSString *)msg {
    NSLog(@"提现失败, %@", msg);
    [self clickGetUserInfo];
}

//现金红包领取
- (void)onXjinJliSuccess:(CGFloat)cashBalance {
    NSLog(@"现金红包领取成功, 余额为:%lf", cashBalance);
    [self clickGetUserInfo];
}

- (void)onXjinJliFailed:(NSString *)msg {
    NSLog(@"现金红包领取失败, %@", msg);
    [self clickGetUserInfo];
}

//金币领取回调
- (void)onJiBinReSuccess:(NSInteger)coJbinsBalance {
    NSLog(@"金币领取成功, 余额为:%ld", (long)coJbinsBalance);
    [self clickGetUserInfo];
    [self clickTxInfo];
}

- (void)onJiBinReFailed:(NSString *)msg {
    NSLog(@"金币领取失败, %@", msg);
    [self clickGetUserInfo];
}


//其他
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSString *goldStr = textField.text;
    NSInteger gold = [goldStr integerValue];
    if (gold > 0) {
        [[TOTxManager sharedInstance] getJiBinRe:gold delegate:self];
    }
    
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
