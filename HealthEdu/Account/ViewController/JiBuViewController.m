//
//  JiBuViewController.m
//  HealthEdu
//
//  Created by weixu on 2017/4/2.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "JiBuViewController.h"
#import "DSBarChart.h"
#import "QYPedometerManager.h"


@interface JiBuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *todayBushu;
@property (weak, nonatomic) IBOutlet UILabel *todayKm;
@property (weak, nonatomic) IBOutlet UIView *weekView;
@property (nonatomic, strong) NSDate *toDate;
@property (nonatomic, strong) NSDate *fromDate;
@property (weak, nonatomic) IBOutlet UILabel *todaykll;

@property (nonatomic, strong) NSMutableDictionary *pedNumDic;
@property (nonatomic, strong) DSBarChart *chrt;

typedef void (^GetPedometerNum)(NSInteger pednu,CGFloat distance );

@end

@implementation JiBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDateInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void) getDateInfo
{
    NSDate * date  = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    
    NSLog(@"星期 =weekDay = %ld ",comps.weekday);
    
    NSTimeInterval timeS = 24*60*60;
    NSTimeInterval  nowTimeS = [date timeIntervalSince1970];
    NSTimeInterval totalTime = nowTimeS - timeS ;
    NSDate * date1 = [NSDate dateWithTimeIntervalSince1970:totalTime];
    NSDateComponents *comps1 = [calendar components:NSCalendarUnitWeekday fromDate:date1];
    
    NSLog(@"星期 =weekDay = %ld ",comps1.weekday);
    
    NSInteger num = [self getWeekDayWithDate:[NSDate date]];
    
    if (num == 1) {
        num = 8;
    }
    NSInteger sum = 0;
    
    [self getPedNumTheDayWithNum:^(NSInteger pednum,CGFloat distance) {
        [self.pedNumDic setObject:@(pednum) forKey:@(num)];
        self.todayBushu.text = [NSString stringWithFormat:@"%ld",(long)pednum];
        self.todayKm.text = [NSString stringWithFormat:@"%f",distance];
        
    }];
    
    self.toDate = [NSDate date];
    while (num > 1) {
        sum+=1;
        NSDate *date = [self getDateBackDay:sum];
        num = [self getWeekDayWithDate:date];
        [self getPedFromDay:date toDay:self.toDate withNum:^(NSInteger pednum,CGFloat distance) {
            [self.pedNumDic setObject:@(pednum) forKey:@(num)];
        }];
    }
    
    NSInteger count = [[self.pedNumDic allKeys] count];
    
    NSMutableArray  *vals = [[NSMutableArray alloc] init];
    NSMutableArray  *refs = [[NSMutableArray alloc] init];

    for (int i = 1; i<=count; i++) {
        NSNumber *num = [NSNumber numberWithInt:i];
        [vals addObject:[self.pedNumDic objectForKey:num]];
        [refs addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    self.chrt = [[DSBarChart alloc] initWithFrame:self.weekView.bounds
                                                   color:[UIColor greenColor]
                                              references:refs
                                               andValues:vals];
    self.chrt.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.chrt.bounds = self.weekView.bounds;
    [self.weekView addSubview:self.chrt];
    
    NSLog(@"pedDic = %@",self.pedNumDic);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.chrt.frame = self.weekView.bounds;
}


- (void)getPedNumTheDayWithNum:(GetPedometerNum)block{
    if ([QYPedometerManager isStepCountingAvailable]) {
        [[QYPedometerManager shared]
         startPedometerUpdatesTodayWithHandler:^(QYPedometerData *pedometerData,
                                                 NSError *error) {
             if (!error) {
                 block([pedometerData.numberOfSteps integerValue],[pedometerData.distance floatValue]);
             }
         }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"此设备不支持记步功能"
                                  message:@"仅支持iPhone5s及其以上设备"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

- (void)getPedFromDay:(NSDate *)fromDay toDay:(NSDate *)toDay withNum:(GetPedometerNum)block {
    
    if ([QYPedometerManager isStepCountingAvailable]) {
        [[QYPedometerManager shared]
         startPedometerUpdatesTodayWithHandler:^(QYPedometerData *pedometerData,
                                                 NSError *error) {
             if (!error) {
                 block([pedometerData.numberOfSteps integerValue],[pedometerData.distance floatValue]);
             }
         }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"此设备不支持记步功能"
                                  message:@"仅支持iPhone5s及其以上设备"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

- (NSInteger)getWeekDayWithDate:(NSDate *)aDate {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:aDate];
    return comps.weekday;
}

- (NSDate *)getDateBackDay:(NSInteger) aNum {
    NSDate * date  = [NSDate date];
    NSTimeInterval timeS = 24*60*60*aNum;
    NSTimeInterval  nowTimeS = [date timeIntervalSince1970];
    NSTimeInterval totalTime = nowTimeS - timeS ;
    NSDate * date1 = [NSDate dateWithTimeIntervalSince1970:totalTime];
    return date1;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
