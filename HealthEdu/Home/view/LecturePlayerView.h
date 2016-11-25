//
//  LecturePlayerView.h
//  HealthEdu
//
//  Created by weixu on 16/11/22.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LecturePlayerViewDelegate <NSObject>

- (void)onChangeDeviceOrientation:(BOOL)isFull;

@end

@interface LecturePlayerView : UIView
@property (nonatomic,weak) id<LecturePlayerViewDelegate>delegate;
- (void)setNewUrl:(NSURL *)aNewUrl isCircle:(BOOL)isCircle;
@end
