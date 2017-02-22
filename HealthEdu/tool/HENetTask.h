//
//  HENetTask.h
//  TestAFNetWorking
//
//  Created by hzzhanyawei on 16/7/2.
//  Copyright © 2016年 hzzhanyawei. All rights reserved.
//

/*************************Example************************************/
//HENetTask *task = [[HENetTask alloc] initWithUrlString:@"/mobile/getCategory.action?catid=4"];
//__weak __typeof(self) weakSelf = self;
//task.successBlock = ^(NSURLSessionDataTask *task, id responseObject) {
//    NSLog(@"%@", responseObject);
//    if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(getMainPageDataSuccess:)]) {
//        [weakSelf.delegate getMainPageDataSuccess:responseObject];
//    }
//};
//
//task.failedBlock = ^(NSURLSessionDataTask *task, NSError *error) {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(getMainPageDataFailed:)]) {
//        [self.delegate getMainPageDataFailed:error];
//    }
//};
//
//[task runInMethod:HE_GET];

#import <Foundation/Foundation.h>
/**
 *  HTTP请求类型
 */
typedef NS_ENUM(NSInteger, HEHttpMethod){
    HE_GET,
    HE_POST,
    HE_PUT,
    HE_DELETE
};

//static const NSString *HEHttpServer = @"http://app.jiankangbolan.com";//@"http://121.40.79.118/jkbl/";
//static const NSString *HEHttpServer = @"http://202.75.210.186";//@"http://121.40.79.118/jkbl/";
static const NSString *HEHttpServer = @"http://app.jiankangbolan.com";//@"http://121.40.79.118/jkbl/";

typedef void(^HENetTaskSuccessBlock)(NSURLSessionDataTask *, id);
typedef void(^HENetTaskFailedBlock)(NSURLSessionDataTask *, NSError *);

@interface HENetTask : NSObject
/**
 *  请求成功调用的Block
 */
@property (nonatomic, copy)HENetTaskSuccessBlock successBlock;
/**
 *  请求失败调用Block
 */
@property (nonatomic, copy)HENetTaskFailedBlock failedBlock;
/**
 *  Http请求对应的path
 */
@property (nonatomic, strong) NSString *urlString;
/**
 *  唯一初始化方法
 *
 *  @param aPath http请求对应的path string
 *
 *  @return 创建的对象
 */
- (instancetype)initWithUrlString:(NSString *)aPath;
/**
 *  初始化方法，由完整的url string 创建
 *
 *  @param aUrl url
 *
 *  @return 创建对象
 */
- (instancetype)initWithTotalUrlString:(NSString *)aUrl;
/**
 *  发起Http请求
 *
 *  @param method HTTP请求方法
 */
- (void)runInMethod:(HEHttpMethod)method;


@end
