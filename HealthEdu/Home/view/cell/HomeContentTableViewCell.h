//
//  HomeContentTableViewCell.h
//  HealthEdu
//
//  Created by xu.wei on 16/10/17.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopularRecommendObject.h"

@interface HomeContentTableViewCell : UITableViewCell
- (void)showCellWithObject:(PopularRecommendObject *)aObject;
@end
