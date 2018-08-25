//
//  HealthStoreManage.h
//  HealthKit
//
//  Created by wangxun on 2018/8/25.
//  Copyright © 2018年 wangxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>

///-------------------------
#pragma mark - DEBUG
///-------------------------
#ifdef DEBUG
#define DLog(FORMAT, ...) fprintf(stderr, "%s [Line %zd]\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define DLog(FORMAT, ...) nil
#endif


/**
 1.开启 xcode中的 HealthKit 选项
 2.配置 info.plist 文件
 */

typedef NS_ENUM(NSUInteger,HealthStorePermissionResponse) {
    HealthStorePermissionResponseError = 0,
    HealthStorePermissionResponseSuccess
};

typedef void (^HealthStorePermissionResponseBlock)(HealthStorePermissionResponse permissionResponse);

@interface HealthStoreManage : NSObject

@property (nonatomic,copy) HealthStorePermissionResponseBlock permissionResponseBlock;
@property (nonatomic,strong) HKHealthStore *store;

+(instancetype)sharedInstance;

#pragma mark - AccessPermission(获取权限)
-(void)requestHealthPermissionWithBlock:(HealthStorePermissionResponseBlock)block;

#pragma mark - StepCount(步数)

/**
 读取当前步数总和
 
 @param completion 回调
 */
-(void)readStepCountFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 读取一定时间内的步数
 
 @param startTime 开始时间 格式：2017-10-10
 @param endTime 结束时间 格式： 2017-10-15
 @param completion 回调
 */
-(void)readStepCountFromHealthStoreWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
                                      completion:(void(^)(double value,NSError *error))completion;


/**
 写入当天步数总和
 
 @param setpCount 要写入的数据
 @param completion 写入成功后回调
 */
-(void)writeStepCountToHealthStoreWithUnit:(double)setpCount completion:(void(^)(BOOL response))completion;

/**
 写入一段时间内的步数总和
 
 @param setpCount 一段时间内的步数总和
 @param startTime 开始时间
 @param endTime 结束时间
 @param completion 写入成功后回调
 */
-(void)writeStepCountToHealthStoreWithUnit:(double)setpCount startTime:(NSString *)startTime endTime:(NSString *)endTime completion:(void(^)(BOOL response))completion;

#pragma mark - Height(身高)

/**
 获取身高
 
 @param completion 获取成功后回调
 */
-(void)readHeightFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 修改身高
 
 @param Height 要修改的数值
 @param completion 修改成功后回调
 */
-(void)writeHeightToHealthStoreWithUnit:(double)Height completion:(void(^)(BOOL response))completion;

#pragma mark - BodyMass(体重)

/**
 获取体重  kg
 
 @param completion 回去成功调用
 */
-(void)readBodyMassFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 修改体重
 
 @param bodyMass 要修改的数值 kg
 @param completion 修改成功回调
 */
-(void)writeBodyMassToHealthStoreWithUnit:(double)bodyMass completion:(void(^)(BOOL response))completion;

#pragma mark - BodyMassIndex(身体质量指数)

/**
 获取身体质量指数
 
 @param completion 获取成功调用
 */
-(void)readBodyMassIndexFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 修改身体质量指数
 
 @param bodyMassIndex 质量指数值
 @param completion 修改成功调用
 */
-(void)writeBodyMassIndexToHealthStoreWithUnit:(double)bodyMassIndex completion:(void(^)(BOOL response))completion;

#pragma mark - DistanceWalkingRunning(步行+跑步距离)

/**
 获取步数+跑步的总距离
 
 @param completion 获取成功回调
 */
-(void)readDistanceWalkingRunningFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 修改步数+跑步的距离
 
 @param distanceWalkingRunning 要修改的数值
 @param completion 回调
 */
-(void)writeDistanceWalkingRunningToHealthStoreWithUnit:(double)distanceWalkingRunning completion:(void(^)(BOOL response))completion;

#pragma mark - FlightsClimbed(以爬楼层)

/**
 获取已爬楼层
 
 @param completion 回调
 */
-(void)readFlightsClimbedFromHealthStoreWithCompletion:(void(^)(NSInteger value,NSError *error))completion;

/**
 修改已爬的楼层
 
 @param flightsClimbed 楼层数
 @param completion 回调
 */
-(void)writeFlightsClimbedToHealthStoreWithUnit:(NSInteger)flightsClimbed completion:(void(^)(BOOL response))completion;

