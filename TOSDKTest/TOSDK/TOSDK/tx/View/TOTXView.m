//
//  TOTXView.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/17.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOTXView.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "TOTXCell.h"
#import "TOTXConfigListModel.h"
#import "UIView+MAToast.h"
#import "TOTxManager.h"
#import "TOUserDefault.h"
#define LeftMargin 15
@interface TOTXView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) UILabel *roundLabel;
@property (nonatomic, assign) NSInteger leftRound;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, strong) TOTXConfigListDataModel *data;
@end

static NSString *cellId = @"TOTXCell";

@implementation TOTXView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)refreshDatas:(NSArray *)datas {
    self.list = datas;
    self.isRefresh = YES;
    [_collectionView reloadData];
    self.data = nil;
}

- (void)refreshTxUserInfoData:(NSString *)round {
    _roundLabel.text = round;
    _leftRound = [round integerValue];   
}

- (void)initView {
    
    NSString *tx = _NSStringFromBbString(TO_BB_TX);
    NSString *jb = _NSStringFromBbString(TO_BB_JB);
    NSString *je = _NSStringFromBbString(TO_BB_JE);
    
    //提示横幅
    UIImageView *tipBannerIv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, TO_Width-30, 0.24*(TO_Width-30))];
    tipBannerIv.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:tipBannerIv];
    [TOSDKUtil imageWithName:@"ic_txjbybanner.png" callback:^(id  _Nonnull obj) {
        if (obj) {
            UIImage *image = obj;
            tipBannerIv.image = image;
        }
    }];
    
    
    UILabel *round2TitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(LeftMargin*2, CGRectGetMaxY(tipBannerIv.frame) + 20, 60, 20)];
    round2TitleLabel.textColor = kColorWithHEX(0x333333, 1.0f);
    round2TitleLabel.font = [UIFont systemFontOfSize:14];
    round2TitleLabel.text = [NSString stringWithFormat:@"我的%@", jb];
    [self addSubview:round2TitleLabel];
    
    UILabel *round2Label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(round2TitleLabel.frame) + 6, round2TitleLabel.tx_y, 200, 20)];
    round2Label.textColor = kColorWithHEX(0xff7819, 1.0f);
    round2Label.font = [UIFont boldSystemFontOfSize:18];
    round2Label.text = @"0";
    [self addSubview:round2Label];
    _roundLabel = round2Label;
    
    UILabel *chooseTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(LeftMargin*2, CGRectGetMaxY(round2Label.frame) + 14, 150, 20)];
    chooseTitleLabel.textColor = kColorWithHEX(0x333333, 1.0f);
    chooseTitleLabel.font = [UIFont systemFontOfSize:14];
    chooseTitleLabel.text = [NSString stringWithFormat:@"选择%@%@", tx, je];
    [self addSubview:chooseTitleLabel];
    
    UIImage *ruleIcon = [UIImage imageInBundleWithName:@"txgz.png" class:[self class]];
    UIButton *ruleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ruleBtn setImage:ruleIcon forState:(UIControlStateNormal)];
    [ruleBtn setTitle:[NSString stringWithFormat:@"  %@规则", tx] forState:(UIControlStateNormal)];
    [ruleBtn setTitleColor:kColorWithHEX(0xff7819, 1.0f) forState:(UIControlStateNormal)];
    [ruleBtn addTarget:self action:@selector(clickRule) forControlEvents:(UIControlEventTouchUpInside)];
    ruleBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    ruleBtn.frame = CGRectMake(TO_Width - 130, chooseTitleLabel.tx_y, 120, 20);
    [self addSubview:ruleBtn];
    //选项
    CGFloat cellMargin = 10;
    CGFloat margin = 20;
    CGFloat w = (self.bounds.size.width - margin * 2 - cellMargin * 2)/3;
    CGFloat h = w * 0.6;
    if (IsIphone55c5sse) {
        h += 10;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(w, h);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = cellMargin;
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, chooseTitleLabel.tx_bottom+10, self.bounds.size.width, h * 2 + 12) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[TOTXCell class] forCellWithReuseIdentifier:cellId];
    [self addSubview:_collectionView];
    UIImage *txBg = [UIImage imageInBundleWithName:@"txanbj.png" class:[self class]];
    UIButton *txBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [txBtn setBackgroundImage:txBg forState:(UIControlStateNormal)];
    [txBtn setTitle:[NSString stringWithFormat:@"立即%@", tx] forState:(UIControlStateNormal)];
    [txBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [txBtn addTarget:self action:@selector(clickTx) forControlEvents:(UIControlEventTouchUpInside)];
    txBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    txBtn.frame = CGRectMake(70, _collectionView.tx_bottom+8, TO_Width-140, 60);
    [self addSubview:txBtn];
    
}

- (void)clickTx {
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_ME_LJTX_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    if (self.data == nil) {
        [self makeToast:[NSString stringWithFormat:@"请选择%@%@", _NSStringFromBbString(TO_BB_TX), _NSStringFromBbString(TO_BB_JE)] duration:0.5 position:MAToastPositionCenter];
        return;
    }
    
    NSInteger round = [[TOUserDefault sharedTOUserDefault] getTotalRound];
    NSInteger txJb = [self.data.ppjb integerValue];
    if (round < txJb) {
        [[TOPopManager sharedInstance] popLackHud:[NSString stringWithFormat:@"抱歉, %@不足", _NSStringFromBbString(TO_BB_YE)] isT:YES];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(txView:handleTxWithItemModel:)]) {
        [self.delegate txView:self handleTxWithItemModel:self.data];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TOTXCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.isEnough = self.leftRound >= 10000 ? YES: NO;
    cell.dataModel = self.list[indexPath.item];
    cell.index = indexPath.row;
    if (self.isRefresh) {
        cell.toSelected = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.isRefresh = NO;
    TOTXConfigListDataModel *model = self.list[indexPath.item];
    self.data = model;
    TOTXCell *selectCell = (TOTXCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSArray *cells = [collectionView visibleCells];
    for (TOTXCell *cell in cells) {
        if (selectCell == cell) {
            cell.toSelected = YES;
        } else {
            cell.toSelected = NO;
        }
    }
    
}

- (void)clickRule {
    if ([self.delegate respondsToSelector:@selector(txViewRule:)]) {
        [self.delegate txViewRule:self];
    }
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
