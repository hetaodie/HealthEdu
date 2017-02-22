//
//  ConsultDetailObject.h
//  HealthEdu
//
//  Created by weixu on 2017/2/20.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultDetailObject : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *picurl;
@property (nonatomic, strong) NSString *contenttext;  //内容
@property (nonatomic, assign) long long createddate;
@property (nonatomic, strong) NSString *content1;     //来源
@end
