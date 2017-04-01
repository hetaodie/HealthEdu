//
//  GetUserInfoSource.h
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@protocol GetUserInfoSourceDelegate <NSObject>

- (void)onGetuserInfoWithSussess:(UserInfo *)aUserInfo;
- (void)onGetuserInfoWithError;
@end

@interface GetUserInfoSource : NSObject
@property (nonatomic,weak) id<GetUserInfoSourceDelegate>delegate;
- (void)GetUserInfoWithuserName:(NSString *)userName;
@end
