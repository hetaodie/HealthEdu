//
//  ConferenceDetailViewController.m
//  HealthEdu
//
//  Created by weixu on 2017/2/23.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "ConferenceDetailViewController.h"
#import "ConferenceDetailSource.h"
#import "ConferenceObject.h"
#import "UIImageView+WebCache.h"
#import "Comment.h"
#import "ConferenceEnrollViewController.h"

@interface ConferenceDetailViewController () <ConferenceDetailSourceDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coferenceImageView;
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *DayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (nonatomic, strong) ConferenceDetailObject *detailObject;

@property (strong, nonatomic) ConferenceDetailSource *conferenceSource;

@end

@implementation ConferenceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会议";
    
    self.conferenceSource = [[ConferenceDetailSource alloc] init];
    self.conferenceSource.delegate = self;
    [self.conferenceSource getCousultDetailWithId:self.id];
    
    self.button.clipsToBounds = YES;
    self.button.layer.cornerRadius = 15;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)onConferenceDetailSourceSuccess:(ConferenceDetailObject *)aObject{
    self.detailObject = aObject;
    
    self.titileLabel.text = aObject.title;
    [self.coferenceImageView sd_setImageWithURL:[NSURL URLWithString:aObject.picurl] placeholderImage:[UIImage imageNamed:@"conferenceDetailDefault"]];
    
    [self.contentWebView loadHTMLString:aObject.contenttext baseURL:nil];
    
    NSDictionary *dictionary = [Comment getUTCFormateDateWithBeginDate:aObject.content3 andNewDate:aObject.content4];
    self.DayLabel.text = [dictionary objectForKey:@"days"];
    self.hourLabel.text = [dictionary objectForKey:@"hours"];
    self.minuteLabel.text = [dictionary objectForKey:@"minute"];
    self.secondLabel.text = [dictionary objectForKey:@"second"];
    
    self.priceLabel.text = aObject.content2;
}

- (void)onConferenceDetailSourceError{

}

- (IBAction)buttnPress:(id)sender {
    ConferenceEnrollViewController *ndVC = [[ConferenceEnrollViewController alloc] initWithNibName:@"ConferenceEnrollViewController" bundle:nil];
    ndVC.detailObject = self.detailObject;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
    
}


@end
