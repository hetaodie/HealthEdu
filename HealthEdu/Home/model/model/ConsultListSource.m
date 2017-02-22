//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "ConsultListSource.h"
#import "HENetTask.h"
#import "ConsultClassifyObject.h"
#import "ConsultListObject.h"


@interface ConsultListSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ConsultListSource

- (void)getConsultClassicySource{
    HENetTask *task = [[HENetTask alloc] initWithUrlString:@"/mobile/getCategory.action?catid=2"];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onConsultClassicySourceSuccess:)]) {
            NSArray *array = [self classicyArrayWithObject:responseObject];
            [weakSelf.delegate onConsultClassicySourceSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onConsultClassicySourceError)]) {
            [self.delegate onConsultClassicySourceError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)classicyArrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ConsultClassifyObject *object = [[ConsultClassifyObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        [array addObject:object];
    }];
    return array;
}

- (void)getConsultListSource:(NSString *)aId{
    NSString *strUrl = [NSString stringWithFormat:@"/mobile/getContentList.action?cid=%@",aId];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strUrl];

    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onConsultListSourceSuccess:)]) {
            NSArray *array = [self listarrayWithObject:responseObject];
            [weakSelf.delegate onConsultListSourceSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onConsultListSourceError)]) {
            [self.delegate onConsultListSourceError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)listarrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ConsultListObject *object = [[ConsultListObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.picurl = [obj objectForKey:@"picurl"];
        object.createDate = [[obj objectForKey:@"createdate"] longLongValue];
        object.stitle = [obj objectForKey:@"stitle"];
        
        [array addObject:object];
    }];
    return array;
}
@end
