//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "LoginSource.h"
#import "HENetTask.h"
#import "PopularRecommendObject.h"

@interface LoginSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LoginSource

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

- (void)LoginWithName:(NSString *)aUsername andPWD:(NSString *)pwd {
    NSString *strURl = [NSString stringWithFormat:@"/mobile/staffLogin.action?username=%@&password=%@",aUsername,pwd];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strURl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onLoginSuccess:)]) {
            UserInfo *info =[self userInfoWithObject:responseObject];
            [weakSelf.delegate onLoginSuccess:info];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onLoginError)]) {
            [self.delegate onLoginError];
        }
    };
    
    [task runInMethod:HE_GET];
}


@end
