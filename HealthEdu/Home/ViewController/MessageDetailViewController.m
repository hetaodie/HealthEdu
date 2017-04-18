//
//  MessageDetailViewController.m
//  HealthEdu
//
//  Created by weixu on 2017/4/12.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetailSource.h"
#import "MessageDetailObject.h"
#import "UIImageView+WebCache.h"
#import "Comment.h"

@interface MessageDetailViewController () <MessageDetailSourceDelegate>
@property (nonatomic,strong) MessageDetailSource *source;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (weak, nonatomic) IBOutlet UILabel *readNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanLabel;
@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.source = [[MessageDetailSource alloc] init];
    self.source.delegate = self;
    [self.source getMessageDetailWithId:self.id];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)onMessageDetailSourceError {

}

- (void)onMessageDetailSourceSuccess:(MessageDetailObject *)aObject {
    self.titleLabel.text = aObject.title;
    NSDate *date = [Comment getDateTimeFromMilliSeconds:[aObject.createdate longLongValue]];
    NSString *strDate = [Comment dateToString:date];
    self.timeLabel.text = [NSString stringWithFormat:@"时间：%@",strDate];
  
    [self.contentWebView loadHTMLString:aObject.contenttext baseURL:nil];
    self.readNumLabel.text = [NSString stringWithFormat:@"阅读%@",aObject.viewnum];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
