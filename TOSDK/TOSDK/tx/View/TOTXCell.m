//
//  TOTXCell.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/17.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOTXCell.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "UIImage+Extension.h"
#import "TOTXConfigListModel.h"
#import "TOUserDefault.h"
@interface TOTXCell ()
@property (nonatomic, strong) UILabel *jeLabel;
@property (nonatomic, strong) UILabel *jdLabel;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIImageView *bImageView;
@end

@implementation TOTXCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.layer.borderColor = kColorWithHEX(0xff855b, 0.3f).CGColor;
    self.layer.borderWidth = 1;
    
    UILabel *yLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height * 0.5-20, self.bounds.size.width, 20)];
    yLabel.text = @"";
    yLabel.textColor = kColorWithHEX(0xff7819, 1.0f);
    yLabel.font = [UIFont boldSystemFontOfSize:18];
    yLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:yLabel];
    _jeLabel = yLabel;
    
    UILabel *beanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yLabel.tx_bottom+2, self.bounds.size.width, 15)];
    beanLabel.text = @"";
    beanLabel.textColor = kColorWithHEX(0x333333, .6f);
    beanLabel.font = [UIFont systemFontOfSize:11];
    beanLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:beanLabel];
    _jdLabel = beanLabel;
    
    //剩余
    UILabel *lLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, beanLabel.tx_bottom, self.bounds.size.width, 13)];
    lLabel.text = @"(仅剩2000份)";
    lLabel.textColor = kColorWithHEX(0x333333, .6f);
    lLabel.font = [UIFont systemFontOfSize:9];
    lLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lLabel];
    [lLabel setHidden:YES];
    _leftLabel = lLabel;
    
    UIImage *img = [UIImage imageInBundleWithName:@"选中背景.png" class:[self class]];
    UIImageView *selImageView = [[UIImageView alloc]initWithFrame:CGRectMake(-1, -1, self.bounds.size.width + 2, self.bounds.size.height + 2)];
    selImageView.layer.cornerRadius = 10;
    selImageView.layer.masksToBounds = YES;
    selImageView.image = img;
    self.selectedBackgroundView = selImageView;
    
    UIImage *bageImg = [UIImage imageInBundleWithName:@"xrzsjb.png" class:[self class]];
    UIImageView *bageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(-1, -1, self.bounds.size.width * 0.5, self.bounds.size.width * 0.5 * 0.58)];
    bageImageView.image = bageImg;
    [self addSubview:bageImageView];
    [self.bImageView setHidden:YES];
    self.bImageView = bageImageView;
}

- (void)setDataModel:(TOTXConfigListDataModel *)dataModel {
    _dataModel = dataModel;
    _jeLabel.text = [NSString stringWithFormat:@"%@%@", dataModel.ppinc, _NSStringFromBbString(TO_BB_Y)];
    _jdLabel.text = [NSString stringWithFormat:@"%@%@", dataModel.ppjb, _NSStringFromBbString(TO_BB_JB)];
    NSString *userId = [[TOUserDefault sharedTOUserDefault] getOpenId];
    if (dataModel.leftCount >= 0 && userId.length > 0 && self.isEnough && [dataModel.ppinc isEqualToString:@"1"]) {
        [_leftLabel setHidden:NO];
        _leftLabel.text = [NSString stringWithFormat:@"(仅剩%ld份)", (long)dataModel.leftCount < 0 ? 0 : (long)dataModel.leftCount];
    } else {
        [_leftLabel setHidden:YES];
    }
    
    if (dataModel.isNewUser == 1) {
        [self.bImageView setHidden:NO];
    } else {
        [self.bImageView setHidden:YES];
    }
}


- (void)setToSelected:(BOOL)toSelected {
    _toSelected = toSelected;
    if (toSelected) {
        _jeLabel.textColor = [UIColor whiteColor];
        _jdLabel.textColor = [UIColor whiteColor];
        _leftLabel.textColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
    } else {
        _jeLabel.textColor = kColorWithHEX(0xff7819, 1.0f);;
        _jdLabel.textColor = kColorWithHEX(0x333333, .6f);
        _leftLabel.textColor = kColorWithHEX(0x333333, .6f);
        self.layer.cornerRadius = 10;
        self.layer.borderColor = kColorWithHEX(0xff855b, 0.3f).CGColor;
        self.layer.borderWidth = 1;
    }
    
    
}

- (void)setIsEnough:(BOOL)isEnough {
    _isEnough = isEnough;
}

@end
