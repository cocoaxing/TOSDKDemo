//
//  TOBaseHUD.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOBaseHUD.h"
#import "UIImage+Extension.h"
#import "TOHeader.h"
#import "UIView+TOExtension.h"
#import "TOWxLoManager.h"
#import "TOViewModel.h"
#import "ToBindingUserRepModel.h"
#import "TOUserDefault.h"

#import "UIView+MAToast.h"
@interface  TOBaseHUD ()
@property (nonatomic, strong) TOViewModel *viewModel;
@property (nonatomic, copy) TOBaseHUDLoginCallback callback;
@end

@implementation TOBaseHUD

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.alpha = 0.6f;
    bgView.backgroundColor = [UIColor blackColor];
    [self addSubview:bgView];
    CGFloat getBtnMargin = 50;
    if (IsIphone55c5sse) {
        getBtnMargin = 20;
    }
    UIImage *img = [UIImage imageInBundleWithName:@"xrhb2.png" class:[self class]];
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:img];
    CGFloat height = 1.5*(TO_Width - getBtnMargin * 2);
    bgImageView.frame = CGRectMake(getBtnMargin, 0.5 * (TO_Height - height), TO_Width-getBtnMargin * 2, height);
    [self addSubview:bgImageView];
    _bgImageView = bgImageView;
}


- (void)clickWxLogin:(TOBaseHUDLoginCallback)callback {
    self.callback = callback;
    @weakify(self);
    [[TOWxLoManager sharedTOWxLoManager] wxAuthAccessTokenCallback:^(NSDictionary *_Nullable userInfo, NSInteger login, NSError *error) {
        if (error) {
            //登陆出错
            self.callback(NO, error);
            return;
        }
        
        //登陆成功
        @strongify(self);
        if (login == 1) {
            [self bindUser:userInfo];
        } else {
            self.callback(NO, nil);
        }
    }];
}

//绑定用户
- (void)bindUser:(NSDictionary *)dic {
    @weakify(self);
    [self.viewModel to_doBindingUserWithUserInfo:dic callback:^(NSDictionary * _Nullable jsonDic, NSError * _Nullable error) {
        @strongify(self);
        if (error) {
            self.callback(NO, error);
        } else {
            //存储用户id
            ToBindingUserRepModel *model = [ToBindingUserRepModel TOMJ_objectWithKeyValues:jsonDic];
            //存储标识
            
            if (model.status == 200) {
                [[TOUserDefault sharedTOUserDefault] setSysUserId:model.data.sysUserId];
                [[TOUserDefault sharedTOUserDefault] setNewUserFlag:model.data.payUserRedpacketInfoBo.isNURP];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.callback(YES, error);
                });
            } else if (model.status == 10040) {
                UIViewController *vc = [TOSDKUtil currentViewController];
                [vc.view makeToast:model.msg duration:0.5 position:MAToastPositionBottom];
                [self.viewModel to_doDotActionWithEventId:DO_WX_LOGIN_FAIL_BOUND callback:nil];
                self.callback(NO, nil);
            } else if (model.status == 100004) {
                UIViewController *vc = [TOSDKUtil currentViewController];
                [vc.view makeToast:model.msg duration:0.5 position:MAToastPositionBottom];
                [self.viewModel to_doDotActionWithEventId:DO_WX_LOGIN_FAIL_SIGN callback:nil];
                self.callback(NO, nil);
            } else {
                self.callback(NO, nil);
            }
            
        }
    }];
}

- (TOViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TOViewModel alloc]init];
    }
    return _viewModel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
