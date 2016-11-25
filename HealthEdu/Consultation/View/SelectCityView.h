//
//  SelectCityView.h
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectCityViewDelegate <NSObject>

- (void)onSelectCity:(BOOL)isUnfold;

@end

@interface SelectCityView : UIView
@property(nonatomic,weak) id<SelectCityViewDelegate>delegate;

- (void)setSelectCityName:(NSString *)aName;
- (void)setLocCityName:(NSString *)aName;
@end
