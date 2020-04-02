//
//  TOFeedHUD.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOFeedHUD.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "TOUserDefault.h"
@interface TOFeedHUD ()

@end

@implementation TOFeedHUD

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
    CGFloat vHeight = 1.2*(TO_Width - imgMargin * 2);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(imgMargin, 0.5 * (TO_Height - vHeight), TO_Width-imgMargin * 2, vHeight)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 25;
    [self addSubview:view];
    
    UIImage *img = [UIImage imageInBundleWithName:@"img-fkch.png" class:[self class]];
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:img];
    bgImageView.contentMode = UIViewContentModeScaleToFill;
    bgImageView.frame = CGRectMake(0, 0, view.tx_width, 0.51 * view.tx_width);
    [view addSubview:bgImageView];
    
    CGFloat tipHeight = 60;
    CGFloat font = 14;
    if (IsIphone55c5sse) {
        tipHeight = 60;
        font = 14;
    }
    UILabel *tipTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, bgImageView.tx_bottom + 18, view.tx_width, 16)];
    tipTitleLabel.textColor = kColorWithHEX(0x666666, 1.0f);
    tipTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    tipTitleLabel.text = @"提交反馈成功";
    tipTitleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:tipTitleLabel];

    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tipTitleLabel.tx_bottom + 14, view.tx_width, tipHeight)];
    tipLabel.textColor = kColorWithHEX(0x666666, 1.0f);
    tipLabel.numberOfLines = 0;
    tipLabel.font = [UIFont systemFontOfSize:font];
    tipLabel.text = [NSString stringWithFormat:@"运营同学已经收到您的反馈了\n会尽快回复您\n现在去%@更多%@吧", _NSStringFromBbString(TO_BB_ZH), _NSStringFromBbString(TO_BB_Q)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:tipLabel];

    CGFloat getBtnW = view.tx_width - 60;
    CGFloat getBtnH = 0.21*getBtnW;
    UIButton *getBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    getBtn.frame = CGRectMake(30, view.tx_height - 14 - getBtnH, getBtnW, getBtnH);
    [getBtn setTitle:[NSString stringWithFormat:@"继续%@%@", _NSStringFromBbString(TO_BB_ZH), _NSStringFromBbString(TO_BB_Q)] forState:(UIControlStateNormal)];
    [getBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    getBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    UIImage *getBgImg = [UIImage imageInBundleWithName:@"txanbj.png" class:[self class]];
    [getBtn setBackgroundImage:getBgImg forState:(UIControlStateNormal)];
    [getBtn addTarget:self action:@selector(getMore) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:getBtn];
    
}

- (void)getMore {
    [self removeFromSuperview];
    if (self.feedbackCallback) {
        self.feedbackCallback();
    }
}

@end
