//
//  MessageObject.h
//  HealthEdu
//
//  Created by weixu on 2017/4/11.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageObject : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *contenttext;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *picurl;

@end
