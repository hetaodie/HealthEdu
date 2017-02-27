//
//  Comment.m
//  HealthEdu
//
//  Created by weixu on 2017/2/22.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "Comment.h"

@implementation Comment
+(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds
{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    NSLog(@"传入的时间戳=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

+ (NSDate *)stringToDate:(NSString *)strdate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// NSString的时间格式
    NSDate *retdate = [dateFormatter dateFromString:strdate];
    return retdate;
}

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+(NSDictionary *)getUTCFormateDateWithBeginDate:(NSString *)beginDate andNewDate:(NSString *)newsDate  //newsDate服务器得到的时间
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *beginDateFormatted = [dateFormatter dateFromString:beginDate];
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time=[newsDateFormatted timeIntervalSinceDate:current_date];//间隔的秒数
    int days=MAX(((int)time)/(3600*24), 0) ;
    int hours=MAX(((int)time)%(3600*24)/3600, 0);
    int minute=MAX(((int)time)%(3600*24)%60, 0);
    int second =MAX(((int)time)%(3600*24)%3600, 0) ;

    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[NSString stringWithFormat:@"%d",days] forKey:@"days"];
    [dictionary setObject:[NSString stringWithFormat:@"%d",hours] forKey:@"hours"];

    [dictionary setObject:[NSString stringWithFormat:@"%d",minute] forKey:@"minute"];

    [dictionary setObject:[NSString stringWithFormat:@"%d",second] forKey:@"second"];
    return dictionary;

}
@end
