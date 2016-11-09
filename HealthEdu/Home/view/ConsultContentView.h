//
//  ConsultContentView.h
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConsultContentView;

@protocol ConsultContentViewDelegate <NSObject>

- (void)contentViewWithScrollView:(UIScrollView *)scrollView didScrollToIndex:(NSInteger)aIndex;
- (void)contentViewWithscrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface ConsultContentView : UIView
@property (nonatomic, weak) id<ConsultContentViewDelegate>delegate;

- (void)showConsultContentViewWithData:(NSArray *)aArray;

- (void)selectContentWithIndex:(NSInteger)aIndex;
@end
