//
//  ConferenceEnrollObject.h
//  HealthEdu
//
//  Created by weixu on 2017/2/24.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConferenceEnrollObject : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) NSMutableArray *persionInfoArray;
@end
