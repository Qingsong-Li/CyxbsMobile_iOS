//
//  ScheduleInteractorRequest.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/23.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**课表Request业务
 * 创建该业务并绑定所需业务模型
 * 利用该业务进行网络CRUD行为
 * 禁止在绑定后指定其他绑定对象
 *
 * 该对象强持有数据模型，但不推荐使用该类去访问对象
 * 但可以在合适的时候通过该类去获取到所绑定的对象
 * 该对象的CRUD行为会对bindModel产生影响
 */

#import <Foundation/Foundation.h>

#import "ScheduleModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * ScheduleModelRequestType;

#pragma mark - ScheduleInteractorRequest

@interface ScheduleInteractorRequest : NSObject

/// 绑定模型
@property (nonatomic, strong, readonly) ScheduleModel *bindModel;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 根据绑定模型创建该业务
/// @param model 被绑定的模型
+ (instancetype)requestBindingModel:(ScheduleModel *)model;

#pragma mark - Method

/// 请求课表
/// @param requestDictionary 一种字典，记录如下
/// 1) 个人课表 @{student : @[@"2021215154"]}
/// 2) 多人课表 @{student : @[@"2021215154", @"2021215179"]}
/// 3) 老师课表 @{teacher : @[@"040107"]}
/// 4) 混合课表 @{student : @[@"2021215154"], teacher : @[@"040107"]}
/// @param success 成功返回
/// @param failure 失败返回
- (void)request:(NSDictionary
                 <ScheduleModelRequestType, NSArray
                 <NSString *> *> *)requestDictionary
        success:(void (^)(void))success
        failure:(void (^)(NSError *error))failure;

/// 请求事务
/// @param success 成功
/// @param failure 失败
- (void)requestCustomSuccess:(void (^)(void))success
                     failure:(void (^)(NSError *error))failure;

/// 新增事务
/// @param course 一节自定义课，记录如下
/// 1) 可使用属性: inWeek, inSections, period_location, period_lenth, course, classRoom
/// 2) 自动权属性: type
/// @param success 成功返回
/// @param failure 失败返回
- (void)appendCustom:(ScheduleCourse *)course
             success:(void (^)(void))success
             failure:(void (^)(NSError *error))failure;

/// 更改事务
/// @param course 一节自定义课，记录如下
/// 1) course必须为原来就拥有的一个模型
/// 2) 若更改了**时间**，则视图应发生变化
/// 3) 自定义检查标识符为courseID
/// @param success 成功返回
/// @param failure 失败返回
- (void)editCustom:(ScheduleCourse *)course
           success:(void (^)(void))success
           failure:(void (^)(NSError *error))failure;

/// 删除事务
/// @param course course 一节自定义课，记录如下
/// 1) 自定义检查标识符为customID
/// @param success 成功返回
/// @param failure 失败返回
- (void)deleteCustom:(ScheduleCourse *)course
             success:(void (^)(void))success
             failure:(void (^)(NSError *error))failure;

@end

#pragma mark - ScheduleModelRequestType

/// 学生
FOUNDATION_EXPORT ScheduleModelRequestType student;

/// 老师
FOUNDATION_EXPORT ScheduleModelRequestType teacher;

NS_ASSUME_NONNULL_END