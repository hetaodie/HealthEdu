//
//  LoginManager.h
//  HealthExpo
//
//  Created by hzzhanyawei on 16/6/24.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface UserInfoManager : NSObject
@property (nonatomic, strong) UserInfo *userInfo;


+ (instancetype)shareManager;
//登陆成功存储用户信息。
- (void)LoginSeccessWith:(UserInfo *)aUserInfo;
- (void)unLoginSeccess;;


- (void)saveEditedUserInfo:(UserInfo *)info;
/**
 *  获取userInfo
 *
 *  @return userInfo
 */
- (UserInfo *)getUserInfo;

@end
