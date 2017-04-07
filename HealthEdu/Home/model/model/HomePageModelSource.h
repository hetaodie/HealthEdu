//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LectureHailObject.h"

@class SpeakerMessageItem;
@protocol HomePageModelSourceDelegate <NSObject>
- (void)onHomePageNewsSuccess:(NSArray *)aArray;
- (void)onHomePageNewsError;

- (void)onGetVideoContentSuccess:(LectureHailObject *)aObject;
- (void)onGetVideoContentError;


@end

@interface HomePageModelSource : NSObject

@property (nonatomic, weak) id <HomePageModelSourceDelegate>delegate;

- (void)getHomePageNews;

- (void)getVideoContent:(NSString *)aId;


@end
