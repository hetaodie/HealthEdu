//
//  LectureHailContentView.h
//  HealthEdu
//
//  Created by weixu on 16/11/16.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LectureHailContentViewDelegate <NSObject>

- (void)onOneElementContentSelectWithData:(NSString *)aObject withIndex:(NSInteger)aIndex;

@end

@interface LectureHailContentView : UIView
@property (nonatomic, weak) id<LectureHailContentViewDelegate>delegate;

- (void)showViewWithArray:(NSArray *)aArray;
@end
