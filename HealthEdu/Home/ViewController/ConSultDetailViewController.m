//
//  ConsultDetailViewController.m
//  HealthEdu
//
//  Created by weixu on 16/11/14.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "ConsultDetailViewController.h"
#import "ConsultDetailSource.h"
#import "UIImageView+WebCache.h"


@interface ConsultDetailViewController () <ConsultDetailSourceDelegate>
@property (nonatomic, strong) ConsultDetailSource *detailSource;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *laiyuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation ConsultDetailViewController
#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.detailSource = [[ConsultDetailSource alloc] init];
    self.detailSource.delegate = self;
    [self.detailSource getCousultDetailWithId:self.id];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (void)onConsultDetailSourceSuccess:(ConsultDetailObject *)aObject{
    NSDate *date = [self getDateTimeFromMilliSeconds:aObject.createddate];
    NSString *strDate = [self dateToString:date];
    
    self.titleLabel.text = aObject.title;
    self.laiyuanLabel.text = aObject.content1;
    self.createDateLabel.text = strDate;
    
    [self.contentWebView loadHTMLString:aObject.contenttext baseURL:nil];

}

- (void)onConsultDetailSourceError{

}

#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private
-(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds
{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    NSLog(@"传入的时间戳=%f",seconds);
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

- (NSDate *)stringToDate:(NSString *)strdate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// NSString的时间格式
    NSDate *retdate = [dateFormatter dateFromString:strdate];
    return retdate;
}

- (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
@end
