//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConferenceDetailObject.h"

@class SpeakerMessageItem;
@protocol ConferenceDetailSourceDelegate <NSObject>
- (void)onConferenceDetailSourceSuccess:(ConferenceDetailObject *)aObject;
- (void)onConferenceDetailSourceError;
@end

@interface ConferenceDetailSource : NSObject

@property (nonatomic, weak) id <ConferenceDetailSourceDelegate>delegate;

- (void)getCousultDetailWithId:(NSString *)aId;


@end
