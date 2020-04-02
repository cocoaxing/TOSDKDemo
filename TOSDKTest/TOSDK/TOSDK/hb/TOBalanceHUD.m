//
//  TOBalanceHUD.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/26.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBalanceHUD.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "LMJVerticalScrollText.h"
@interface TOBalanceHUD ()
@property (nonatomic, strong) UILabel *yeLabel;
@property (nonatomic, strong) UILabel *yeTipLabel;
@property (nonatomic, strong) LMJVerticalScrollText * verticalScrollText;
@end
@implementation TOBalanceHUD

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
    
    //关闭
    UIImage *closeImg = [UIImage imageInBundleWithName:@"关闭.png" class:[self class]];
    UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    closeBtn.frame = CGRectMake(CGRectGetMaxX(self.bgImageView.frame) - 46, self.bgImageView.tx_y + 18, 25, 25);
    [closeBtn setImage:closeImg forState:(UIControlStateNormal)];
    [closeBtn addTarget:self action:@selector(clickCloseView) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:closeBtn];
    
    UILabel *jeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 24)];
    jeLabel.text = @"";
    jeLabel.textAlignment = NSTextAlignmentCenter;
    jeLabel.textColor = kColorWithHEX(0x701f13, 1.0f);
    jeLabel.font = [UIFont boldSystemFontOfSize:24];
    jeLabel.tx_centerY = self.bgImageView.tx_centerY;
    [self addSubview:jeLabel];
    _yeLabel = jeLabel;
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, jeLabel.tx_bottom + 12, self.bounds.size.width, 14)];
    tipLabel.text = @"";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kColorWithHEX(0x701f13, 1.0f);
    tipLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:tipLabel];
    _yeTipLabel = tipLabel;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bgImageView.tx_y + 55, self.bounds.size.width, 17)];
    titleLabel.text = [NSString stringWithFormat:@"累计%@", _NSStringFromBbString(TO_BB_HB)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kColorWithHEX(0xf2e5b6, 1.0f);
    titleLabel.font = [UIFont systemFontOfSize:24];
    [self addSubview:titleLabel];
    
    NSString *tipOne = _NSStringFromBbString(TO_BB_XJ);
    NSString *tipwTwo = _NSStringFromBbString(TO_BB_HB);
    NSString *tipThree = _NSStringFromBbString(TO_BB_WX);
    NSString *tipFour = _NSStringFromBbString(TO_BB_Y);
    NSString *tipFive = _NSStringFromBbString(TO_BB_TX);
    _verticalScrollText = [[LMJVerticalScrollText alloc] initWithFrame:CGRectMake(0, self.bgImageView.tx_bottom - 54, self.bounds.size.width, 30)];
    _verticalScrollText.textStayTime        = 1;
    _verticalScrollText.scrollAnimationTime = 0.5;
    _verticalScrollText.backgroundColor     = [UIColor clearColor];
    _verticalScrollText.textColor           = kColorWithHEX(0x701f13, 1.0f);
    _verticalScrollText.textFont            = [UIFont systemFontOfSize:11];
    _verticalScrollText.textAlignment       = NSTextAlignmentCenter;
    _verticalScrollText.touchEnable         = YES;
    _verticalScrollText.textDataArr         = @[[NSString stringWithFormat:@"玩游戏可以获得%@%@", tipOne, tipwTwo],
                                                [NSString stringWithFormat:@"%@%@可以直接%@到%@", tipOne, tipwTwo, tipFive, tipThree],
                                                [NSString stringWithFormat:@"最高可以%@300%@", tipFive, tipFour]];
    _verticalScrollText.layer.cornerRadius  = 3;
    [self addSubview:_verticalScrollText];
    
    [_verticalScrollText startScrollBottomToTopWithNoSpace];
    
    CGFloat getBtnBottomMargin = 100;
    if (IsIphone55c5sse) {
        getBtnBottomMargin = 70;
    }
    
    //领
    UIImage *getImg = [UIImage imageInBundleWithName:@"btn-jxzqbg.png" class:[self class]];
    UIButton *getBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [getBtn setBackgroundImage:getImg forState:(UIControlStateNormal)];
    [getBtn setTitle:[NSString stringWithFormat:@"%@更多%@", _NSStringFromBbString(TO_BB_ZH), _NSStringFromBbString(TO_BB_Q)] forState:(UIControlStateNormal)];
    [getBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    getBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [getBtn addTarget:self action:@selector(clickContinue) forControlEvents:(UIControlEventTouchUpInside)];
    getBtn.frame = CGRectMake(0, _verticalScrollText.tx_y - getBtnBottomMargin, 240, 44);
    getBtn.tx_centerX = self.bgImageView.tx_centerX;
    [self addSubview:getBtn];
    
    [self voiceCircleRun:getBtn];
    
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_LJ_HB_POP callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    
}

- (void)setYe:(NSString *)ye {
    _ye = ye;
    _yeLabel.text = [NSString stringWithFormat:@"%@: %@%@", _NSStringFromBbString(TO_BB_YE), ye, _NSStringFromBbString(TO_BB_Y)];
    
    CGFloat yeInt = [ye floatValue];
    if (yeInt >= 100) {
        [_yeTipLabel setHidden:YES];
    } else {
        yeInt = 100 - yeInt;
        [_yeTipLabel setHidden:NO];
        _yeTipLabel.text = [NSString stringWithFormat:@"再%@%.2f%@即可%@", _NSStringFromBbString(TO_BB_ZH), yeInt, _NSStringFromBbString(TO_BB_Y), _NSStringFromBbString(TO_BB_TX)];
    }
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

- (void)clickContinue {
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_LJ_HB_JXZQ_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = .0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self voiceCircleStop];
    }];
}
- (void)clickCloseView {
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_LJ_HB_CLOSE_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = .0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self voiceCircleStop];
    }];
}

@end
