//
//  LoginViewController.h
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>

- (void)onClictToRegiterViewController:(UIViewController *)aVC;

@end

@interface LoginViewController : UIViewController
@property (nonatomic,weak) id<LoginViewControllerDelegate> delegate;

@end
