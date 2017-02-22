//
//  Comment.h
//  HealthEdu
//
//  Created by weixu on 2017/2/22.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
+(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds;

+ (NSDate *)stringToDate:(NSString *)strdate;

+ (NSString *)dateToString:(NSDate *)date;
@end
