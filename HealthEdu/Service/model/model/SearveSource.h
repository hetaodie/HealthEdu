//
//  SearveSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ServerObject.h"
@class SpeakerMessageItem;
@protocol SearveSourceDelegate <NSObject>
- (void)onSearveSourceSuccess:(NSString *)content;
- (void)onSearveSourceError;
@end

@interface SearveSource : NSObject

@property (nonatomic, weak) id <SearveSourceDelegate>delegate;

- (void)sendSeaverData:(ServerObject *)aObject;


@end
