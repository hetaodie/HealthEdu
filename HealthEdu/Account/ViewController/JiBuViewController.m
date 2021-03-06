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
#import "UIColor+HEX.h"


@interface JiBuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *todayBushu;
@property (weak, nonatomic) IBOutlet UILabel *todayKm;
@property (weak, nonatomic) IBOutlet UIView *weekView;
@property (nonatomic, strong) NSDate *toDate;
@property (nonatomic, strong) NSDate *fromDate;
@property (weak, nonatomic) IBOutlet UILabel *todaykll;

@property (nonatomic, strong) NSMutableDictionary *pedNumDic;
@property (nonatomic, strong) DSBarChart *chrt;
@property (nonatomic,assign) NSInteger todayNum;

typedef void (^GetPedometerNum)(NSInteger pednu,CGFloat distance );

@end

@implementation JiBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pedNumDic = [[NSMutableDictionary alloc] init];
    
    //[self getDateInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getDateInfo];
}

- (void) getDateInfo
{
    NSDate * date  = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    
    NSLog(@"星期 =weekDay = %ld ",(long)comps.weekday);
    
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
    self.todayNum = num;
    NSInteger sum = 0;

    [self getPedNumTheDayWithNum:^(NSInteger pednum,CGFloat distance) {
        [self.pedNumDic setObject:@(pednum) forKey:@(num)];
        self.todayBushu.text = [NSString stringWithFormat:@"%ld",(long)pednum];
        self.todayKm.text = [NSString stringWithFormat:@"%.2f",distance];
         [self drawQ];
    }];
    
    self.toDate = [NSDate date];
    while (num > 2) {
        sum+=1;
        NSDate *date = [self getDateBackDay:sum];
        num = [self getWeekDayWithDate:date];
        [self getPedFromDay:date toDay:self.toDate withNum:^(NSInteger pednum,CGFloat distance) {
            [self.pedNumDic setObject:@(pednum) forKey:@(num)];
            [self drawQ];
        }];
        self.toDate = date;
    }
    

    NSLog(@"pedDic = %@",self.pedNumDic);
}

- (void)drawQ {
    NSInteger count = [[self.pedNumDic allKeys] count];
    NSArray *allkeys = [self.pedNumDic allKeys];
    
    NSMutableArray  *vals = [[NSMutableArray alloc] init];
    NSMutableArray  *refs = [[NSMutableArray alloc] init];
    if (count != (self.todayNum -1)) {
        return;
    }
    
    for (int i = 1; i<=count; i++) {

        NSNumber *num = [NSNumber numberWithInt:i+1];
        if (![allkeys containsObject:num]) {
            continue;
        }
        [vals addObject:[self.pedNumDic objectForKey:num]];
        [refs addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    if ([vals count] ==0 || [refs count] == 0) {
        return;
    }
    
    UIColor *color = [UIColor colorWithHexString:@"0099e6" alpha:1.0];
    self.chrt = [[DSBarChart alloc] initWithFrame:self.weekView.bounds
                                            color:color
                                       references:refs
                                        andValues:vals];
    self.chrt.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.chrt.bounds = self.weekView.bounds;
    [self.weekView addSubview:self.chrt];
    
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
         queryPedometerDataFromDate:fromDay
         toDate:toDay
         withHandler:^(QYPedometerData *pedometerData, NSError *error) {
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


@end
