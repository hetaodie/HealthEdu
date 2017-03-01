//
//  AboutModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AboutObject.h"

@class SpeakerMessageItem;
@protocol AboutSourceDelegate <NSObject>

- (void)onAboutSuccess:(AboutObject *)aUserInfo;

- (void)onAboutError;
@end

@interface AboutSource : NSObject

@property (nonatomic, weak) id <AboutSourceDelegate>delegate;

- (void)getAboutWithName;

@end
