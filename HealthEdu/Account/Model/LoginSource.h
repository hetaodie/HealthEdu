//
//  LoginModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserInfo.h"

@class SpeakerMessageItem;
@protocol LoginSourceDelegate <NSObject>

- (void)onLoginSuccess:(UserInfo *)aUserInfo;

- (void)onLoginError;
@end

@interface LoginSource : NSObject

@property (nonatomic, weak) id <LoginSourceDelegate>delegate;

- (void)LoginWithName:(NSString *)aUsername andPWD:(NSString *)pwd;

@end
