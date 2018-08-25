//
//  ViewController.m
//  HealthKit
//
//  Created by wangxun on 2018/8/25.
//  Copyright © 2018年 wangxun. All rights reserved.
//

#import "ViewController.h"
#import "HealthStoreManage.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.dataSource = @[
                        @[@"请求权限"],
                        @[@"读取当天总步数",@"读取一定时间内的步数",@"写入当天总步数",@"吸入一定时间段的步数"],
                        @[@"读取身高",@"写入身高"],
                        @[@"读取体重",@"写入体重",],
                        @[@"读取身体质量指数",@"写入身体质量指数"],
                        @[@"读取步数加跑步距离",@"写入步数加跑步距离"],
                        @[@"读取当前已爬楼层",@"写入当前已爬楼层",],
                        @[@"读取呼吸速率",@"写入当前已爬楼层"],
                        @[@"读取膳食能量消耗",@"写入膳食能量消耗"],
                        @[@"血氧饱和度"],
                        @[@"读取体温",@"写入体温"],
                        @[@"读取血糖",@"写入血糖"],
                        @[@"读取血压收缩值",@"写入血压收缩值",@"读取血压舒张值",@"写入血压舒张值"],
                        @[@"读取当天站立小时"],
                        @[@"读取性别"],
                        @[@"读取出生年月日"],
                        @[@"读取血型"],
                        @[@"读取日光反应型皮肤类型"],
                        @[@"读取睡眠分析"],
                        @[@"读取最近一次月经",],
                        @[@"读取点滴出血"],
                        @[@"读取最近一次性行为"]
                        ];
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionDataSorce = self.dataSource[section];
    return sectionDataSorce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    NSArray *sectionDataSorce = self.dataSource[indexPath.section];
    NSString *title = sectionDataSorce[indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"获取权限";
        case 1:
            return @"步数";
        case 2:
            return @"身高";
        case 3:
            return @"体重";
        case 4:
            return @"身体质量指数";
        case 5:
            return @"步行+跑步距离";
        case 6:
            return @"已爬路层";
        case 7:
            return @"呼吸速率";
        case 8:
            return @"膳食能量消耗";
        case 9:
            return @"血氧饱和度";
        case 10:
            return @"体温";
        case 11:
            return @"血糖";
        case 12:
            return @"血压";
        case 13:
            return @"站立小时";
        case 14:
            return @"性别";
        case 15:
            return @"出生日期";
        case 16:
            return @"血型";
        case 17:
            return @"日光反应型皮肤类型";
        case 18:
            return @"睡眠分析";
        case 19:
            return @"月经";
        case 20:
            return @"点滴出血";
        case 21:
            return @"性行为";
            
        default:
            return @"";
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            
            //获取权限
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] requestHealthPermissionWithBlock:^(HealthStorePermissionResponse permissionResponse) {
                    if (permissionResponse == HealthStorePermissionResponseError) {
                        NSLog(@"请求失败");
                    }else{
                        NSLog(@"请求成功");
                    }
                }];
            }
        }
            break;
        case 1: //步数
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readStepCountFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"获取的步数为%f====",value);
                    
                }];
            }else if (indexPath.row == 1){
                [[HealthStoreManage sharedInstance] readStepCountFromHealthStoreWithStartTime:@"2018-05-06" endTime:@"2018-09-10" completion:^(double value, NSError *error) {
                    NSLog(@"5月6日-9月10的步数总和为为%f====",value);
                }];
                
            }else if (indexPath.row == 2){
                [[HealthStoreManage sharedInstance] writeStepCountToHealthStoreWithUnit:9.0 completion:^(BOOL response) {
                    if (response) {
                        NSLog(@"修改当天步数成功");
                    }
                    
                }];
            }else if (indexPath.row == 3){
                [[HealthStoreManage sharedInstance] writeStepCountToHealthStoreWithUnit:8888 startTime:@"2018-01-10" endTime:@"2018-10-10" completion:^(BOOL response) {
                    if (response) {
                        NSLog(@"修改1月10-10月10的步数总和为8888成功");
                    }
                }];
            }
        }
        case 2:  //身高
        {
            
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readHeightFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"身高为---%f",value);
                }];
                
            } else if (indexPath.row == 1) {
                [[HealthStoreManage sharedInstance] writeHeightToHealthStoreWithUnit:1.9 completion:^(BOOL response) {
                    NSLog(@"修改身高成功");
                }];
                
            }
            
        }
        case 3:
        {
            //体重
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readBodyMassFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"体重为---%f",value);
                }];
                
            } else if (indexPath.row == 1) {
                [[HealthStoreManage sharedInstance] writeBodyMassToHealthStoreWithUnit:1.0 completion:^(BOOL response) {
                    if (response) {
                        NSLog(@"修改体重成功");
                    }
                }];
            }
            
        }
            //身体质量指数
        case 4:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readBodyMassIndexFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"身体质量指数为===%f",value);
                }];
                
                
            }else if (indexPath.row == 1){
                [[HealthStoreManage sharedInstance] writeBodyMassIndexToHealthStoreWithUnit:22.0 completion:^(BOOL response) {
                    if (response) {
                        NSLog(@"修改身体质量数值成功");
                    }
                }];
            }
            
        }
            
            //步行+跑步距离
        case 5:
        {
            
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readDistanceWalkingRunningFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"获取当天步数+跑步距离为==%f",value);
                }];
            }else if (indexPath.row == 1){
                [[HealthStoreManage sharedInstance] writeDistanceWalkingRunningToHealthStoreWithUnit:20.0 completion:^(BOOL response) {
                    if (response) {
                        NSLog(@"修改步数+跑步距离为20km 成功");
                    }
                }];
            }
            
        }
            
            //以爬楼层
        case 6:
        {
            
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readFlightsClimbedFromHealthStoreWithCompletion:^(NSInteger value, NSError *error) {
                    NSLog(@"获得已爬楼层为=====%ld",value);
                }];
            }else if (indexPath.row == 1){
                
                [[HealthStoreManage sharedInstance] writeFlightsClimbedToHealthStoreWithUnit:3.0 completion:^(BOOL response) {
                    if (response) {
                        NSLog(@"修改已爬楼层为====3层");
                    }
                }];
                
            }
            
        }
            
            //呼吸速率
        case 7:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readRespiratoryRateFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"呼吸速率为====%f",value);
                }];
                
            }else if (indexPath.row == 1){
                [[HealthStoreManage sharedInstance] writeRespiratoryRateToHealthStoreWithUnit:10 completion:^(BOOL response) {
                    if (response) {
                        NSLog(@"修改呼吸速率为====10");
                    }
                }];
                
                
            }
        }
            
            //膳食能量消耗
        case 8:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readDietaryEnergyConsumedFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"呼吸速率为====%f",value);
                }];
                
            }else if (indexPath.row == 1){
                [[HealthStoreManage sharedInstance] writeDietaryEnergyConsumedToHealthStoreWithUnit:10 completion:^(BOOL response) {
                    NSLog(@"修膳食能量消耗为====10");
                }];
                
            }
            
        }
            
            //血氧饱和度
        case 9:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance]readOxygenSaturationFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"血氧饱和度为====%f",value);
                }];
            }
            
        }
            
            //体温
        case 10:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readBodyTemperatureFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"体温为====%f",value);
                }];
            }else if (indexPath.row == 1){
                [[HealthStoreManage sharedInstance] writeBodyTemperatureToHealthStoreWithUnit:30 completion:^(BOOL response) {
                    NSLog(@"体温====30");
                }];
                
            }
            
        }
            //血糖
        case 11:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readBloodGlucoseFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"血糖为====%f",value);
                }];
            }else if (indexPath.row == 1){
                [[HealthStoreManage sharedInstance] writeBloodGlucoseToHealthStoreWithUnit:40 completion:^(BOOL response) {
                    NSLog(@"修改体温为====40");
                }];
                
            }
            
        }
            
            //血压
        case 12:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readBloodPressureSystolicFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"血压扩张值为====%f",value);
                }];
            }else if (indexPath.row == 1){
                [[HealthStoreManage sharedInstance] writeBloodPressureSystolicToHealthStoreWithUnit:10 completion:^(BOOL response) {
                    NSLog(@"修改血压扩张为====100");
                }];
                
            }else if (indexPath.row == 2){
                [[HealthStoreManage sharedInstance] readBloodPressureDiastolicFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"血压收缩值为====%f",value);
                }];
            }else if (indexPath.row == 3){
                
                [[HealthStoreManage sharedInstance] writeBloodPressureDiastolicToHealthStoreWithUnit:10 completion:^(BOOL response) {
                    NSLog(@"修改血压收缩为====200");
                }];
            }
            
        }
            //站立小时
        case 13:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readStandHourFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"站立小时为====%f",value);
                }];
            }
            
        }
            
            //性别
        case 14:
        {
            
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readBiologicalSexFromHealthStoreWithCompletion:^(NSString *sex, NSError *error) {
                    NSLog(@"性别为====%@",sex);
                }];
            }
            
        }
            
            //出生日期
        case 15:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readDateOfBirthFromHealthStoreWithCompletion:^(NSDate *date, NSError *error) {
                    NSLog(@"出生日期为====%@",date);
                }];
            }
            
        }
            //血型
        case 16:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readBloodTypeFromHealthStoreWithCompletion:^(NSString *bloodType, NSError *error) {
                    NSLog(@"血型为为====%@",bloodType);
                }];
            }
            
        }
            
            //日光反应型皮肤类型
        case 17:
        {
            
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readFitzpatrickSkinFromHealthStoreWithCompletion:^(NSString *bloodType, NSError *error) {
                    NSLog(@"日光反应型皮肤类型为====%@",bloodType);
                }];
            }
            
        }
            
            //睡眠分析
        case 18:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readSleepAnalysisFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"睡眠分析为====%f",value);
                }];
            }
            
        }
            //月经
        case 19:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readMenstrualFlowFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"最近月经为====%f",value);
                }];
                
            }
            
        }
            //点滴出血
        case 20:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readIntermenstrualBleedingFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"点滴出血为====%f",value);
                }];
            }
            
        }
            
            //性行为
        case 21:
        {
            if (indexPath.row == 0) {
                [[HealthStoreManage sharedInstance] readSexualActivityFromHealthStoreWithCompletion:^(double value, NSError *error) {
                    NSLog(@"最近性行为为====%f",value);
                }];
            }
            
        }
            
            break;
            
        default:
            break;
    }
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    }
    return _tableView;
}
@end

