//
//  TOLoViewController.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/20.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOLoViewController.h"
#import "UIImage+Extension.h"
#import "UIView+TOExtension.h"
#import "TOHeader.h"
#import "ToSdkManager.h"
#import "TOWxLoManager.h"
#import "TOWdResultViewController.h"
#import "TONetworking.h"
#import "NSString+Extension.h"


#import "TOWxLoManager.h"
#import "TODoWardhtiwApplyReqModel.h"

#import "TOViewModel.h"
#import "ToBindingUserRepModel.h"
#import "TOUserDefault.h"

#import "TOTxManager.h"
#import "TORoundAwardRepModel.h"
#import "UIView+MAToast.h"
#import "TOWvViewController.h"
@interface TOLoViewController ()<UITextViewDelegate>
@property (nonatomic, strong) TOViewModel *viewModel;
@property (nonatomic, strong) UITextView *textView;
@end

#define LeftMargin 15
@implementation TOLoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //顶部导航背景
    UIImageView *topNaviIv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, TO_Width, TOPVIEWHEIGHT)];
    topNaviIv.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:topNaviIv];
    UIImage *img = [UIImage imageInBundleWithName:@"状态栏.png" class:[self class]];
    topNaviIv.image = img;
    //返回按钮
    UIImage *backImg = [UIImage imageInBundleWithName:@"返回.png" class:[self class]];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(LeftMargin, STATUSHEIGHT + 2, 20, 40);
    [backBtn setImage:backImg forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.5 * (TO_Width - 100), STATUSHEIGHT + 2, 100, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = @"登录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    CGFloat w = 150;
    CGFloat topMargin = 100;
    if (IsIphone55c5sse) {
        w = 120;
        topMargin = 50;
    }
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, TOPVIEWHEIGHT+topMargin, w, w)];
    iconImageView.tx_centerX = self.view.tx_centerX;
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconImageView];
    [TOSDKUtil imageWithName:@"ic_wxdlch.png" callback:^(id  _Nonnull obj) {
        if (obj) {
            UIImage *image = obj;
            iconImageView.image = image;
        }
    }];
    
    
    //标题
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, iconImageView.tx_bottom + 50, TO_Width - 60, 50)];
    tipLabel.font = [UIFont boldSystemFontOfSize:16];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = kColorWithHEX(0x333333, 1.0f);

    tipLabel.text = [NSString stringWithFormat:@"登录后%@的%@将\n直接转账到您的%@%@", _NSStringFromBbString(TO_BB_TX), _NSStringFromBbString(TO_BB_JE), _NSStringFromBbString(TO_BB_WX), _NSStringFromBbString(TO_BB_QB)];
    [self.view addSubview:tipLabel];

    UIImage *txBg = [UIImage imageInBundleWithName:@"btn-wxdlbg.png" class:[self class]];
    UIImage *txImg = [UIImage imageInBundleWithName:@"icon-wcw.png" class:[self class]];
    UIButton *txBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [txBtn setImage:txImg forState:UIControlStateNormal];
    [txBtn setBackgroundImage:txBg forState:(UIControlStateNormal)];
    [txBtn setTitle:[NSString stringWithFormat:@"    %@%@", _NSStringFromBbString(TO_BB_WX), _NSStringFromBbString(TO_BB_DL)] forState:(UIControlStateNormal)];
    [txBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    txBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    txBtn.frame = CGRectMake(70, tipLabel.tx_bottom+40, TO_Width-140, 0.2 * (TO_Width-140));
    [txBtn addTarget:self action:@selector(clickWxLogin) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:txBtn];
    
    //标题
    UITextView *bottomTexView = [[UITextView alloc]initWithFrame:CGRectMake((TO_Width - 220)*0.5, self.view.tx_bottom - 80, 220, 60)];
    [self.view addSubview:bottomTexView];
    
    
    NSString *tipStr = @"点击登录即表示已经同意\n《用户协议》和《隐私协议》";
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:tipStr];
    NSRange range1 = [tipStr rangeOfString:@"《用户协议》"];
    NSRange range2 = [tipStr rangeOfString:@"《隐私协议》"];
    [attr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range1];
    [attr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range2];
    [attr addAttribute:NSLinkAttributeName value:@"userterm://" range:range1];
    [attr addAttribute:NSLinkAttributeName value:@"police://" range:range2];
    bottomTexView.attributedText = attr;
    bottomTexView.textColor = kColorWithHEX(0x333333, 0.6f);
    bottomTexView.textAlignment = NSTextAlignmentCenter;
    bottomTexView.font = [UIFont systemFontOfSize:15];
    
    _textView = bottomTexView;
    _textView.delegate = self;
    _textView.editable = NO;

    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_ME_WXDL_POP callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([[URL scheme] isEqualToString:@"userterm"]) {
        NSLog(@"TOSDK_LOG: 用户协议---------------");
        TOWvViewController *wVc = [[TOWvViewController alloc]init];
        wVc.title = @"用户协议";
        wVc.type = 2;
        [wVc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:wVc animated:YES completion:nil];

        return NO;
    } else if ([[URL scheme] isEqualToString:@"police"]) {
        NSLog(@"TOSDK_LOG: 隐私政策---------------");
        TOWvViewController *wVc = [[TOWvViewController alloc]init];
        wVc.title = @"隐私政策";
        wVc.type = 1;
        [wVc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:wVc animated:YES completion:nil];

        return NO;
    }
    return YES;
}

- (void)clickWxLogin {
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_ME_LJTX_TX_WXDL_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    @weakify(self);
    [[TOWxLoManager sharedTOWxLoManager] wxAuthAccessTokenCallback:^(NSDictionary *_Nullable userInfo, NSInteger login, NSError *error) {
        if (error) {
            //登陆出错
            self.callback(NO, error);
            return;
        }

        //登陆成功
        @strongify(self);
        if (login == 1) {
            [self bindUser:userInfo];
        } else {
            self.callback(NO, nil);
        }
    }];
}

//绑定用户
- (void)bindUser:(NSDictionary *)dic {
    @weakify(self);
    [self.viewModel to_doBindingUserWithUserInfo:dic callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        @strongify(self);
        if (error) {
            self.callback(NO, error);
        } else {
            //存储用户id
            ToBindingUserRepModel *model = [ToBindingUserRepModel TOMJ_objectWithKeyValues:jsonDic];
            
            if (model.status == 200) {
                [[TOUserDefault sharedTOUserDefault] setSysUserId:model.data.sysUserId];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.callback(YES, nil);
                    [self clickBack];
                });
                
            } else if (model.status == 10040) {
                UIViewController *vc = [TOSDKUtil currentViewController];
                [vc.view makeToast:model.msg duration:0.5 position:MAToastPositionBottom];
                [self.viewModel to_doDotActionWithEventId:DO_WX_LOGIN_FAIL_BOUND callback:nil];
                self.callback(NO, nil);
            } else if (model.status == 100004) {
                UIViewController *vc = [TOSDKUtil currentViewController];
                [vc.view makeToast:model.msg duration:0.5 position:MAToastPositionBottom];
                [self.viewModel to_doDotActionWithEventId:DO_WX_LOGIN_FAIL_SIGN callback:nil];
                self.callback(NO, nil);
            }  else {
                self.callback(NO, nil);
            }
            
        }
    }];
}

- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (TOViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TOViewModel alloc]init];
    }
    return _viewModel;
}
@end

