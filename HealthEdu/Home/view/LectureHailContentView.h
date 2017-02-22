//
//  LectureHailContentView.h
//  HealthEdu
//
//  Created by weixu on 16/11/16.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LectureHailObject.h"

@protocol LectureHailContentViewDelegate <NSObject>

@optional

- (void)contentViewWithScrollView:(UIScrollView *)scrollView didScrollToIndex:(NSInteger)aIndex;
- (void)contentViewWithscrollViewDidScroll:(UIScrollView *)scrollView;

- (void)contentOneContentCellWithSelect:(LectureHailObject *)aObject withIndex:(NSInteger)aIndex;


@end

@interface LectureHailContentView : UIView
@property (nonatomic, weak) id<LectureHailContentViewDelegate>delegate;

- (void)showViewWithArray:(NSArray *)aArray;

- (void)selectContentWithIndex:(NSInteger)aIndex;
@end
