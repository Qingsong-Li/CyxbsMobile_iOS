//
//  ScheduleCustomViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/1/18.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScheduleCourse.h"

NS_ASSUME_NONNULL_BEGIN

@class ScheduleCustomViewController;

@protocol ScheduleCustomViewControllerDelegate <NSObject>

@optional

- (void)scheduleCustomViewController:(ScheduleCustomViewController *)viewController finishingWithAppending:(BOOL)append;

@end

@interface ScheduleCustomViewController : UIViewController

@property (nonatomic, null_resettable) ScheduleCourse *courseIfNeeded;

@property (nonatomic, weak) id <ScheduleCustomViewControllerDelegate> delegate;

- (instancetype)initWithAppendingInSection:(NSUInteger)section week:(NSUInteger)week location:(NSUInteger)location;

- (instancetype)initWithEditingWithCourse:(ScheduleCourse *)course;

@end

NS_ASSUME_NONNULL_END