#pragma mark - RespiratoryRate(呼吸速率)
-(void)readRespiratoryRateFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 获取呼吸速率
 
 @param respiratoryRate 呼吸速率
 @param completion 回调
 */
-(void)writeRespiratoryRateToHealthStoreWithUnit:(double)respiratoryRate completion:(void(^)(BOOL response))completion;

#pragma mark - DietaryEnergyConsumed(膳食能量消耗)

/**
 获取膳食能量消耗
 
 @param completion 回调
 */
-(void)readDietaryEnergyConsumedFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 修改膳食能量消耗
 
 @param dietaryEnergyConsumed 数值
 @param completion 回调
 */
-(void)writeDietaryEnergyConsumedToHealthStoreWithUnit:(double)dietaryEnergyConsumed completion:(void(^)(BOOL response))completion;

#pragma mark - OxygenSaturation(血氧饱和度)

/**
 获取血氧饱和度
 
 @param completion 回调
 */
-(void)readOxygenSaturationFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

#pragma mark - BodyTemperature(体温)

/**
 获取体温
 
 @param completion 回调
 */
-(void)readBodyTemperatureFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 修改体温
 
 @param bodyTemperature 体温值
 @param completion 回调
 */
-(void)writeBodyTemperatureToHealthStoreWithUnit:(double)bodyTemperature completion:(void(^)(BOOL response))completion;
#pragma mark - BloodGlucose(血糖)

/**
 获取血糖值
 
 @param completion 回调
 */
-(void)readBloodGlucoseFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;
/// mg/dl

/**
 修改血糖值
 
 @param bloodGlucose 血糖值 mg/dl
 @param completion 回调
 */
-(void)writeBloodGlucoseToHealthStoreWithUnit:(double)bloodGlucose completion:(void(^)(BOOL response))completion;

#pragma mark - BloodPressure(血压)

/**
 读取血压收缩值
 
 @param completion 回调
 */
-(void)readBloodPressureSystolicFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 修改血压收缩值
 
 @param bloodPressureSystolic 血压收缩值
 @param completion 回调
 */
-(void)writeBloodPressureSystolicToHealthStoreWithUnit:(double)bloodPressureSystolic completion:(void(^)(BOOL response))completion;

/**
 读取血压扩张值
 
 @param completion 回调
 */
-(void)readBloodPressureDiastolicFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

/**
 修改血压扩张值
 
 @param bloodPressureDiastolic 血压扩张值
 @param completion 回调
 */
-(void)writeBloodPressureDiastolicToHealthStoreWithUnit:(double)bloodPressureDiastolic completion:(void(^)(BOOL response))completion;

#pragma mark - StandHour(站立小时)

/**
 获取站立的小时数值
 
 @param completion 回调
 */
-(void)readStandHourFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;

#pragma mark - BiologicalSex(性别)

/**
 获取性别
 
 @param completion 回调
 */
-(void)readBiologicalSexFromHealthStoreWithCompletion:(void(^)(NSString *sex,NSError *error))completion;

#pragma mark - DateOfBirth(出生日期)

/**
 获取出生日期
 
 @param completion 回调
 */
-(void)readDateOfBirthFromHealthStoreWithCompletion:(void(^)(NSDate *date,NSError *error))completion;


#pragma mark - BloodType(血型)

/**
 回去血型
 
 @param completion 回调
 */
-(void)readBloodTypeFromHealthStoreWithCompletion:(void(^)(NSString *bloodType,NSError *error))completion;


#pragma mark - FitzpatrickSkin(日光反应型皮肤类型)

/**
 获取日光反应型皮肤类型
 
 @param completion completion description
 */
-(void)readFitzpatrickSkinFromHealthStoreWithCompletion:(void(^)(NSString *skinType,NSError *error))completion;

#pragma mark - SleepAnalysis(睡眠分析)

/**
 获取睡眠分析指
 
 @param completion 回答
 */
-(void)readSleepAnalysisFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;


#pragma mark - MenstrualFlow(月经)

/**
 获取最近一次月经
 
 @param completion 回答
 */
-(void)readMenstrualFlowFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;


///-------------------------
#pragma mark - IntermenstrualBleeding(点滴出血)
/**
 读取点滴出血
 
 @param completion 回调
 */
-(void)readIntermenstrualBleedingFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;


///-------------------------
#pragma mark - SexualActivity(性行为)
/**
 获取最近一次性行为
 
 @param completion 回调
 */
-(void)readSexualActivityFromHealthStoreWithCompletion:(void(^)(double value,NSError *error))completion;


@end
