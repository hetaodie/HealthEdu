//
//  ConferenceEnrollViewController.m
//  HealthEdu
//
//  Created by weixu on 2017/2/24.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "ConferenceEnrollViewController.h"
#import "ConferenceEnrollTableViewCell.h"
#import "ConferenceEnrollObject.h"
#import "ConferenceEnrollPersionObject.h"
#import "PayViewController.h"

@interface ConferenceEnrollViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *firstbgView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ConferenceEnrollObject *enrollObject;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *conferenceTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *conferenceLocLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *numPriceLabel;

@end

@implementation ConferenceEnrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstbgView.clipsToBounds = YES;
    self.firstbgView.layer.cornerRadius = 5;
    
    self.thirdView.clipsToBounds = YES;
    self.thirdView.layer.cornerRadius = 5;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setUpContentTableView];
    
    self.titleLabel.text = self.detailObject.title;
    self.priceLabel.text = self.detailObject.content2;
    self.numLabel.text = @"1";
    
    NSInteger price = 1 * [self.priceLabel.text integerValue];
    self.numPriceLabel.text = [NSString stringWithFormat:@"%ld",(long)price];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    self.enrollObject = [[ConferenceEnrollObject alloc] init];
    self.enrollObject.title = self.detailObject.title;
    self.enrollObject.price = [self.detailObject.content2 integerValue];
    self.enrollObject.num = 1;
    
    [self setUpPersionInfo];
    [self.tableView reloadData];
    
    
}


- (void)keyboardWillShow:(NSNotification *)notification{
    CGRect rect=CGRectMake(0.0f,-184,self.view.frame.size.width,self.view.frame.size.height);
    self.view.frame=rect;
}

- (void)keyboardDidHide:(NSNotification *)nofication{
    CGRect rect=CGRectMake(0.0f,0,self.view.frame.size.width,self.view.frame.size.height);
    self.view.frame=rect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.enrollObject.persionInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConferenceEnrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceEnrollTableViewCell" forIndexPath:indexPath];

    [cell showCellWithText:[self.enrollObject.persionInfoArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)setUpContentTableView{
    UINib *nib = [UINib nibWithNibName:@"ConferenceEnrollTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ConferenceEnrollTableViewCell"];
    
}

- (void)setUpPersionInfo{
    ConferenceEnrollPersionObject *object1 = [[ConferenceEnrollPersionObject alloc] init];
    object1.tagString = @"姓名";
    object1.desString = @"姓名长度在2~50位以内";
    object1.content = @"";
    [self.enrollObject.persionInfoArray addObject:object1];
    ConferenceEnrollPersionObject *object2 = [[ConferenceEnrollPersionObject alloc] init];
    object2.tagString = @"手机";
    object2.desString = @"手机号码为11位";
    object2.content = @"";
    [self.enrollObject.persionInfoArray addObject:object2];
    ConferenceEnrollPersionObject *object3 = [[ConferenceEnrollPersionObject alloc] init];
    object3.tagString = @"单位";
    object3.desString = @"单位长度在2~50位以内";
    object3.content = @"";
    [self.enrollObject.persionInfoArray addObject:object3];
    ConferenceEnrollPersionObject *object4 = [[ConferenceEnrollPersionObject alloc] init];
    object4.tagString = @"职位";
    object4.desString = @"职位长度在2~50位以内";
    object4.content = @"";
    [self.enrollObject.persionInfoArray addObject:object4];
    
    ConferenceEnrollPersionObject *object5 = [[ConferenceEnrollPersionObject alloc] init];
    object5.tagString = @"邮箱";
    object5.desString = @"设置正确的邮箱格式";
    object5.content = @"";
    [self.enrollObject.persionInfoArray addObject:object5];
    
}

- (IBAction)jianBtnPress:(id)sender {
    NSInteger num = [self.numLabel.text integerValue];
    if (num > 0) {
        num --;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    
    NSInteger price = num * [self.priceLabel.text integerValue];
    self.numPriceLabel.text = [NSString stringWithFormat:@"%ld",(long)price];
    self.enrollObject.num = num;
}

- (IBAction)jiaBtnPress:(id)sender {
    NSInteger num = [self.numLabel.text integerValue];
    num++;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)num];
    self.enrollObject.num = num;
    
    NSInteger price = num * [self.priceLabel.text integerValue];
    self.numPriceLabel.text = [NSString stringWithFormat:@"%ld",(long)price];

}

- (IBAction)PayBtnPress:(id)sender {
    PayViewController *ndVC = [[PayViewController alloc] initWithNibName:@"PayViewController" bundle:nil];
    ndVC.enrollObject = self.enrollObject;
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
}

@end
