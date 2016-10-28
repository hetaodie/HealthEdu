//
//  TopTabScrollViewCell.h
//  HealthEdu
//
//  Created by NetEase on 16/10/26.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TopTabScrollViewCellSelect @"TopTabScrollViewCellSelect"


@interface TopTabScrollViewCell : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (TopTabScrollViewCell *)viewFromXib;
+ (CGFloat)cellWidthWithString:(NSString *)aString;
@end
