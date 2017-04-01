//
//  ChangeUserInSource.m
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "ChangeUserInSource.h"
#import "HENetTask.h"
#import "UserInfoManager.h"

@implementation ChangeUserInSource
- (void)changeUserInfoWithURl:(NSString *)aUrl {

    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)aUrl, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));

    HENetTask *task = [[HENetTask alloc] initWithUrlString:encodedString];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onChangeUserInfoSussess)]) {
            [weakSelf.delegate onChangeUserInfoSussess];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onChangeUserInfoError)]) {
            [self.delegate onChangeUserInfoError];
        }
    };
    
    [task runInMethod:HE_GET];
}

@end
