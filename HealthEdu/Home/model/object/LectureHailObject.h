//
//  LectureHailObject.h
//  HealthEdu
//
//  Created by weixu on 2017/2/22.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LectureHailObject : NSObject <NSCoding>
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *picurl;
@property (nonatomic, strong) NSString *content1; //视频地址
@property (nonatomic, strong) NSString *content2; //视频长度
@property (nonatomic, strong) NSString *exturl;
@end
