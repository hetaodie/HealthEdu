//
//  CitysView.h
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitysViewDelegate <NSObject>

- (void)onSelectOneElementWithData:(NSString *)aString withIndex:(NSInteger)aIndex;

@end

@interface CitysView : UIView
@property (nonatomic, weak) id<CitysViewDelegate>delegate;

- (void)showViewWithArray:(NSArray *)aArray;
@end
