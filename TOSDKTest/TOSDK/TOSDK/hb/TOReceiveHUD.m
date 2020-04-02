//
//  TOReceiveHUD.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOReceiveHUD.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "LMJVerticalScrollText.h"
@interface TOReceiveHUD ()
@property (nonatomic, strong) UILabel *xjLabel;
@property (nonatomic, strong) LMJVerticalScrollText * verticalScrollText;
@end
@implementation TOReceiveHUD

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
    
    UILabel *jeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    jeLabel.text = @"";
    jeLabel.textAlignment = NSTextAlignmentCenter;
    jeLabel.textColor = kColorWithHEX(0x701f13, 1.0f);
    jeLabel.font = [UIFont boldSystemFontOfSize:24];
    jeLabel.tx_centerY = self.bgImageView.tx_centerY;
    [self addSubview:jeLabel];
    _xjLabel = jeLabel;
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, jeLabel.tx_bottom + 12, self.bounds.size.width, 17)];
    tipLabel.text = [NSString stringWithFormat:@"已存入%@，可用于%@", _NSStringFromBbString(TO_BB_QB), _NSStringFromBbString(TO_BB_TX)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kColorWithHEX(0x701f13, 1.0f);
    tipLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:tipLabel];

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bgImageView.tx_y + 52, self.bounds.size.width, 17)];
    titleLabel.text = [NSString stringWithFormat:@"%@%@", _NSStringFromBbString(TO_BB_XJ), _NSStringFromBbString(TO_BB_HB)];
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
    
    //领
    CGFloat getBtnBottomMargin = 100;
    if (IsIphone55c5sse) {
        getBtnBottomMargin = 70;
    }
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
    
}

- (void)setIsN:(BOOL)isN {
    _isN = isN;
    NSString *eventId = DO_XJ_HB_LQ_CG_POP;
    if (_isN) {
        eventId = DO_XR_HB_LQ_CG_POP;
    }
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:eventId callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
}

- (void)setXj:(NSString *)xj {
    _xj = xj;
    _xjLabel.text = [NSString stringWithFormat:@"+%@%@", xj, _NSStringFromBbString(TO_BB_Y)];
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
    NSString *eventId = DO_XJ_HB_LQ_CG_JXZQ_BTN;
    if (self.isN) {
        eventId = DO_XR_HB_LQ_CG_JXZQ_BTN;
    }
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:eventId callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = .0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self voiceCircleStop];
    }];
}

- (void)clickCloseView {
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = .0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self voiceCircleStop];
    }];
}
@end
