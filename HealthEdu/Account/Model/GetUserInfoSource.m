//
//  GetUserInfoSource.m
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "GetUserInfoSource.h"
#import "HENetTask.h"

@implementation GetUserInfoSource
- (void)GetUserInfoWithuserName:(NSString *)userName {
    NSString *strURl = [NSString stringWithFormat:@"/mobile/getStaffDetail.action?username=%@",userName];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strURl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onGetuserInfoWithSussess:)]) {
            UserInfo *info =[self userInfoWithObject:responseObject];
            [weakSelf.delegate onGetuserInfoWithSussess:info];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onGetuserInfoWithError)]) {
            [self.delegate onGetuserInfoWithError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (UserInfo *)userInfoWithObject:(NSDictionary *)aDic{
    UserInfo *userinfo = [[UserInfo alloc] init];
    userinfo.userName = aDic[@"username"];
    userinfo.pwd = aDic[@"password"];
    userinfo.name = aDic[@"name"];
    userinfo.sex = aDic[@"sex"];
    
    userinfo.company = aDic[@"company"];
    userinfo.title = aDic[@"title"];
    userinfo.email = aDic[@"email"];
    userinfo.picurl = aDic[@"picurl"];
    return userinfo;
}

@end
