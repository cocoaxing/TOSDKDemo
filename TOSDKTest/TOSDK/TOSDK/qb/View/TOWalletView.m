//
//  TOWalletView.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/14.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOWalletView.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "TOTXView.h"
#import "TOXJView.h"
#import "TOUserRPInfo.h"
#define LeftMargin 15

@interface TOWalletView ()<UITableViewDelegate, UITableViewDataSource, TOTXViewDelegate, TOXJViewDelegate>
@property (nonatomic, strong) UIButton *roundBtn;
@property (nonatomic, strong) UIButton *pageBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *whiteLine;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *roundLabel;
@property (nonatomic, strong) UILabel *xjLabel;
@property (nonatomic, strong) TOTXView *txView;
@property (nonatomic, strong) TOXJView *xjView;
@property (nonatomic, strong) UILabel *roundTitleLabel;
@property (nonatomic, strong) UILabel *crashTitleLabel;
@property (nonatomic, assign) BOOL isTX;


@end

@implementation TOWalletView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)refreshTxData:(NSArray *)data {
    [self.txView refreshDatas:data];
}

- (void)refreshxJUserInfoData:(TOUserRPInfo *)leftRp {
    NSString *str = [NSString stringWithFormat:@"¥%@", leftRp.data.leftRP];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 1)];
    self.leftLabel.attributedText = attr;
    
    self.roundLabel.text = leftRp.data.leftJB.length > 0 ? leftRp.data.leftJB : @"0";
    CGSize size = [_roundLabel sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
    _roundLabel.frame = CGRectMake(LeftMargin, CGRectGetMaxY(_roundTitleLabel.frame) + 3, size.width, 20);
    CGFloat v = [leftRp.data.leftJB floatValue];
    CGFloat cash = v/10000.0;
    self.xjLabel.text = [NSString stringWithFormat:@"≈%.2f%@", cash > 0 ? cash : 0, _NSStringFromBbString(TO_BB_Y)];
    [self.txView refreshTxUserInfoData:leftRp.data.leftJB];
    [self.xjView refreshxJUserInfoData:leftRp.data.leftRP];

    CGFloat tX = CGRectGetMaxX(_roundTitleLabel.frame);
    CGFloat gX = CGRectGetMaxX(_roundLabel.frame);
    CGFloat wX = gX>tX ? gX : tX;
    _whiteLine.frame = CGRectMake(wX + 21, _roundTitleLabel.tx_y + 8, 1, 40);
    _crashTitleLabel.frame = CGRectMake(CGRectGetMaxX(_whiteLine.frame) + 21, _roundTitleLabel.tx_y, 200, 20);
    _leftLabel.frame =  CGRectMake(_crashTitleLabel.tx_x, _roundLabel.tx_y, 120, 20);
    
}

- (void)refreshxJConfigInfoData:(NSArray *)data {
    [self.xjView refreshxJConfigInfoData:data];
}

