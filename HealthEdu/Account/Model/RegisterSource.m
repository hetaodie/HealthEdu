//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "RegisterSource.h"
#import "HENetTask.h"
#import "PopularRecommendObject.h"

@interface RegisterSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation RegisterSource

- (void)getRegisterCode:(NSString *)aUsername {
    NSString *strURl = [NSString stringWithFormat:@"/mobile/getMsgCode.action?username=%@",aUsername];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strURl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onRegisterCodeSuccess)]) {
            [weakSelf.delegate onRegisterCodeSuccess];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onRegisterCodeError)]) {
            [self.delegate onRegisterCodeError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PopularRecommendObject *object = [[PopularRecommendObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.imageUrl = [obj objectForKey:@"picUrl"];
        object.stype = [obj objectForKey:@"stype"];
        [array addObject:object];
    }];
    return array;
}

- (void)registerWithName:(NSString *)aUsername andPWD:(NSString *)pwd andCode:(NSString *)aCode {
    NSString *strURl = [NSString stringWithFormat:@"/mobile/registerStaff.action?username=%@&password=%@&scode=%@",aUsername,pwd,aCode];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strURl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onRegisterSuccess:andPWD:)]) {
            [weakSelf.delegate onRegisterSuccess:@"1" andPWD:@"2"];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onRegisterError)]) {
            [self.delegate onRegisterError];
        }
    };
    
    [task runInMethod:HE_GET];
}


@end
