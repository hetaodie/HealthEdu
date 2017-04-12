//
//  MessageTableViewCell.h
//  HealthEdu
//
//  Created by weixu on 2017/4/11.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageObject.h"

@protocol MessageTableViewCellDelegate <NSObject>

- (void)onMessageMore:(MessageObject *)aObject;

@end

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) id <MessageTableViewCellDelegate>delegate;


- (void)showCellWithData:(MessageObject *)aObject;
@end
