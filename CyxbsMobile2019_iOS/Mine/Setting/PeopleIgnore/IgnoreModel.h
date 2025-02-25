//
//  IgnoreModel.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/3/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MainPageModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 获取屏蔽的人的数据的model
@interface IgnoreModel : MainPageModel
@property(nonatomic,weak)id <MainPageModelDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
