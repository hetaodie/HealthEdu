//
//  TopTabScrollView.h
//  HealthEdu
//
//  Created by NetEase on 16/10/26.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopTabScrollViewCell.h"

typedef NS_ENUM(NSInteger, TopTabScrollViewScrollPosition) {
    TopTabScrollViewScrollPositionNone,
    TopTabScrollViewScrollPositionTop,
    TopTabScrollViewScrollPositionMiddle,
    TopTabScrollViewScrollPositionBottom
};

@class TopTabScrollView;

@protocol TopTabScrollViewDelegate <UIScrollViewDelegate>

//用来显示有多少个item
- (NSInteger)numberOfRowInTopTabScrollView:(TopTabScrollView *)topTabScrollView;

//用来返回tobTab的item
- (TopTabScrollViewCell *)topTabScrollView:(TopTabScrollView *)topTabScrollView cellForItemAtRow:(NSInteger)row;

//用来返回每一个cell的大小
- (CGFloat)topTabScrollView:(TopTabScrollView *)topTabScrollView widthForItemAtRow:(NSInteger)row;

@optional

- (void)topTabScrollView:(TopTabScrollView *)topTabScrollView didSelectRow:(NSInteger )row;
@end

@interface TopTabScrollView : UIScrollView
@property (nonatomic, assign) id<TopTabScrollViewDelegate>delegate;
@property (nonatomic, assign) CGFloat cellSpacing;


//全部刷新整个控件
- (void)reloadData;

// 指定选择哪个row
- (void)selectRow:(NSInteger)row animated:(BOOL)animated scrollPosition:(TopTabScrollViewScrollPosition)topTabScrollViewScrollPosition;


@end
