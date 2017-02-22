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
@protocol ConferenceSourceDelegate <NSObject>
- (void)onConferenceSuccess:(NSArray *)aArray;
- (void)onConferenceError;
@end

@interface ConferenceSource : NSObject

@property (nonatomic, weak) id <ConferenceSourceDelegate>delegate;

- (void)getConference;


@end
