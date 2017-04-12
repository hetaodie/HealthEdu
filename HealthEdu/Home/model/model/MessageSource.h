//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MessageSourceDelegate <NSObject>
- (void)onGetMessageSuccess:(NSArray *)aArray;
- (void)onGetMessageError;

@end

@interface MessageSource : NSObject

@property (nonatomic, weak) id <MessageSourceDelegate>delegate;

- (void)getMessage;
@end
