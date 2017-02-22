//
//  ConferenceObject.h
//  HealthEdu
//
//  Created by weixu on 2017/2/23.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConferenceObject : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *picurl;

@property (nonatomic, strong) NSString *content1;  //会议地址
@property (nonatomic, strong) NSString *content3;  //会议时间
@property (nonatomic, strong) NSString *content5;  //会议总人数
@property (nonatomic, strong) NSString *content6;  //已报人数

@end
