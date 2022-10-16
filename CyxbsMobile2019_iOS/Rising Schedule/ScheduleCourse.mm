//
//  ScheduleCourse.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/23
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ScheduleCourse.h"

#import "ScheduleCourse+WCTTableCoding.h"

@interface ScheduleCourse ()

/// 存储period
@property (nonatomic) NSInteger period_location;

/// 存储period
@property (nonatomic) NSUInteger period_lenth;

@end

#pragma mark - SchoolLesson

@implementation ScheduleCourse

WCDB_IMPLEMENTATION(ScheduleCourse)

WCDB_SYNTHESIZE(ScheduleCourse, inWeek)
WCDB_SYNTHESIZE(ScheduleCourse, inSections)
WCDB_SYNTHESIZE(ScheduleCourse, period_location)
WCDB_SYNTHESIZE(ScheduleCourse, period_lenth)

WCDB_SYNTHESIZE(ScheduleCourse, course)
WCDB_SYNTHESIZE(ScheduleCourse, courseNike)
WCDB_SYNTHESIZE(ScheduleCourse, classRoom)
WCDB_SYNTHESIZE(ScheduleCourse, classRoomNike)

WCDB_SYNTHESIZE(ScheduleCourse, courseID)
WCDB_SYNTHESIZE(ScheduleCourse, rawWeek)
WCDB_SYNTHESIZE(ScheduleCourse, type)

WCDB_SYNTHESIZE(ScheduleCourse, teacher)
WCDB_SYNTHESIZE(ScheduleCourse, lesson)

#pragma mark - Init

- (instancetype) initWithDictionary:(NSDictionary *)dic {
    
    BOOL check = (!dic || dic.count < 10);
    if (check) {
        NSAssert(!check, @"\n🔴%s dic : %@", __func__, dic);
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.inWeek = [dic[@"hash_day"] intValue] + 1;
        id weekAry = dic[@"week"];
        if ([weekAry isKindOfClass:NSArray.class]) {
            NSMutableSet *set = NSMutableSet.set;
            for (NSNumber *a in weekAry) {
                [set addObject:a];
            }
            self.inSections = set;
        }
        self.period_location = [dic[@"begin_lesson"] longValue];
        self.period_lenth = [dic[@"period"] unsignedLongValue];
        self.course = dic[@"course"];
        self.classRoom = dic[@"classroom"];
        self.courseID = dic[@"course_num"];
        self.rawWeek = dic[@"rawWeek"];
        self.type = dic[@"type"];
        self.teacher = dic[@"teacher"];
        self.lesson = dic[@"lesson"];
    }
    return self;
}

#pragma mark - Getter

- (NSRange)period {
    if (_period_location < 0) {
        _period_location = 12 - _period_location;
    }
    
    return NSMakeRange(_period_location, _period_lenth);
}

- (NSString *)descriptionv{
    return [NSString stringWithFormat:@"%@", @{
        @"周" : @(_inWeek)
    }];
}

@end
