//
//  TODetailViewController.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/18.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TODetailViewController.h"
#import "TODetailCell.h"
#import "UIImage+Extension.h"
#import "UIView+TOExtension.h"
#import "TOHeader.h"
#import "TONetworking.h"
#import "TOWardhtiwListReqModel.h"
#import "TOWardhtiwList.h"

#import "NSString+Extension.h"
#import "TOViewModel.h"
@interface TODetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) TOViewModel *viewModel;
@property (nonatomic, strong) UILabel *nonLabel;
@end

static NSString *cellId = @"TODetailCell";
#define LeftMargin 15

@implementation TODetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    titleLabel.text = @"明细";
    [self.view addSubview:titleLabel];
    
    //返回按钮
    UIImage *backImg = [UIImage imageInBundleWithName:@"返回.png" class:[self class]];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(0, STATUSHEIGHT + 2, 40, 40);
    [backBtn setImage:backImg forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    UITableView *tb = [[UITableView alloc]initWithFrame:CGRectMake(0, topNaviIv.tx_bottom, TO_Width, TO_Height - TOPVIEWHEIGHT) style:(UITableViewStylePlain)];
    tb.delegate = self;
    tb.dataSource = self;
    tb.tableFooterView = [UIView new];
    [tb registerClass:[TODetailCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:tb];
    _tableView = tb;
    
    _nonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, TO_Width, 20)];
    [self.view addSubview:_nonLabel];
    _nonLabel.text = [NSString stringWithFormat:@"暂无%@记录", _NSStringFromBbString(TO_BB_TX)];
    _nonLabel.font = [UIFont systemFontOfSize:18];
    _nonLabel.textColor = [UIColor grayColor];
    _nonLabel.textAlignment = NSTextAlignmentCenter;
    _nonLabel.tx_centerY = self.view.tx_centerY;
    [_nonLabel setHidden:YES];
    
    [self to_getWradhtiwList];
}


- (void)to_getWradhtiwList {
    @weakify(self);
    [self.viewModel to_getHqTxListWithCallback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        if (error) {
            
        } else {
            @strongify(self);
            TOWardhtiwList *model = [TOWardhtiwList TOMJ_objectWithKeyValues:jsonDic];
            NSLog(@"TOSDK_LOG: %@", model);
            if (model.status == 200) {
                self.list = model.data;
            } else {
                self.list = [NSArray array];
                [self.nonLabel setHidden:NO];
            }
            [self.tableView reloadData];
            
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TODetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.data = self.list[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, TO_Width, 20)];
}

- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *)list {
    if (_list == nil) {
        _list = [NSArray array];
    }
    return _list;
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
