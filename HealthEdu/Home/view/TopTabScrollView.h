//
//  TopTabScrollView.h
//  HealthEdu
//
//  Created by NetEase on 16/10/26.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopTabScrollView;

@protocol TopTabScrollViewDelegate <NSObject>

//用来显示有多少个item
- (NSInteger)numberOfRowInTopTabScrollView:(TopTabScrollView *)tableView;

//用来返回tobTab的item
- (UIView *)topTabScrollView:(TopTabScrollView *)topTabScrollView cellForItemAtRow:(NSInteger)indexPath;

//- (CGSize )sizeOfCellFor
@end

@interface TopTabScrollView : UIScrollView <UICollectionViewDelegate>

@end
