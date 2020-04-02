//
//  TOLackHUD.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/25.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOLackHUD.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"

@interface TOLackHUD ()
@property (nonatomic, strong) UILabel *tipLabel;
@end
@implementation TOLackHUD

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
    
    UIImage *img = [UIImage imageInBundleWithName:@"yebztctx.png" class:[self class]];
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:img];
    CGFloat height = 0.96*(TO_Width - 80);
    bgImageView.frame = CGRectMake(40, 0.5 * (TO_Height - height), TO_Width-80, height);
    [self addSubview:bgImageView];
    
    CGFloat margin = 30;
    if (IsIphone55c5sse) {
        margin = 15;
    }
    UIImage *insertImg = [UIImage imageInBundleWithName:@"yebzchbj.png" class:[self class]];
    UIImageView *insertImageView = [[UIImageView alloc]initWithImage:insertImg];
    insertImageView.frame = CGRectMake(0, 0, bgImageView.tx_width-margin * 2, (bgImageView.tx_width-margin * 2) * 0.54);
    insertImageView.center = bgImageView.center;
    [self addSubview:insertImageView];
    
    UILabel *insertTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, insertImageView.tx_y + 14, 180, 15)];
    insertTitleLabel.textColor = [UIColor whiteColor];
    insertTitleLabel.numberOfLines = 0;
    insertTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    insertTitleLabel.text = @"游戏小技巧";
    insertTitleLabel.textAlignment = NSTextAlignmentLeft;
    insertTitleLabel.tx_centerX = insertImageView.tx_centerX;
    [self addSubview:insertTitleLabel];
    UILabel *insertLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(insertTitleLabel.frame) + 2, 180, 50)];
    insertLabel.textColor = [UIColor whiteColor];
    insertLabel.numberOfLines = 0;
    insertLabel.font = [UIFont systemFontOfSize:13];
    insertLabel.text = [NSString stringWithFormat:@"玩游戏可以%@到更多%@\n%@%@可以直接%@到%@\n最高可以%@到300%@哦", _NSStringFromBbString(TO_BB_ZH), _NSStringFromBbString(TO_BB_JB), _NSStringFromBbString(TO_BB_XJ), _NSStringFromBbString(TO_BB_HB), _NSStringFromBbString(TO_BB_TX), _NSStringFromBbString(TO_BB_WX), _NSStringFromBbString(TO_BB_ZH), _NSStringFromBbString(TO_BB_Y)];
    insertLabel.textAlignment = NSTextAlignmentLeft;
    insertLabel.tx_centerX = insertImageView.tx_centerX;
    [self addSubview:insertLabel];
    
    UIButton *getBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    getBtn.frame = CGRectMake(bgImageView.tx_x + 30, insertImageView.tx_bottom + 14, bgImageView.tx_width - 60, 0.21 * (bgImageView.tx_width - 60));
    getBtn.tx_centerX = insertImageView.tx_centerX;
    [getBtn addTarget:self action:@selector(getMore) forControlEvents:(UIControlEventTouchUpInside)];
    [TOSDKUtil imageWithName:@"images/gomore.png" callback:^(id  _Nonnull obj) {
        if (obj) {
            UIImage *img = obj;
            [getBtn setImage:img forState:(UIControlStateNormal)];
        }
    }];
    [self addSubview:getBtn];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, insertImageView.tx_y - 43, TO_Width, 15)];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.numberOfLines = 0;
    tipLabel.font = [UIFont boldSystemFontOfSize:18];
    tipLabel.text = [NSString stringWithFormat:@"抱歉，%@不足", _NSStringFromBbString(TO_BB_YE)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.tx_centerX = bgImageView.tx_centerX;
    [self addSubview:tipLabel];
    _tipLabel = tipLabel;
    
}

- (void)setIsT:(BOOL)isT {
    _isT = isT;
    
    NSString *eventId = DO_ME_XJHB_YEBZ_POP;
    if (self.isT) {
        eventId = DO_ME_TXJB_YEBZ_POP;
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
    NSString *eventId = DO_ME_XJHB_YEBZ_JXZQ_BTN;
    if (self.isT) {
        eventId = DO_ME_TXJB_YEBZ_JXZQ_BTN;
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
