//
//  SettingViewController.m
//  HealthEdu
//
//  Created by weixu on 16/11/28.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "SettingViewController.h"
#import "CacheManager.h"
#import "UserInfoManager.h"

@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLabel;
@end

@implementation SettingViewController

#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    NSString *path = [self getVideoFilePath];
    
    double cacheSize = [CacheManager folderSizeAtPath:path];
    CGFloat cacheSizeM = cacheSize/(1024*1024);
    self.cacheSizeLabel.text = [NSString stringWithFormat:@"%.2fM",cacheSizeM];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}


#pragma mark -
#pragma mark IBActions
- (IBAction)clearCacheBtnPress:(id)sender {
    [CacheManager clearCache:[self getVideoFilePath]];
    self.cacheSizeLabel.text = @"0";
}

- (IBAction)tuichuBtnPress:(id)sender {
    [[UserInfoManager shareManager] unLoginSeccess];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (NSString *)getVideoFilePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"video"];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}



@end
