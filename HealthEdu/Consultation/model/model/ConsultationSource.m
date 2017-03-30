//
//  HomePageModelSource.m
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "ConsultationSource.h"
#import "HENetTask.h"
#import "PopularRecommendObject.h"
#import "ConsultationObject.h"
#import "ConsultationListObject.h"

@interface ConsultationSource()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ConsultationSource

- (void)getConsultation{
    HENetTask *task = [[HENetTask alloc] initWithUrlString:@"/mobile/getCategory.action?catid=6"];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onConsultationSuccess:)]) {
            NSArray *array = [self arrayWithObject:responseObject];
            [weakSelf.delegate onConsultationSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onConsultationError)]) {
            [self.delegate onConsultationError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ConsultationObject *object = [[ConsultationObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        [array addObject:object];
    }];
    return array;
}


- (void)getConsultationDetail:(NSString *)aId {
    NSString *strURL = [NSString stringWithFormat:@"/mobile/getContentList.action?catid=%@",aId];
    HENetTask *task = [[HENetTask alloc] initWithUrlString:strURL];
    __weak __typeof(self) weakSelf = self;
    task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onConsultationDetailSuccess:)]) {
            NSArray *array = [self arrayWithListObject:responseObject];
            [weakSelf.delegate onConsultationDetailSuccess:array];
        }
    };
    
    task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onConsultationDetailError)]) {
            [self.delegate onConsultationDetailError];
        }
    };
    
    [task runInMethod:HE_GET];
}

- (NSArray *)arrayWithListObject:(NSArray *)Aarray{
    NSMutableArray *array = [NSMutableArray array];
    [Aarray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ConsultationListObject *object = [[ConsultationListObject alloc] init];
        object.title = [obj objectForKey:@"title"];
        object.id = [obj objectForKey:@"id"];
        object.phone = [obj objectForKey:@"phone"];
        
        object.content1 = [obj objectForKey:@"content1"];
        object.latitude = [obj objectForKey:@"content3"];
        object.longitude = [obj objectForKey:@"content4"];
        
        [array addObject:object];
    }];
    return array;
}
@end
