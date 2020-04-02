//
//  TOTXCell.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/17.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TOTXConfigListDataModel;
@interface TOTXCell : UICollectionViewCell
@property (nonatomic, strong) TOTXConfigListDataModel *dataModel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL toSelected;
@property (nonatomic, assign) BOOL isEnough;
@end

NS_ASSUME_NONNULL_END
