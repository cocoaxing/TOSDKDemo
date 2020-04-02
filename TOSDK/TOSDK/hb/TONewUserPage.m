//
//  TONewUserPage.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TONewUserPage.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "TOViewModel.h"

#import "TORewardHUD.h"
#import "TOReceiveHUD.h"
#import "TOUserDefault.h"
#import "TOLoViewController.h"

#import "TORoundAwardRepModel.h"

#import "TOTxManager.h"
#import "UIView+MAToast.h"
@interface TONewUserPage ()
@property (nonatomic, strong) TOViewModel *viewModel;
@end
@implementation TONewUserPage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubView];
    }
    return self;
}

//点击就送 y值是中心
- (void)addSubView {
    
    NSString *hb = _NSStringFromBbString(TO_BB_HB);
    NSString *tx = _NSStringFromBbString(TO_BB_TX);
    NSString *yan = _NSStringFromBbString(TO_BB_Y);
    NSString *wx = _NSStringFromBbString(TO_BB_WX);
    @weakify(self);
    [TOSDKUtil imageWithName:@"ic_xrhbbg@2x.png" callback:^(id  _Nonnull obj) {
        @strongify(self);
        if (obj) {
            UIImage *image = obj;
            self.bgImageView.image = image;
        }
    }];
    
    //关闭
    CGFloat rightMargin = 46;
    if (IsIphone55c5sse) {
        rightMargin = 40;
    }
    UIImage *closeImg = [UIImage imageInBundleWithName:@"关闭.png" class:[self class]];
    UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    closeBtn.frame = CGRectMake(CGRectGetMaxX(self.bgImageView.frame) - rightMargin, self.bgImageView.tx_y + 18, 25, 25);
    [closeBtn setImage:closeImg forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(clickCloseView) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:closeBtn];
    
    UILabel *cashLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bgImageView.tx_centerY - 10, self.bounds.size.width, 38)];
    cashLabel.textAlignment = NSTextAlignmentCenter;
    cashLabel.textColor = kColorWithHEX(0xf2e5b6, 1.0f);
    cashLabel.font = [UIFont boldSystemFontOfSize:38];
    [self addSubview:cashLabel];
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bgImageView.tx_y + 30, self.bounds.size.width, 24)];
    titleLabel.text = [NSString stringWithFormat:@"新人%@", hb];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kColorWithHEX(0xf2e5b6, 1.0f);
    titleLabel.font = [UIFont systemFontOfSize:24];
    [self addSubview:titleLabel];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cashLabel.tx_bottom + 10, 58, 26)];
    tipLabel.tx_centerX = self.bgImageView.tx_centerX;
    tipLabel.layer.cornerRadius = 4;
    tipLabel.layer.borderColor = kYColorWithHEXAlpha(0Xf2e5b6).CGColor;
    tipLabel.layer.borderWidth = 1;
    tipLabel.text = [NSString stringWithFormat:@"可%@", tx];
    tipLabel.textColor = kYColorWithHEXAlpha(0Xf2e5b6);
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipLabel];
    
    //标题
    UILabel *titleTipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tipLabel.tx_bottom + 22, self.bounds.size.width, 12)];
    titleTipLabel.text = [NSString stringWithFormat:@"%@成功授权后可获得5%@%@",wx,  yan, hb];
    titleTipLabel.textAlignment = NSTextAlignmentCenter;
    titleTipLabel.textColor = kColorWithHEX(0xffffff, 0.6f);
    titleTipLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:titleTipLabel];
    
    //标题
    UILabel *bottomTipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bgImageView.tx_bottom - 23, self.bounds.size.width, 12)];
    bottomTipLabel.text = [NSString stringWithFormat:@"%@授权后才可进行%@", wx, tx];
    bottomTipLabel.textAlignment = NSTextAlignmentCenter;
    bottomTipLabel.textColor = kColorWithHEX(0xfff3b5, 1.0f);
    bottomTipLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:bottomTipLabel];
    
    //领
    CGFloat y = titleTipLabel.tx_centerY + 22;
    CGFloat getBtnMargin = 30;
    if (IsIphone55c5sse) {
        getBtnMargin = 15;
    }
    CGFloat getBtnW = self.bgImageView.tx_width - getBtnMargin * 2;
    CGFloat getBtnH = getBtnW * 0.2;
    UIImage *getImg = [UIImage imageInBundleWithName:@"btn-wxlqbg.png" class:[self class]];
    UIImage *getBgImg = [UIImage imageInBundleWithName:@"icon-wxicon.png" class:[self class]];
    UIButton *getBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [getBtn setBackgroundImage:getImg forState:(UIControlStateNormal)];
    [getBtn setImage:getBgImg forState:(UIControlStateNormal)];
    [getBtn addTarget:self action:@selector(getNewUserPage) forControlEvents:(UIControlEventTouchUpInside)];
    [getBtn setTitle:[NSString stringWithFormat:@"    %@%@", _NSStringFromBbString(TO_BB_WX), _NSStringFromBbString(TO_BB_LQ)] forState:(UIControlStateNormal)];
    [getBtn setTitleColor:kYColorWithHEXAlpha(0x99542b) forState:(UIControlStateNormal)];
    getBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    getBtn.frame = CGRectMake(0, y, getBtnW, getBtnH);
    getBtn.tx_centerX = self.bgImageView.tx_centerX;
    [self addSubview:getBtn];
    
    [self voiceCircleRun:getBtn];
    
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_XR_HB_POP callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
}

