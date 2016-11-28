//
//  LoginViewController.h
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewControllerDelegate <NSObject>

- (void)onClictToLoginViewController:(UIViewController *)aVC;

@end

@interface RegisterViewController : UIViewController
@property (nonatomic, weak) id <RegisterViewControllerDelegate>delegate;
@end
