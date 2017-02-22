//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LearnCommunitySourceDelegate <NSObject>
- (void)onLearnCommunityClassifySuccess:(NSArray *)aArray;
- (void)onLearnCommunityClassifyError;

- (void)onLearnCommunityDataSuccess:(NSArray *)aArray;
- (void)onLearnCommunityDataError;
@end

@interface LearnCommunitySource : NSObject

@property (nonatomic, weak) id <LearnCommunitySourceDelegate>delegate;

- (void)getLearnCommunityClassify;

- (void)getLearnCommunityData:(NSString *)aId;
@end
