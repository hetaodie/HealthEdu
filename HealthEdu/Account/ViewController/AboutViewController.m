//
//  AboutViewController.m
//  HealthEdu
//
//  Created by weixu on 2017/3/1.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutSource.h"
#import "AboutObject.h"

@interface AboutViewController () <AboutSourceDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) AboutSource *aboutSource;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *readLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aboutSource = [[AboutSource alloc] init];
    self.aboutSource.delegate = self;
    [self.aboutSource getAboutWithName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)onAboutError{

}

- (void)onAboutSuccess:(AboutObject *)aUserInfo{
    self.titleLabel.text = aUserInfo.title;
    self.timeLabel.text = [NSString stringWithFormat:@"时间：%@",aUserInfo.createdate];
    [self.contentWebView loadHTMLString:aUserInfo.contenttext baseURL:nil];
    self.readLabel.text = [NSString stringWithFormat:@"阅读：%@",aUserInfo.viewnum];
}

@end
