//
//  MessageDetailObject.h
//  HealthEdu
//
//  Created by weixu on 2017/4/11.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDetailObject : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *picurl;
@property (nonatomic, strong) NSString *contenttext;
@property (nonatomic, strong) NSString *createdate;
@property (nonatomic, strong) NSString *viewnum;
@end
