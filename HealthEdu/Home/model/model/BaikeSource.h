//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BaikeSourceDelegate <NSObject>
- (void)onBaikeClassifySuccess:(NSArray *)aArray;
- (void)onBaikeClassifyError;

- (void)onBaikeDataSuccess:(NSArray *)aArray;
- (void)onBaikeDataError;
@end

@interface BaikeSource : NSObject

@property (nonatomic, weak) id <BaikeSourceDelegate>delegate;

- (void)getBaikeClassify:(int)type;

- (void)getBaikeData:(NSString *)aId;
@end
