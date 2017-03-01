//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "AboutSource.h"
#import "HENetTask.h"


@interface AboutSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation AboutSource

- (AboutObject *)userInfoWithObject:(NSDictionary *)aDic{
    AboutObject *userinfo = [[AboutObject alloc] init];
    
    userinfo.id = aDic[@"id"];
    userinfo.title = aDic[@"title"];
    userinfo.contenttext = aDic[@"contenttext"];
    userinfo.createdate = aDic[@"createdate"];
    userinfo.viewnum = aDic[@"viewnum"];
    return userinfo;
}

- (void)getAboutWithName {
    NSString *strURl = @"/mobile/getContentDetail.action?cid=1";
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strURl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onAboutSuccess:)]) {
            AboutObject *info =[self userInfoWithObject:responseObject];
            [weakSelf.delegate onAboutSuccess:info];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onAboutError)]) {
            [self.delegate onAboutError];
        }
    };
    
    [task runInMethod:HE_GET];
}


@end
