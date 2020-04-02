//
//  TOFeedViewController.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOFeedViewController.h"
#import "UIImage+Extension.h"
#import "UIView+TOExtension.h"
#import "TOHeader.h"

#import "NSString+Extension.h"
#import "TOViewModel.h"
#import "JJOptionView.h"
#import "TOFeedHUD.h"
#import "TOBaseRepModel.h"
#import "UIView+MAToast.h"
#import "TOUserDefault.h"
#import "IQKeyboardManager.h"
#import "UIView+MAToast.h"
@interface TOFeedViewController ()<JJOptionViewDelegate, UITextViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) TOViewModel *viewModel;
@property (nonatomic, strong) JJOptionView *optionView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) NSString *problemType;
@property (nonatomic, copy) NSString *problem;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation TOFeedViewController

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
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, STATUSHEIGHT + 2, TO_Width, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"意见反馈";
    [self.view addSubview:titleLabel];
    
    //返回按钮
    UIImage *backImg = [UIImage imageInBundleWithName:@"返回.png" class:[self class]];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(0, STATUSHEIGHT + 2, 40, 40);
    [backBtn setImage:backImg forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    [self initMainView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //TODO: 页面appear 禁用
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //TODO: 页面Disappear 启用
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)initMainView {
    
    self.dataSource = @[@"产品建议", @"使用故障"];
    UILabel *caLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, TOPVIEWHEIGHT + 30, 200, 14)];
    caLabel.text = @"您要反馈的问题类型";
    caLabel.textColor = kColorWithHEX(0x666666, 1.0f);
    caLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:caLabel];
    
    JJOptionView *optionView = [[JJOptionView alloc] initWithFrame:CGRectMake(20, caLabel.tx_bottom + 8, kWindowW - 40, 32)];
    optionView.delegate = self;
    optionView.backgroundColor = [UIColor groupTableViewBackgroundColor];;//kColorWithHEX(0xe1e1e1, 1.0f);
    optionView.borderColor = kColorWithHEX(0xf2f2f2, 1.0f);
    optionView.titleColor = [UIColor blackColor];//kColorWithHEX(0xc1c1c1, 1.0f);
    optionView.borderWidth = 0.5;
    optionView.dataSource = self.dataSource;
    optionView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex) {
        NSLog(@"%@",optionView);
        NSLog(@"%ld",selectedIndex);
    };
    [self.view addSubview:optionView];
    
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, optionView.tx_bottom + 20, 120, 14)];
    desLabel.text = @"您遇到的问题";
    desLabel.textColor = kColorWithHEX(0x666666, 1.0f);
    desLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:desLabel];
    
    UIView *descView = [[UIView alloc]initWithFrame:CGRectMake(20, desLabel.tx_bottom + 8, kWindowW - 40, 170)];
    descView.backgroundColor = [UIColor groupTableViewBackgroundColor];//kColorWithHEX(0xe1e1e1, 1.0f);
    descView.layer.borderColor = kColorWithHEX(0xf2f2f2, 1.0f).CGColor;
    descView.layer.borderWidth = 0.5;
    descView.layer.cornerRadius = 4;
    [self.view addSubview:descView];
    
    UITextView *descTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, descView.tx_width - 20, 150)];
    descTextView.textColor = kColorWithHEX(0xc1c1c1, 1.0f);
    descTextView.text = @"输入您遇到的问题 (500字以内)";
    descTextView.font = [UIFont systemFontOfSize:13];
    descTextView.backgroundColor = [UIColor clearColor];
    descTextView.delegate = self;
    [descView addSubview:descTextView];
    descTextView.returnKeyType = UIReturnKeyDone;
    _textView = descTextView;
    
