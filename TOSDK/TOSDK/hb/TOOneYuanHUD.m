//
//  TOOneYuanHUD.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/25.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOOneYuanHUD.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "TOUserDefault.h"
@interface TOOneYuanHUD ()
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *tipSecLabel;
@property (nonatomic, strong) UIButton *getBtn;
@end

@implementation TOOneYuanHUD

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.alpha = 0.6f;
    bgView.backgroundColor = [UIColor blackColor];
    [self addSubview:bgView];
    
    CGFloat imgMargin = 40;
    if (IsIphone55c5sse) {
        imgMargin = 30;
    }
    UIImage *img = [UIImage imageInBundleWithName:@"lwtc.png" class:[self class]];
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:img];
    CGFloat height = 0.78*(TO_Width - imgMargin * 2);
    bgImageView.frame = CGRectMake(imgMargin, 0.5 * (TO_Height - height), TO_Width-imgMargin * 2, height);
    [self addSubview:bgImageView];
    
    UILabel *tipSecLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, TO_Width, 15)];
    tipSecLabel.textColor = [UIColor whiteColor];
    tipSecLabel.font = [UIFont systemFontOfSize:12];
    tipSecLabel.text = @"";
    tipSecLabel.textAlignment = NSTextAlignmentCenter;
    tipSecLabel.center = bgImageView.center;
    [self addSubview:tipSecLabel];
    _tipSecLabel = tipSecLabel;
    
    UIButton *getBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    getBtn.frame = CGRectMake(bgImageView.tx_x + 30, tipSecLabel.tx_bottom + 28, bgImageView.tx_width - 60, 0.21*(bgImageView.tx_width - 60));
    getBtn.tx_centerX = tipSecLabel.tx_centerX;
    [TOSDKUtil imageWithName:@"images/more.png" callback:^(id  _Nonnull obj) {
        if (obj) {
            UIImage *image = obj;
            [getBtn setImage:image forState:(UIControlStateNormal)];
        }
    }];
    [getBtn addTarget:self action:@selector(getMore) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:getBtn];
    _getBtn = getBtn;
    
    CGFloat tipHeight = 66;
    CGFloat font = 18;
    if (IsIphone55c5sse) {
        tipHeight = 80;
        font = 16;
    }
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tipSecLabel.tx_y - 78, bgImageView.tx_width - 40, tipHeight)];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.numberOfLines = 0;
    tipLabel.font = [UIFont boldSystemFontOfSize:font];
    tipLabel.text = [NSString stringWithFormat:@"很遗憾\n今天的1%@份额已领光\n先去%@更多%@明天一起领吧！", _NSStringFromBbString(TO_BB_Y), _NSStringFromBbString(TO_BB_ZH), _NSStringFromBbString(TO_BB_Q)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.tx_centerX = bgImageView.tx_centerX;
    [self addSubview:tipLabel];
    _tipLabel = tipLabel;
    
}

- (void)setApplyCount:(NSInteger)applyCount {
    _applyCount = applyCount;
    if (applyCount > 0) {
        [_tipSecLabel setHidden:NO];
        _tipSecLabel.text = [NSString stringWithFormat:@"(每天限量%ld份, 00:00重置)", (long)applyCount];
        
    } else {
        [_tipSecLabel setHidden:YES];
        UIImage *getImg = [UIImage imageInBundleWithName:@"btn-我知道了.png" class:[self class]];
        [_getBtn setImage:getImg forState:(UIControlStateNormal)];
        
    }
}

- (void)setIsShowTip:(BOOL)isShowTip {
    _isShowTip = isShowTip;
    if (isShowTip) {
        [_tipSecLabel setHidden:NO];
        _tipSecLabel.text = [NSString stringWithFormat:@"(每天限量%ld份, 00:00重置)", (long)_applyCount];
        
    } else {
        [_tipSecLabel setHidden:YES];
    }

    NSString *eventId = DO_ME_LJTX_SIGN_POP;
    if (self.isShowTip) {
        eventId = DO_ME_LJTX_NONELEFT_POP;
    }
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:eventId callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    _tipLabel.text = message;
}

- (void)getMore {
    NSString *eventId = DO_ME_LJTX_SIGN_JXZQ_BTN;
    if (self.isShowTip) {
        eventId = DO_ME_LJTX_NONELEFT_JXZQ_BTN;
    }
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:eventId callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    UIViewController *vc = [TOSDKUtil currentViewController];
    [self removeFromSuperview];
    [vc dismissViewControllerAnimated:YES completion:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
