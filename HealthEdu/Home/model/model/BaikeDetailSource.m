//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "ConsultDetailSource.h"
#import "HENetTask.h"


@interface ConsultDetailSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ConsultDetailSource

- (void)getCousultDetailWithId:(NSString *)aId{
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/getContentDetail.action?cid=%@",aId];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onConsultDetailSourceSuccess:)]) {
            ConsultDetailObject *object = [self arrayWithObject:responseObject];
            [weakSelf.delegate onConsultDetailSourceSuccess:object];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onConsultDetailSourceError)]) {
            [self.delegate onConsultDetailSourceError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (ConsultDetailObject *)arrayWithObject:(NSDictionary *)aDictionary{
    ConsultDetailObject *object = [[ConsultDetailObject alloc] init];
    object.id = [aDictionary objectForKey:@"id"];
    object.title = [aDictionary objectForKey:@"title"];
    object.picurl = [aDictionary objectForKey:@"picurl"];
    object.content1 = [aDictionary objectForKey:@"content1"];
    object.contenttext = [aDictionary objectForKey:@"contenttext"];
    object.createddate = [[aDictionary objectForKey:@"createdDate"] longLongValue];
    return object;
}
@end
