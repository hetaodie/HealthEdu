//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "ConferenceSource.h"
#import "HENetTask.h"
#import "ConferenceObject.h"

@interface ConferenceSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ConferenceSource

- (void)getConference{
    HENetTask *task = [[HENetTask alloc] initWithUrlString:@"/mobile/getContentList.action?stype=9"];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onConferenceSuccess:)]) {
            NSArray *array = [self arrayWithObject:responseObject];
            [weakSelf.delegate onConferenceSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onConferenceError)]) {
            [self.delegate onConferenceError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ConferenceObject *object = [[ConferenceObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.picurl = [obj objectForKey:@"picurl"];
        object.content1 = [obj objectForKey:@"content1"];
        object.content3 = [obj objectForKey:@"content3"];

        object.content5 = [obj objectForKey:@"content5"];
        object.content6 = [obj objectForKey:@"content6"];

        [array addObject:object];
    }];
    return array;
}
@end
