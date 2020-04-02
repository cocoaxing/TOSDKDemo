//
//  TOXJView.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/17.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOXJView.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "TOXJCell.h"
#import "TORPConfigList.h"
#import "UIView+MAToast.h"
#import "TOTxManager.h"
#define LeftMargin 15

@interface TOXJView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) TORPConfigListData *data;
@property (nonatomic, assign) BOOL isRefresh;
@end

static NSString *cellId = @"TOXJCell";

@implementation TOXJView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    //提示横幅
    UIImageView *tipBannerIv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, TO_Width-30, 0.24*(TO_Width-30))];
    tipBannerIv.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:tipBannerIv];
    [TOSDKUtil imageWithName:@"ic_xjhbbanner.png" callback:^(id  _Nonnull obj) {
        if (obj) {
            UIImage *image = obj;
            tipBannerIv.image = obj;
        }
    }];
    
    
    
    UILabel *round2TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(LeftMargin*2, CGRectGetMaxY(tipBannerIv.frame) + 20, 100, 18)];
    round2TitleLabel.textColor = kColorWithHEX(0x333333, 1.0f);
    round2TitleLabel.font = [UIFont systemFontOfSize:14];
    round2TitleLabel.text = [NSString stringWithFormat:@"我的%@%@", _NSStringFromBbString(TO_BB_XJ), _NSStringFromBbString(TO_BB_HB)];
    [self addSubview:round2TitleLabel];
    
    UILabel *round2Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(round2TitleLabel.frame) + 10, round2TitleLabel.tx_y, 120, 18)];
    round2Label.textColor = kColorWithHEX(0xff7819, 1.0f);
    round2Label.font = [UIFont boldSystemFontOfSize:18];
    round2Label.text = @"¥0.00";
    [self addSubview:round2Label];
    _leftLabel = round2Label;
    
    UILabel *chooseTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(LeftMargin*2, CGRectGetMaxY(round2Label.frame) + 14, 150, 20)];
    chooseTitleLabel.textColor = kColorWithHEX(0x333333, 1.0f);
    chooseTitleLabel.font = [UIFont systemFontOfSize:14];
    chooseTitleLabel.text = [NSString stringWithFormat:@"选择%@%@", _NSStringFromBbString(TO_BB_TX), _NSStringFromBbString(TO_BB_JE)];
    [self addSubview:chooseTitleLabel];
    
    UIImage *ruleIcon = [UIImage imageInBundleWithName:@"txgz.png" class:[self class]];
    UIButton *ruleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ruleBtn setImage:ruleIcon forState:(UIControlStateNormal)];
    [ruleBtn setTitle:[NSString stringWithFormat:@"  %@规则", _NSStringFromBbString(TO_BB_TX)] forState:(UIControlStateNormal)];
    [ruleBtn setTitleColor:kColorWithHEX(0xff7819, 1.0f) forState:(UIControlStateNormal)];
    [ruleBtn addTarget:self action:@selector(clickRule) forControlEvents:(UIControlEventTouchUpInside)];
    ruleBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    ruleBtn.frame = CGRectMake(TO_Width - 130, chooseTitleLabel.tx_y, 120, 20);
    [self addSubview:ruleBtn];
    //选项
    CGFloat cellMargin = 20;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat w = (TO_Width - LeftMargin * 4 - cellMargin)/3;
    layout.itemSize = CGSizeMake(w, w * 0.5);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(LeftMargin * 2, chooseTitleLabel.tx_bottom+10, TO_Width - LeftMargin * 4, w * 0.5 + 12) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[TOXJCell class] forCellWithReuseIdentifier:cellId];
    [self addSubview:_collectionView];
    
    UIImage *txBg = [UIImage imageInBundleWithName:@"txanbj.png" class:[self class]];
    UIButton *txBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [txBtn setBackgroundImage:txBg forState:(UIControlStateNormal)];
    [txBtn setTitle:[NSString stringWithFormat:@"立即%@", _NSStringFromBbString(TO_BB_TX)] forState:(UIControlStateNormal)];
    [txBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    txBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    txBtn.frame = CGRectMake(70, _collectionView.tx_bottom+8, TO_Width-140, 60);
    [self addSubview:txBtn];
    [txBtn addTarget:self action:@selector(clickTx) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TOXJCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.dataModel = self.list[indexPath.item];
    if (self.isRefresh) {
        cell.toSelected = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.isRefresh = NO;
    
    TORPConfigListData *model = self.list[indexPath.item];
    self.data = model;
    
    TOXJCell *selectCell = (TOXJCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSArray *cells = [collectionView visibleCells];
    for (TOXJCell *cell in cells) {
        if (selectCell == cell) {
            cell.toSelected = YES;
        } else {
            cell.toSelected = NO;
        }
    }
}

- (void)clickTx {
    
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_ME_LJTX_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    
    if (self.data == nil) {
        [self makeToast:[NSString stringWithFormat:@"请选择%@%@", _NSStringFromBbString(TO_BB_TX), _NSStringFromBbString(TO_BB_JE)] duration:0.5 position:MAToastPositionCenter];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(xjView:handleTxWithData:)]) {
        [self.delegate xjView:self handleTxWithData:self.data];
    }
}


- (void)clickRule {
    if ([self.delegate respondsToSelector:@selector(xjViewRule:)]) {
        [self.delegate xjViewRule:self];
    }
}

- (void)refreshxJUserInfoData:(NSString *)leftRp {
    NSString *str = [NSString stringWithFormat:@"¥%@", leftRp];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 1)];
    self.leftLabel.attributedText = attr;
}

- (void)refreshxJConfigInfoData:(NSArray *)data {
    self.list = data;
    self.isRefresh = YES;
    self.data = nil;
    [_collectionView reloadData];
}

- (NSArray *)list {
    if (_list == nil) {
        _list = [NSArray array];
    }
    return _list;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
