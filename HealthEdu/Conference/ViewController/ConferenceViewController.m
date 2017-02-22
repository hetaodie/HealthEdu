//
//  ConferenceViewController.m
//  HealthEdu
//
//  Created by weixu on 2017/2/22.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "ConferenceViewController.h"
#import "ConferenceTableViewCell.h"

@interface ConferenceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (nonatomic, strong) NSMutableArray *contentArray;
@end

@implementation ConferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpContentTableView];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConferenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceTableViewCell" forIndexPath:indexPath];
    //[cell showCellWithObject:[self.contentArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSInteger section = indexPath.section;
//    NSInteger row = indexPath.row;
//    
//    NSArray *sections = [self.contentArray objectAtIndex:section];
//    AccountContentObject *object = [sections objectAtIndex:row];
//    
//    [self presentVCWithAction:object.pAction];
}


- (void)setUpContentTableView{
    UINib *nib = [UINib nibWithNibName:@"ConferenceTableViewCell" bundle:nil];
    [self.contentTableView registerNib:nib forCellReuseIdentifier:@"ConferenceTableViewCell"];
    
}

@end
