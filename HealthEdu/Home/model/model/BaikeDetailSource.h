//
//  HomePageModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaikeDetailObject.h"

@protocol BaikeDetailSourceDelegate <NSObject>
- (void)onBaikeDetailSourceSuccess:(BaikeDetailObject *)aObject;
- (void)onBaikeDetailSourceError;
@end

@interface BaikeDetailSource : NSObject

@property (nonatomic, weak) id <BaikeDetailSourceDelegate>delegate;

- (void)getBaikeDetailWithId:(NSString *)aId;


@end
