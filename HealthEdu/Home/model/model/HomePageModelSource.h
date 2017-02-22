//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SpeakerMessageItem;
@protocol HomePageModelSourceDelegate <NSObject>
- (void)onHomePageNewsSuccess:(NSArray *)aArray;
- (void)onHomePageNewsError;
@end

@interface HomePageModelSource : NSObject

@property (nonatomic, weak) id <HomePageModelSourceDelegate>delegate;

- (void)getHomePageNews;


@end
