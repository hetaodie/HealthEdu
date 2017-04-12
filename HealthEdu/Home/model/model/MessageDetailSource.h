//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MessageDetailObject.h"

@protocol MessageDetailSourceDelegate <NSObject>
- (void)onMessageDetailSourceSuccess:(MessageDetailObject *)aObject;
- (void)onMessageDetailSourceError;
@end

@interface MessageDetailSource : NSObject

@property (nonatomic, weak) id <MessageDetailSourceDelegate>delegate;

- (void)getMessageDetailWithId:(NSString *)aId;


@end
