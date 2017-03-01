//
//  RegisterModelSource.h
//  HealthExpo
//
//  Created by zhanyawei on 16/7/5.
//  Copyright © 2016年 AllWantsLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SpeakerMessageItem;
@protocol RegisterSourceDelegate <NSObject>
- (void)onRegisterCodeSuccess;
- (void)onRegisterCodeError;

- (void)onRegisterSuccess:(NSString *)aUsername andPWD:(NSString *)pwd;

- (void)onRegisterError;
@end

@interface RegisterSource : NSObject

@property (nonatomic, weak) id <RegisterSourceDelegate>delegate;

- (void)getRegisterCode:(NSString *)aUsername;

- (void)registerWithName:(NSString *)aUsername andPWD:(NSString *)pwd andCode:(NSString *)aCode;

@end