- (void)initView {
    
    NSString *qb = _NSStringFromBbString(TO_BB_QB);
    NSString *tx = _NSStringFromBbString(TO_BB_TX);
    NSString *jb = _NSStringFromBbString(TO_BB_JB);
    NSString *hb = _NSStringFromBbString(TO_BB_HB);
    NSString *yan = _NSStringFromBbString(TO_BB_Y);
    NSString *xj = _NSStringFromBbString(TO_BB_XJ);
    self.isTX = YES;
    
    //顶部导航背景
    UIImageView *topNaviIv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, TO_Width, TO_Width * 0.4)];
    topNaviIv.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:topNaviIv];
    [TOSDKUtil imageWithName:@"ic_txstatus.png" callback:^(id  _Nonnull obj) {
        if (obj) {
            UIImage *image = obj;
            topNaviIv.image = image;
        }
    }];
    
    
    CGFloat top = STATUSHEIGHT > 20 ? STATUSHEIGHT + 2 : STATUSHEIGHT + 15;
    if (IsIphone55c5sse) {
        top = STATUSHEIGHT + 5;
    }
    //返回按钮
    UIImage *backImg = [UIImage imageInBundleWithName:@"返回.png" class:[self class]];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(0, top, 40, 20);
    [backBtn setImage:backImg forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:backBtn];
    //明细按钮
    UIImage *moreImg = [UIImage imageInBundleWithName:@"ic-more.png" class:[self class]];
    UIButton *mxBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    mxBtn.frame = CGRectMake(TO_Width - LeftMargin - 60, top, 60, 30);
    [mxBtn setImage:moreImg forState:(UIControlStateNormal)];
    [mxBtn addTarget:self action:@selector(clickDetail) forControlEvents:(UIControlEventTouchUpInside)];
    mxBtn.tx_centerY = backBtn.tx_centerY;
    [self addSubview:mxBtn];
    _mxBtn = mxBtn;
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.5 * (TO_Width - 100), 30, 100, 20)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = [NSString stringWithFormat:@"我的%@", qb];
    titleLabel.tx_centerY = backBtn.tx_centerY;
    [self addSubview:titleLabel];
    
    CGFloat topMargin = 15;
    UILabel *roundTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(titleLabel.frame) + topMargin, 60, 20)];
    roundTitleLabel.textColor = [UIColor whiteColor];
    roundTitleLabel.font = [UIFont systemFontOfSize:12];
    roundTitleLabel.text = [NSString stringWithFormat:@"我的%@", jb];
    [self addSubview:roundTitleLabel];
    _roundTitleLabel = roundTitleLabel;
    
    UILabel *roundLabel = [[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(roundTitleLabel.frame) + 3, 0, 20)];
    roundLabel.textColor = [UIColor whiteColor];
    roundLabel.font = [UIFont boldSystemFontOfSize:26];
    roundLabel.text = @"0";
    CGSize size = [roundLabel sizeThatFits:CGSizeMake(MAXFLOAT, 20)];
    roundLabel.frame = CGRectMake(LeftMargin, CGRectGetMaxY(roundTitleLabel.frame) + 3, size.width, 20);
    [self addSubview:roundLabel];
    _roundLabel = roundLabel;
    
    UILabel *cashLabel = [[UILabel alloc]initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(roundLabel.frame), 70, 18)];
    cashLabel.textColor = [UIColor whiteColor];
    cashLabel.font = [UIFont boldSystemFontOfSize:11];
    cashLabel.text = [NSString stringWithFormat:@"≈0%@", yan];
    [self addSubview:cashLabel];
    _xjLabel = cashLabel;
    //白线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(roundTitleLabel.frame) + 21, roundTitleLabel.tx_y + 8, 1, 40)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView];
    _whiteLine = lineView;
    
    
    UILabel *crashTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + 21, roundTitleLabel.tx_y, 200, 20)];
    crashTitleLabel.textColor = [UIColor whiteColor];
    crashTitleLabel.font = [UIFont systemFontOfSize:12];
    crashTitleLabel.text = [NSString stringWithFormat:@"我的%@%@", xj, hb];
    [self addSubview:crashTitleLabel];
    _crashTitleLabel = crashTitleLabel;
    
    
    UILabel *crashLabel = [[UILabel alloc]initWithFrame:CGRectMake(crashTitleLabel.tx_x, roundLabel.tx_y, 120, 20)];
    crashLabel.textColor = [UIColor whiteColor];
    crashLabel.font = [UIFont boldSystemFontOfSize:26];
    crashLabel.text = @"¥0.00";
    [self addSubview:crashLabel];
    _leftLabel = crashLabel;
    
    UIButton *roundBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [roundBtn setTitle:[NSString stringWithFormat:@"%@%@", tx, jb] forState:(UIControlStateNormal)];
    [roundBtn setTitleColor:kColorWithHEX(0x333333, 1.0f) forState:(UIControlStateSelected)];
    [roundBtn setTitleColor:kColorWithHEX(0x333333, 0.4f) forState:(UIControlStateNormal)];
    roundBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    roundBtn.frame = CGRectMake(30, CGRectGetMaxY(topNaviIv.frame), TO_Width * 0.5-30, 54);
    [roundBtn setSelected:YES];
    [roundBtn addTarget:self action:@selector(clickRoundButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:roundBtn];
    _roundBtn = roundBtn;
    
    UIButton *pageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [pageBtn setTitle:[NSString stringWithFormat:@"%@%@", xj, hb] forState:(UIControlStateNormal)];
    [pageBtn setTitleColor:kColorWithHEX(0x333333, 1.0f) forState:(UIControlStateSelected)];
    [pageBtn setTitleColor:kColorWithHEX(0x333333, 0.4f) forState:(UIControlStateNormal)];
    pageBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    pageBtn.frame = CGRectMake(TO_Width * 0.5, roundBtn.tx_y, TO_Width * 0.5-30, 54);
    [pageBtn setSelected:NO];
    [pageBtn addTarget:self action:@selector(clickPageButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:pageBtn];
    _pageBtn = pageBtn;
    //红线
    UIView *redLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(roundBtn.frame)-13, 30, 3)];
    redLineView.tx_centerX = roundBtn.tx_centerX;
    redLineView.backgroundColor = kColorWithHEX(0xff7b56, 1.0f);
    [self addSubview:redLineView];
    _line = redLineView;
    
    UITableView *tb = [[UITableView alloc]initWithFrame:CGRectMake(0, redLineView.tx_bottom + 20, TO_Width, TO_Height - redLineView.tx_bottom) style:(UITableViewStylePlain)];
    tb.delegate = self;
    tb.dataSource = self;
    [tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:tb];
    _tableView = tb;
    
}

