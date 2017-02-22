//
//  BKDetailViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "BKDetailViewController.h"
#import "BaikeDetailSource.h"

@interface BKDetailViewController ()<BaikeDetailSourceDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (nonatomic, strong) BaikeDetailSource *detailSource;

@end

@implementation BKDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"疾病详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentWebView.layer.cornerRadius = 5.0f;
    
    self.detailSource = [[BaikeDetailSource alloc] init];
    self.detailSource.delegate = self;
    [self.detailSource getBaikeDetailWithId:self.id];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBaikeDetailSourceSuccess:(BaikeDetailObject *)aObject{
    self.titleLabel.text = aObject.title;
    [self.contentWebView loadHTMLString:aObject.contenttext baseURL:nil];
}

- (void)onBaikeDetailSourceError{

}
@end
