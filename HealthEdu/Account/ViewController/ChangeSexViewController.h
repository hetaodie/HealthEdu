//
//  ChangeNameViewController.h
//  HealthEdu
//
//  Created by weixu on 16/11/30.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeNameViewControllerDelegate <NSObject>

- (void)onChangeSexWithNewName:(NSString *)aNewName;

@end

@interface ChangeSexViewController : UIViewController

@property (nonatomic,strong) NSString *sex;
@end
