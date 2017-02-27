//
//  ConferenceEnrollTableViewCell.h
//  HealthEdu
//
//  Created by weixu on 2017/2/24.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceEnrollPersionObject.h"

@protocol ConferenceEnrollTableViewCellDelegate <NSObject>

- (void)onTextFieldText:(ConferenceEnrollPersionObject *)aObject;

@end

@interface ConferenceEnrollTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (nonatomic, weak) id<ConferenceEnrollTableViewCellDelegate>delegate;
- (void)showCellWithText:(ConferenceEnrollPersionObject *)aObject;
@end
