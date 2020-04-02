//
//  TOWdResultViewController.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/20.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOWdResultViewController.h"
#import "UIImage+Extension.h"
#import "UIView+TOExtension.h"
#import "TOHeader.h"
#import "TOUserDefault.h"
#import "TOWalletViewController.h"
@interface TOWdResultViewController ()

@end
#define LeftMargin 15
@implementation TOWdResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //顶部导航背景
    UIImageView *topNaviIv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, TO_Width, TOPVIEWHEIGHT)];
    topNaviIv.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:topNaviIv];
    UIImage *img = [UIImage imageInBundleWithName:@"状态栏.png" class:[self class]];
    topNaviIv.image = img;
    //返回按钮
    UIImage *backImg = [UIImage imageInBundleWithName:@"返回.png" class:[self class]];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(0, STATUSHEIGHT + 2, 40, 40);
    [backBtn setImage:backImg forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.5 * (TO_Width - 100), STATUSHEIGHT + 2, 100, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = [NSString stringWithFormat:@"%@成功", _NSStringFromBbString(TO_BB_TX)];
    [self.view addSubview:titleLabel];

    CGFloat w = 200;
    CGFloat topMargin = 100;
    if (IsIphone55c5sse) {
        w = 150;
        topMargin = 50;
    }
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, topMargin, w, w)];
    iconImageView.tx_centerX = self.view.tx_centerX;
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconImageView];
    [TOSDKUtil imageWithName:@"ic_txcgch.png" callback:^(id  _Nonnull obj) {

        if (obj) {
            UIImage *image = obj;
            iconImageView.image = image;
        }
    }];
    
    
    //标题
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, iconImageView.tx_bottom + 30, TO_Width, 30)];
    tipLabel.font = [UIFont boldSystemFontOfSize:27];
    tipLabel.textColor = kColorWithHEX(0x333333, 1.0f);
    [self.view addSubview:tipLabel];
    
    NSString *str= [NSString stringWithFormat:@"恭喜成功%@%@%@",_NSStringFromBbString(TO_BB_TX), self.incValue, _NSStringFromBbString(TO_BB_Y)];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kColorWithHEX(0xff7819, 1.0f) range:NSMakeRange(6,str.length - 6)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.attributedText = attrStr;
   
    
    //标题
    UILabel *ruleLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, tipLabel.tx_bottom + 40, TO_Width - 60, 50)];
    ruleLabel.textColor = kColorWithHEX(0x333333, 1.0f);
    ruleLabel.font = [UIFont systemFontOfSize:14];
    ruleLabel.textAlignment = NSTextAlignmentCenter;
    ruleLabel.numberOfLines = 0;
    [self.view addSubview:ruleLabel];
    
    NSString *rule = [[TOUserDefault sharedTOUserDefault] getTransferTips];
    NSMutableAttributedString *ruleAttrStr = [[NSMutableAttributedString alloc] initWithString:rule];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];//行间距
    paragraph.lineSpacing =3;
    [ruleAttrStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, rule.length)];
    ruleLabel.attributedText = ruleAttrStr;
    ruleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UIButton *txBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [TOSDKUtil imageWithName:@"/images/gomorem.png" callback:^(id  _Nonnull obj) {
        if (obj) {
            UIImage *image = obj;
            [txBtn setImage:image forState:(UIControlStateNormal)];
        }
    }];
    [txBtn addTarget:self action:@selector(clickContinue) forControlEvents:(UIControlEventTouchUpInside)];
    txBtn.frame = CGRectMake(70, ruleLabel.tx_bottom+30, TO_Width-140, 60);
    [self.view addSubview:txBtn];
    
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_ME_LJTX_CG_POP callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    
}

- (void)clickContinue {
    
    TOViewModel *model = [[TOViewModel alloc]init];
    [model to_doDotActionWithEventId:DO_ME_LJTX_TX_CG_JXZQ_BTN callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        
    }];
    UIViewController *vc =self.presentingViewController;
    
    NSString *className = [[TOUserDefault sharedTOUserDefault] getCurrentVcClass];
    
    Class c = NSClassFromString(className);
    
    while (![vc isKindOfClass:c]) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
