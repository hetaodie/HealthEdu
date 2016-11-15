//
//  ConsultContentTableViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/8.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultContentObject.h"

@interface ConsultContentTableViewCell : UITableViewCell

- (void)showCellWithData:(ConsultContentObject *)aObject;

+ (CGFloat) cellHeightWithData:(ConsultContentObject *)aObject;
@end