//    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(descView.tx_width - 90, descView.tx_height - 25, 120, 14)];
//    numLabel.text = @"(500字以内)";
//    numLabel.textAlignment = NSTextAlignmentRight;
//    numLabel.textColor = [UIColor blackColor];//kColorWithHEX(0xc1c1c1, 1.0f);
//    numLabel.font = [UIFont systemFontOfSize:14];
//    [descView addSubview:numLabel];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, descView.tx_bottom + 20, 120, 32)];
    emailLabel.text = @"您的联系方式";
    emailLabel.textColor = kColorWithHEX(0x666666, 1.0f);
    emailLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:emailLabel];
    
    UIView *emailView = [[UIView alloc]initWithFrame:CGRectMake(20, emailLabel.tx_bottom + 8, kWindowW - 40, 32)];
    emailView.backgroundColor = [UIColor groupTableViewBackgroundColor];//kColorWithHEX(0xe1e1e1, 1.0f);
    emailView.layer.borderColor = kColorWithHEX(0xf2f2f2, 1.0f).CGColor;
    emailView.layer.borderWidth = 0.5;
    emailView.layer.cornerRadius = 4;
    [self.view addSubview:emailView];
    
    UITextField *emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, emailView.tx_width - 20, 32)];
    emailTextField.placeholder = @"输入您的联系方式 (电话/邮箱/QQ)";
    emailTextField.textColor = [UIColor blackColor];//kColorWithHEX(0xc1c1c1, 1.0f);
    emailTextField.font = [UIFont systemFontOfSize:13];
    emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTextField.delegate = self;
    emailTextField.returnKeyType = UIReturnKeyDone;
    [emailView addSubview:emailTextField];
    _textField = emailTextField;
    
    UIImage *submitBtnBg = [UIImage imageInBundleWithName:@"txanbj.png" class:[self class]];
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [submitBtn setBackgroundImage:submitBtnBg forState:(UIControlStateNormal)];
    [submitBtn setTitle:@"提交反馈" forState:(UIControlStateNormal)];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    submitBtn.frame = CGRectMake(0, emailView.tx_bottom + 26, TO_Width-140, 60);
    submitBtn.tx_centerX = self.view.tx_centerX;
    [self.view addSubview:submitBtn];
    [submitBtn addTarget:self action:@selector(clickSubmit) forControlEvents:(UIControlEventTouchUpInside)];
    
}

#pragma mark JJOptionViewDelegate
- (void)optionView:(JJOptionView *)optionView selectedIndex:(NSInteger)selectedIndex {
    NSLog(@"%@",optionView);
    NSLog(@"%ld",selectedIndex);
    self.problemType = [NSString stringWithFormat:@"%ld", selectedIndex + 1];
}

- (void)clickSubmit {
    
    self.problem = self.textView.text;
    self.contact = self.textField.text;
    
    self.problem = [self.problem stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.contact = [self.contact stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (self.problem.length > 500) {
        [self.problem substringToIndex:500];
    }
    if (self.problemType.length == 0 || self.problem.length == 0 || self.contact.length == 0) {
        [self.view makeToast:@"请把信息补充完整" duration:0.5 position:MAToastPositionCenter];
        return;
    }
    
    @weakify(self)
    [self.viewModel to_doFeedbackInfoWithFeedbackType:self.problemType phoneMsg:self.contact question:self.problem answer:@"" callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        @strongify(self);
        if (error) {
            if (error.code == -1009) {
                [self.view makeToast:@"你当前网络有误，请稍候重试" duration:0.5 position:MAToastPositionCenter];
            } else {
                [self.view makeToast:error.description duration:0.5 position:MAToastPositionCenter];
            }
        } else {
            TOBaseRepModel *model = [TOBaseRepModel TOMJ_objectWithKeyValues:jsonDic];
            if (model.status == 200) {
                TOFeedHUD *hud = [[TOFeedHUD alloc]initWithFrame:self.view.bounds];
                hud.alpha = 0.0f;
                [hud setFeedbackCallback:^{
                    [self backFoot];
                }];
                [self.view addSubview:hud];
                [UIView animateWithDuration:0.3 animations:^{
                    hud.alpha = 1.0f;
                }];
            } else {
                [self.view makeToast:model.msg duration:1.0 position:MAToastPositionCenter];
            }
        }
    }];
}

- (void)backFoot {
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"输入您遇到的问题 (500字以内)"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"输入您遇到的问题 (500字以内)";
            textView.textColor = kColorWithHEX(0xc1c1c1, 1.0f);
        }
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {

    UITextRange *selectedRange = [textView markedTextRange];
    // 获取高亮部分 中文联想
    UITextPosition *posi = [textView positionFromPosition:selectedRange.start offset:0];

    // 如果在变化中是高亮部分在变，就不要计算字符
    if (selectedRange && posi) {
        return;
    }

    // 实际总长度
    NSInteger realLength = textView.text.length;
    NSRange selection = textView.selectedRange;
    NSString *headText = [textView.text substringToIndex:selection.location];   // 光标前的文本
    NSString *tailText = [textView.text substringFromIndex:selection.location]; // 光标后的文本
    NSInteger restLength = 500 - tailText.length;                     // 光标前允许输入的最大数量

    if (realLength > 500) {
        // 解决半个emoji 定位到index位置时，返回在此位置的完整字符的range
        NSRange range = [textView.text rangeOfComposedCharacterSequenceAtIndex:restLength];
        NSString *subHeadText = [textView.text substringToIndex:range.location];
        
        // NSString *subHeadText = [headText substringToIndex:restLength];
        textView.text = [subHeadText stringByAppendingString:tailText];
        [textView setSelectedRange:NSMakeRange(restLength, 0)];
        // 解决粘贴过多之后，撤销粘贴 崩溃问题 —— 不会出现弹框
        [textView.undoManager removeAllActions];
    }
}

- (TOViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TOViewModel alloc]init];
    }
    return _viewModel;
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
