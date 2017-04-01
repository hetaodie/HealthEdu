//
//  DocorRequestSource.m
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "DocorRequestSource.h"
#import "HENetTask.h"
#import "DoctorRequestObject.h"

@implementation DocorRequestSource
- (void)getDoctorRequest:(NSString *)aUsername {
    NSString *strURl = [NSString stringWithFormat:@"/mobile/getContentList.action?stype=7&uid=%@",aUsername];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strURl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [self arrayWithObject:responseObject];
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onDoctorRequestSuess:)]) {
            [weakSelf.delegate onDoctorRequestSuess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {

    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DoctorRequestObject *object = [[DoctorRequestObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.content2 = [obj objectForKey:@"content2"];
        object.content5 = [obj objectForKey:@"content5"];
        object.contenttext = [obj objectForKey:@"contenttext"];
        [array addObject:object];
    }];
    return array;
}
@end
