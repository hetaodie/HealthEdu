//
//  UserInfoManager.m
//  HealthExpo
//
//  Created by hzzhanyawei on 16/6/24.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import "UserInfoManager.h"

@interface UserInfoManager ()
//@property (nonatomic, strong) UserCenterModelSource *modelSource;
@end

@implementation UserInfoManager

+ (instancetype)shareManager{
    static UserInfoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserInfoManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

//登陆成功存储用户信息。
- (void)LoginSeccessWith:(UserInfo *)aUserInfo{
     NSData *archivUserInfoCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:aUserInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:archivUserInfoCarPriceData forKey:@"userinfo"];
}

- (void)unLoginSeccess{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"userinfo"];
}

- (void)saveEditedUserInfo:(UserInfo *)info{
    NSData *archivUserInfoCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:info];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:archivUserInfoCarPriceData forKey:@"userinfo"];
}

/**
 *  获取userInfo
 *
 *  @return userInfo
 */
- (UserInfo *)getUserInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [defaults objectForKey:@"userinfo"];
    UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    return userInfo;
}

@end
