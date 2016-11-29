//
//  SettingViewController.m
//  HealthEdu
//
//  Created by weixu on 16/11/28.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "SettingViewController.h"
#import "CacheManager.h"

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
    
    CGFloat cacheSize = [CacheManager folderSizeAtPath:path];
    self.cacheSizeLabel.text = [NSString stringWithFormat:@"%.2fM",cacheSize];
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
}

- (IBAction)tuichuBtnPress:(id)sender {
    
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
