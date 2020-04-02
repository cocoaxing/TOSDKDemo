//
//  TOXJCell.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/18.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TORPConfigListData;
@interface TOXJCell : UICollectionViewCell
@property (nonatomic, strong) TORPConfigListData *dataModel;
@property (nonatomic, assign) BOOL toSelected;
@end

NS_ASSUME_NONNULL_END
