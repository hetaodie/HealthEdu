//
//  ConsultListObject.h
//  HealthEdu
//
//  Created by weixu on 2017/2/20.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsultListObject : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *stitle;
@property (nonatomic, strong) NSString *picurl;
@property (nonatomic, assign) long long createDate;
@end