#pragma mark tableView delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 800;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isTX) {
        return self.txView;
    } else {
        return self.xjView;
    }
    
}

#pragma mark 点击事件
- (void)clickRoundButton:(UIButton *)sender {
    sender.selected = YES;
    _pageBtn.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.line.tx_centerX = self.roundBtn.tx_centerX;
    }];
    if (!self.isTX) {
        self.isTX = YES;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationRight)];
    }
    
    if ([self.delegate respondsToSelector:@selector(walletViewClickTx)]) {
        [self.delegate walletViewClickTx];
    }
}

- (void)clickPageButton:(UIButton *)sender {
    sender.selected = YES;
    _roundBtn.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.line.tx_centerX = self.pageBtn.tx_centerX;
    }];
    if (self.isTX) {
        self.isTX = NO;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationLeft)];
    }
    
    if ([self.delegate respondsToSelector:@selector(walletViewClickjx)]) {
        [self.delegate walletViewClickjx];
    }
}

- (void)clickBack {
    if ([self.delegate respondsToSelector:@selector(walletViewBack:)]) {
        [self.delegate walletViewBack:self];
    }
}

- (void)clickDetail {
    if ([self.delegate respondsToSelector:@selector(walletViewDetail:)]) {
        [self.delegate walletViewDetail:self];
    }

}

#pragma mark TOTxViewDelegate
- (void)txView:(TOTXView *)view handleTxWithItemModel:(TOTXConfigListDataModel *)model {
    if ([self.delegate respondsToSelector:@selector(handleTxWithData:)]) {
        [self.delegate handleTxWithData:model];
    }
}

- (void)xjView:(TOXJView *)view handleTxWithData:(nonnull TORPConfigListData *)data {
    if ([self.delegate respondsToSelector:@selector(handleXjWithData:)]) {
        [self.delegate handleXjWithData:data];
    }
}

- (void)xjViewRule:(TOXJView *)view {
    if ([self.delegate respondsToSelector:@selector(walletViewRule:)]) {
        [self.delegate walletViewRule:self];
    }
}

- (void)txViewRule:(TOTXView *)view {
    if ([self.delegate respondsToSelector:@selector(walletViewRule:)]) {
        [self.delegate walletViewRule:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (TOTXView *)txView {
    if (_txView == nil) {
        _txView = [[TOTXView alloc]initWithFrame:CGRectMake(0, 0, TO_Width, 800)];
        _txView.delegate = self;
    }
    return _txView;
}

- (TOXJView *)xjView {
    if (_xjView == nil) {
        _xjView = [[TOXJView alloc]initWithFrame:CGRectMake(TO_Width, 0, TO_Width, 800)];
        _xjView.delegate = self;
    }
    return _xjView;
}
@end
