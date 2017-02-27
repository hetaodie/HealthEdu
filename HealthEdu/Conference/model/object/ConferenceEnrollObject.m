//
//  ConferenceEnrollObject.m
//  HealthEdu
//
//  Created by weixu on 2017/2/24.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "ConferenceEnrollObject.h"

@implementation ConferenceEnrollObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.persionInfoArray = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
