//
//  ScheduleModel.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/2.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleModel.h"

#import "ScheduleTimelineSupport.h"

#import "ScheduleNeedsSupport.h"

#pragma mark - ScheduleModel

@implementation ScheduleModel {
    NSMutableDictionary <ScheduleIdentifier *, NSArray<ScheduleCourse *> *> *_statusMap;
    NSMutableArray <NSMutableArray <NSIndexPath *> *> *_courseIdxPaths;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _statusMap = NSMutableDictionary.dictionary;
        _touchItem = [[ScheduleTouchItem alloc] init];
    }
    return self;
}

#pragma mark - Method

- (void)combineItem:(ScheduleCombineItem *)model {
    if (_statusMap[model.identifier] || model.identifier == nil) {
        return;
    }
    [super combineItem:model];
    _statusMap[model.identifier] = model.value;
    _courseIdxPaths = nil;
    self.touchItem.combining = model;
}

- (void)clear {
    [super clear];
    [_statusMap removeAllObjects];
    _courseIdxPaths = nil;
    self.touchItem.combining = nil;
}


- (NSArray<ScheduleCourse *> *)coursesWithLocationIdxPath:(NSIndexPath *)idxPath {
    NSMutableSet *set = NSMutableSet.set;
    for (NSArray <ScheduleCourse *> *kind in _statusMap.allValues) {
        for (ScheduleCourse *course in kind) {
            if (course.inWeek == idxPath.week) {
                for (NSInteger i = 0; i < [self.mapTable objectForKey:idxPath].lenth; i++) {
                    if (NSLocationInRange(idxPath.location + i, course.period)) {
                        if (idxPath.section) {
                            if ([course.inSections containsIndex:idxPath.section]){
                                [set addObject:course];
                            }
                        } else {
                            [set addObject:course];
                        }
                    }
                }
            }
        }
    }
    return set.allObjects;
}

#pragma mark - Getter

- (NSArray<NSArray<NSIndexPath *> *> *)courseIdxPaths {
    if (_courseIdxPaths == nil) {
        _courseIdxPaths = @[NSMutableArray.array].mutableCopy;
        
        NSEnumerator <NSIndexPath *> *idxEnum = self.mapTable.keyEnumerator;
        for (NSIndexPath *indexPath = idxEnum.nextObject; indexPath; indexPath = idxEnum.nextObject) {
            for (NSInteger i = _courseIdxPaths.count; i <= indexPath.section; i++) {
                [_courseIdxPaths addObject:NSMutableArray.array];
            }
            [_courseIdxPaths[indexPath.section] addObject:indexPath];
        }
    }
    return _courseIdxPaths;
}

- (NSUInteger)showWeek {
    if (self.touchItem.nowWeek >= self.courseIdxPaths.count || self.touchItem.nowWeek < 0) {
        return 0;
    } else {
        return self.touchItem.nowWeek;
    }
}

@end
