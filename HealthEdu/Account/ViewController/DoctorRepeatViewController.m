//
//  DoctorRepeatViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "DoctorRepeatViewController.h"
#import "DoctorRequestTableViewCell.h"
#import "DocorRequestSource.h"
#import "UserInfoManager.h"

@interface DoctorRepeatViewController () <UITableViewDelegate,UITableViewDataSource,DocorRequestSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong)DocorRequestSource *source;
@end


@implementation DoctorRepeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentArray = [[NSMutableArray alloc] init];
    [self setUpTableView];
    
    self.source = [[DocorRequestSource alloc] init];
    self.source.delegate = self;
    [self.source getDoctorRequest:[[[UserInfoManager shareManager] getUserInfo] userName]];
}

- (void)onDoctorRequestSuess:(NSArray *)aArray {
    [self.contentArray setArray:aArray];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)setUpTableView{
    UINib *nib = [UINib nibWithNibName:@"DoctorRequestTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"DoctorRequestTableViewCell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 236;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
 
    DoctorRequestObject *object = [self.contentArray objectAtIndex:row];
    
    
    DoctorRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorRequestTableViewCell" forIndexPath:indexPath];
    
    [cell showCellWithObject:object];
    return cell;
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
