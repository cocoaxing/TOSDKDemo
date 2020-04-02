//
//  TOXJCell.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/18.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOXJCell.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "UIImage+Extension.h"
#import "TORPConfigList.h"
@interface TOXJCell ()
@property (nonatomic, strong) UILabel *xjLabel;
@end
@implementation TOXJCell
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
    
    UILabel *yLabel = [[UILabel alloc]initWithFrame:self.bounds];
    yLabel.text = @"";
    yLabel.textColor = kColorWithHEX(0xff7819, 1.0f);
    yLabel.font = [UIFont boldSystemFontOfSize:18];
    yLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:yLabel];
    _xjLabel = yLabel;
    
    UIImage *img = [UIImage imageInBundleWithName:@"选中背景.png" class:[self class]];
    UIImageView *selImageView = [[UIImageView alloc]init];
    selImageView.layer.cornerRadius = 10;
    selImageView.layer.masksToBounds = YES;
    selImageView.image = img;
    self.selectedBackgroundView = selImageView;
    
}

- (void)setDataModel:(TORPConfigListData *)dataModel {
    _dataModel = dataModel;
    _xjLabel.text = [NSString stringWithFormat:@"%@%@", dataModel.ppinc, _NSStringFromBbString(TO_BB_Y)];
}

- (void)setToSelected:(BOOL)toSelected {
    _toSelected = toSelected;
    if (toSelected) {
        _xjLabel.textColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
    } else {
        _xjLabel.textColor = kColorWithHEX(0xff7819, 1.0f);
        self.layer.cornerRadius = 10;
        self.layer.borderColor = kColorWithHEX(0xff855b, 0.3f).CGColor;
        self.layer.borderWidth = 1;
    }
}

@end
