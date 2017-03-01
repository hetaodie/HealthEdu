//
//  ConsultationContentTableViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/25.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultationListObject.h"

@interface ConsultationContentTableViewCell : UITableViewCell

+(CGFloat)cellHeightWithData:(ConsultationListObject *)aObject;

- (void)showCellWithObject:(ConsultationListObject *)aObject;
@end
