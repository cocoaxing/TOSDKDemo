//
//  TODetailCell.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/18.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TODetailCell.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "TOWardhtiwList.h"


@interface TODetailCell ()
@property (nonatomic, strong) UILabel *dLabel;
@property (nonatomic, strong) UILabel *cLabel;
@property (nonatomic, strong) UILabel *caLabel;
@property (nonatomic, strong) UILabel *sLabel;
@end

@implementation TODetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    //日期
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.frame = CGRectMake(27, 12, TO_Width, 14);
    dateLabel.font = [UIFont boldSystemFontOfSize:14];
    dateLabel.textColor = [UIColor blackColor];
    dateLabel.text = @"";
    [self addSubview:dateLabel];
    _dLabel = dateLabel;
    //流水号
    UILabel *codeLabel = [[UILabel alloc]init];
    codeLabel.frame = CGRectMake(27, dateLabel.tx_bottom+3, TO_Width * 0.5, 15);
    codeLabel.font = [UIFont boldSystemFontOfSize:11];
    codeLabel.textColor = kColorWithHEX(0x999999, 1.0f);
    codeLabel.text = @"";
    [self addSubview:codeLabel];
    _cLabel = codeLabel;

    UILabel *cashLabel = [[UILabel alloc]init];
    cashLabel.frame = CGRectMake(TO_Width -227, 32, 200, 15);
    cashLabel.textAlignment = NSTextAlignmentRight;
    cashLabel.font = [UIFont boldSystemFontOfSize:14];
    cashLabel.textColor = [UIColor blackColor];
    cashLabel.text = @"";
    [self addSubview:cashLabel];
    _caLabel = cashLabel;
    
    UILabel *stateLabel = [[UILabel alloc]init];
    stateLabel.frame = CGRectMake(27, codeLabel.tx_bottom+3, 200, 15);
    stateLabel.font = [UIFont boldSystemFontOfSize:11];
    stateLabel.textAlignment = NSTextAlignmentLeft;
    stateLabel.textColor = kColorWithHEX(0xFF7819, 1.0f);
    stateLabel.text = @"";
    [self addSubview:stateLabel];
    _sLabel = stateLabel;
}

- (void)setData:(TOWardhtiwListData *)data {
    _data = data;
    _dLabel.text = [TOSDKUtil stringWithMSTimestamp:[data.createdDate integerValue]];
    _cLabel.text = [NSString stringWithFormat:@"流水号: %@", data.orderId];
    _caLabel.text = [NSString stringWithFormat:@"+%@%@", data.ppinc, _NSStringFromBbString(TO_BB_Y)];
    _sLabel.text = data.orderStatusName;
}


@end
