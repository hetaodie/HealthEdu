//
//  ConferenceViewController.m
//  HealthEdu
//
//  Created by weixu on 2017/2/22.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "ConferenceViewController.h"
#import "ConferenceTableViewCell.h"
#import "ConferenceSource.h"
#import "ConferenceDetailViewController.h"

@interface ConferenceViewController ()<UITableViewDelegate,UITableViewDataSource,ConferenceSourceDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) ConferenceSource *source;
@end

@implementation ConferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpContentTableView];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentArray = [[NSMutableArray alloc] init];
    
    self.source = [[ConferenceSource alloc] init];
    self.source.delegate = self;
    [self.source getConference];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConferenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceTableViewCell" forIndexPath:indexPath];
    [cell showCellWithObject:[self.contentArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ConferenceDetailViewController *ndVC = [[ConferenceDetailViewController alloc] initWithNibName:@"ConferenceDetailViewController" bundle:nil];
    //ndVC.id = aObject.id;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
}

- (void)onConferenceSuccess:(NSArray *)aArray{
    [self.contentArray setArray:aArray];
    [self.contentTableView reloadData];
}

- (void)setUpContentTableView{
    UINib *nib = [UINib nibWithNibName:@"ConferenceTableViewCell" bundle:nil];
    [self.contentTableView registerNib:nib forCellReuseIdentifier:@"ConferenceTableViewCell"];
    
}

@end
