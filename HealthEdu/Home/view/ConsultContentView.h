//
//  ConsultContentView.h
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultContentObject.h"
@class ConsultContentView;

@protocol ConsultContentViewDelegate <NSObject>
@optional

- (void)contentViewWithScrollView:(UIScrollView *)scrollView didScrollToIndex:(NSInteger)aIndex;
- (void)contentViewWithscrollViewDidScroll:(UIScrollView *)scrollView;

- (void)contentOneContentCellWithSelect:(ConsultContentObject *)aObject withIndex:(NSInteger)aIndex;

@end

@interface ConsultContentView : UIView
@property (nonatomic, weak) id<ConsultContentViewDelegate>delegate;

- (void)showConsultContentViewWithData:(NSArray *)aArray;

- (void)selectContentWithIndex:(NSInteger)aIndex;
@end
