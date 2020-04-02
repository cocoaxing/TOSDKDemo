//
//  TOPopoverVc.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOPopoverVc.h"

@interface TOPopoverVc ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableview;

@end

@implementation TOPopoverVc

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == 0) {
       cell.textLabel.text = [NSString stringWithFormat:@"%@明细",  _NSStringFromBbString(TO_BB_TX)];
    } else {
        cell.textLabel.text = @"意见反馈";
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectedCellBlock) {
        self.didSelectedCellBlock(indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 5)];
    v.backgroundColor = [UIColor whiteColor];
    return v;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if (indexPath.row == 1) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, [UIScreen mainScreen].bounds.size.width);
    }

}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 30;
        _tableview.tableFooterView = [UIView new];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableview;
}

@end
