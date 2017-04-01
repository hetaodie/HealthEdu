//
//  DoctorRequestObject.h
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorRequestObject : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *contenttext; // 回复内容
@property (nonatomic, strong) NSString *content2; //问题
@property (nonatomic, strong) NSString *content5;
@end
