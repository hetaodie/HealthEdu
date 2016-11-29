//
//  PersonInfoTableViewCell.h
//  HealthEdu
//
//  Created by weixu on 16/11/28.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonInfoObject.h"

@interface PersonInfoTableViewCell : UITableViewCell

- (void)showCellWithData:(PersonInfoObject *)aObject;
@end
