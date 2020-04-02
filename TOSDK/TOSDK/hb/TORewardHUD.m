//
//  TORewardHUD.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TORewardHUD.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "TOViewModel.h"

#import "TOReceiveHUD.h"

#import "TORoundAwardRepModel.h"

#import "TOTxManager.h"
#import "TOUserDefault.h"
#import "TOViewModel.h"
#import "TOUserRPInfo.h"
#import "TOLoViewController.h"
#import "UIView+MAToast.h"
@interface TORewardHUD ()
@property (nonatomic, strong) TOViewModel *viewModel;
@end

@implementation TORewardHUD

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
    
    UIImage *bgImg = [UIImage imageInBundleWithName:@"lqqthbbj.png" class:[self class]];
    self.bgImageView.image = bgImg;
    
    //关闭
    CGFloat rightMargin = 46;
    if (IsIphone55c5sse) {
        rightMargin = 40;
    }
    
    //关闭
    UIImage *closeImg = [UIImage imageInBundleWithName:@"关闭.png" class:[self class]];
    UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    closeBtn.frame = CGRectMake(CGRectGetMaxX(self.bgImageView.frame) - rightMargin, self.bgImageView.tx_y + 18, 25, 25);
    [closeBtn setImage:closeImg forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(clickCloseView) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:closeBtn];
    
    
    UILabel *cashLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bgImageView.tx_centerY - 44, self.bounds.size.width, 24)];
    cashLabel.text = [NSString stringWithFormat:@"最高10%@%@%@", _NSStringFromBbString(TO_BB_Y), _NSStringFromBbString(TO_BB_XJ), _NSStringFromBbString(TO_BB_HB)];
    cashLabel.textAlignment = NSTextAlignmentCenter;
    cashLabel.textColor = kColorWithHEX(0xf2e5b6, 1.0f);
    cashLabel.font = [UIFont systemFontOfSize:24];
    [self addSubview:cashLabel];
    //标题
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cashLabel.tx_y - 62, self.bounds.size.width, 20)];
    titleLabel.text = app_Name;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kColorWithHEX(0xf2e5b6, 1.0f);
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:titleLabel];
    
    CGFloat iconW = 90;
    if (IsIphone55c5sse) {
        iconW = 80;
    }
    //logo
    NSString *icon = [[infoDictionary valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage *getIconImg = [UIImage imageNamed:icon];
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleLabel.tx_y - (iconW + 5), iconW, iconW)];
    iconImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    iconImageView.tx_centerX = self.bgImageView.tx_centerX;
    iconImageView.layer.cornerRadius = 10;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.image = getIconImg;
    [self addSubview:iconImageView];
    
    //领
    CGFloat y = self.bgImageView.tx_centerY + 20;
    UIButton *getBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [TOSDKUtil imageWithName:@"ic_lzan@2x.png" callback:^(id  _Nonnull obj) {
        
        if (obj) {
            UIImage *image = obj;
            [getBtn setImage:image forState:(UIControlStateNormal)];
        }
    }];
    
    getBtn.frame = CGRectMake(0, y, 110, 110);
    getBtn.tx_centerX = self.bgImageView.tx_centerX;
    [getBtn addTarget:self action:@selector(getPage) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:getBtn];

    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, getBtn.tx_bottom + 30, 58, 26)];
    tipLabel.tx_centerX = self.bgImageView.tx_centerX;
    tipLabel.layer.cornerRadius = 4;
    tipLabel.layer.borderColor = kYColorWithHEXAlpha(0Xf2e5b6).CGColor;
    tipLabel.layer.borderWidth = 1;
    tipLabel.text = [NSString stringWithFormat:@"可%@", _NSStringFromBbString(TO_BB_TX)];
    tipLabel.textColor = kYColorWithHEXAlpha(0Xf2e5b6);
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipLabel];
    [self voiceCircleRun:getBtn];
    
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_XJ_HB_POP callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
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

- (void)getPage {
    
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_XJ_HB_LQ_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    
    NSString *sysUserId = [[TOUserDefault sharedTOUserDefault] getOpenId];
    if (sysUserId.length > 0) {
        //已绑定w .x.
        [self uploadRedPacket];
    } else {
        
        [self clickWxLogin:^(BOOL isAuth, NSError * _Nullable error) {
            if (error) {
                TOLog(@"TOSDK_LOG: w .x.授权出错: %@", error);
            } else {
                if (isAuth) {
                    TOLog(@"TOSDK_LOG: w .x.授权成功");
                    [self uploadRedPacket];
                } else {
                    TOLog(@"TOSDK_LOG: w .x.授权或绑定失败");
                    [self clickCloseView];
                }
            }
        }];
    }
}

- (void)uploadRedPacket {
    
    //已绑定w .x.
    @weakify(self);
    UIViewController *vc = [TOSDKUtil currentViewController];
    [self.viewModel to_doLQHongPaWithCallback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        @strongify(self);
        if (error) {
            [vc.view makeToast:[NSString stringWithFormat:@"%@", error.description] duration:0.5 position:MAToastPositionCenter];
            [self rewardFailCallBack:[NSString stringWithFormat:@"%@", error]];
        } else {
            [self clickCloseView];
            //弹窗, 领取成功
            TORoundAwardRepModel *info = [TORoundAwardRepModel  TOMJ_objectWithKeyValues:jsonDic];
            if (info.status == 200) {
                [[TOUserDefault sharedTOUserDefault] setCurrentLeftRP:[info.data.leftRP floatValue]];
                [[TOPopManager sharedInstance] popRewardWithXj:info.data.currentRP ye:info.data.leftRP isN:NO];
                [self rewardSuccessCallbackWithBalance:[info.data.leftRP floatValue]];
            } else {
                [self rewardFailCallBack:[NSString stringWithFormat:@"%@", info.msg]];
                [vc.view makeToast:[NSString stringWithFormat:@"%@", info.msg] duration:0.5 position:MAToastPositionCenter];
            }
        }
    }];
}

- (void)rewardSuccessCallbackWithBalance:(CGFloat)balance {
    if ([self.delegate respondsToSelector:@selector(rewardHUD:onXjinJliSuccess:)]) {
        [self.delegate rewardHUD:self onXjinJliSuccess:balance];
    }
}

- (void)rewardFailCallBack:(NSString *)msg {
    if ([self.delegate respondsToSelector:@selector(rewardHUD:onXjinJliFailed:)]) {
        [self.delegate rewardHUD:self onXjinJliFailed:msg];
    }
}

- (void)clickCloseView {
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_XJ_HB_CLOSE_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
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
