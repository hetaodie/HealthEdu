//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "MessageDetailSource.h"
#import "HENetTask.h"
#import "MessageDetailObject.h"


@interface MessageDetailSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation MessageDetailSource

- (void)getMessageDetailWithId:(NSString *)aId{
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/getContentDetail.action?cid=%@",aId];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onMessageDetailSourceSuccess:)]) {
            MessageDetailObject *object = [self arrayWithObject:responseObject];
            [weakSelf.delegate onMessageDetailSourceSuccess:object];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onMessageDetailSourceError)]) {
            [self.delegate onMessageDetailSourceError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (MessageDetailObject *)arrayWithObject:(NSDictionary *)aDictionary{
    MessageDetailObject *object = [[MessageDetailObject alloc] init];
    object.id = [aDictionary objectForKey:@"id"];
    object.title = [aDictionary objectForKey:@"title"];
    object.contenttext = [aDictionary objectForKey:@"contenttext"];
    object.createdate = [aDictionary objectForKey:@"createDate"];
    
    object.viewnum = [aDictionary objectForKey:@"viewnum"];
    object.picurl = [aDictionary objectForKey:@"picurl"];
    return object;
}
@end
