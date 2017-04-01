//
//  ChangeUserInSource.h
//  HealthEdu
//
//  Created by weixu on 2017/4/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChangeUserInSourceDelegate <NSObject>

- (void)onChangeUserInfoSussess;

- (void)onChangeUserInfoError;

@end

@interface ChangeUserInSource : NSObject
@property (nonatomic, weak) id <ChangeUserInSourceDelegate> delegate;
- (void)changeUserInfoWithURl:(NSString *)aUrl;
@end
