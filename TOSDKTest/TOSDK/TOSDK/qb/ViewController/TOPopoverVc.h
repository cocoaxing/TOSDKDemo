//
//  TOPopoverVc.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/3/19.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOPopoverVc : UIViewController
@property (copy, nonatomic) void(^didSelectedCellBlock)(NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