- (void)voiceCircleRun:(UIView *)view {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 0.5;
    scaleAnimation.repeatCount = HUGE_VALF;
    scaleAnimation.autoreverses = YES;
    //removedOnCompletion为NO保证app切换到后台动画再切回来时动画依然执行
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fromValue = @(.9);
    scaleAnimation.toValue = @(1.0);
    [view.layer addAnimation:scaleAnimation forKey:@"scale-layer"];
}

//不使用时记得移除动画
- (void)voiceCircleStop {
    [self.layer removeAllAnimations];
}

- (void)getNewUserPage {
    
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_XR_HB_WX_LQ_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    
    NSString *sysUserId = [[TOUserDefault sharedTOUserDefault] getOpenId];
    if (sysUserId.length > 0) {
        [self clickCloseView];
        [self uploadRedPacket];
    } else {
        //跳转到未登录界面
        [self clickWxLogin:^(BOOL isAuth, NSError * _Nullable error) {
            if (error) {
                TOLog(@"TOSDK_LOG: w .x.授权出错: %@", error);
            } else {
                if (isAuth) {
                    TOLog(@"TOSDK_LOG: w .x.授权成功");
                    [self clickCloseView];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self uploadRedPacket];
                    });
                    
                } else {
                    TOLog(@"TOSDK_LOG: w .x.授权或绑定失败");
                    [self clickCloseView];
                }
            }
        }];
       
    }
}

- (void)uploadRedPacket {
    NSString *lq = _NSStringFromBbString(TO_BB_LQ);
    NSString *jl = _NSStringFromBbString(TO_BB_JL);
    NSString *zh = _NSStringFromBbString(TO_BB_ZH);
    NSString *hb = _NSStringFromBbString(TO_BB_HB);
    UIViewController *vc = [TOSDKUtil currentViewController];
    BOOL flag = [[TOUserDefault sharedTOUserDefault] getUserFlag];
    if (flag) {
        [self clickCloseView];
        TOTxManager *mgr = [TOTxManager sharedInstance];
        [mgr showXjinJliWithDelegate:mgr.cashRewardDelegate];
        [vc.view makeToast:[NSString stringWithFormat:@"您已%@过新手%@，快去%@取%@%@吧！", lq, jl, zh, hb, jl] duration:1 position:MAToastPositionBottom];
        return;
    }
    @weakify(self);
    [self.viewModel to_doLQHongPaWithCallback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        @strongify(self);
        if (error) {
            [vc.view makeToast:[NSString stringWithFormat:@"新人%@%@出错", hb, lq] duration:0.3 position:MAToastPositionCenter];
            [self rewardFailCallBack:[NSString stringWithFormat:@"%@", error]];
        } else {
            //弹窗, 领取成功
            UIViewController *vc = [TOSDKUtil currentViewController];
            //弹窗, 领取成功
            TORoundAwardRepModel *info = [TORoundAwardRepModel  TOMJ_objectWithKeyValues:jsonDic];
            if (info.status == 200) {
                [[TOUserDefault sharedTOUserDefault] setCurrentLeftRP:[info.data.leftRP floatValue]];
                [[TOUserDefault sharedTOUserDefault] setNewUserFlag:info.data.isNURP];
                [[TOPopManager sharedInstance] popRewardWithXj:info.data.currentRP ye:info.data.leftRP isN:YES];
                [self rewardSuccessCallbackWithBalance:[info.data.leftRP floatValue]];
            } else {
                [self rewardFailCallBack:[NSString stringWithFormat:@"%@", info.msg]];
                [vc.view makeToast:[NSString stringWithFormat:@"%@", info.msg] duration:0.5 position:MAToastPositionCenter];
            }
        }
    }];
}

- (void)rewardSuccessCallbackWithBalance:(CGFloat)balance {
    if ([self.delegate respondsToSelector:@selector(userPage:onXjinJliSuccess:)]) {
        [self.delegate userPage:self onXjinJliSuccess:balance];
    }
}

- (void)rewardFailCallBack:(NSString *)msg {
    if ([self.delegate respondsToSelector:@selector(userPage:onXjinJliFailed:)]) {
        [self.delegate userPage:self onXjinJliFailed:msg];
    }
}

- (void)clickCloseView {
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_XR_HB_CLOSE_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = .0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self voiceCircleStop];
    }];
    
}

- (TOViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TOViewModel alloc]init];
    }
    return _viewModel;
}

@end
