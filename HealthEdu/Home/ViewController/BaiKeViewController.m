//
//  BaiKeViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "BaiKeViewController.h"
#import "BaiKeSicknessFoldCategoryView.h"
#import "BaiKeSicknessUnfoldCategoryView.h"
#import "BaiKeSicknessContentView.h"
#import "NSMutableArray+HF.h"
#import "BKDetailViewController.h"

const float moveLeftConstraintDis = 30.0;

@interface BaiKeViewController () <BaiKeSicknessContentViewDelegate,BaiKeSicknessFoldCategoryViewDelegate,BaiKeSicknessUnfoldCategoryViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectPersonButton;
@property (weak, nonatomic) IBOutlet UIButton *sicknessButton;
@property (weak, nonatomic) IBOutlet UIView *moveView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutConstraint;
@property (weak, nonatomic) IBOutlet BaiKeSicknessFoldCategoryView *sicknessFoldCategoryView;
@property (weak, nonatomic) IBOutlet BaiKeSicknessContentView *sicknessContentView;

@property (weak, nonatomic) IBOutlet BaiKeSicknessUnfoldCategoryView *sicknessUnfoldCategoryView;
@property (strong, nonatomic) NSMutableArray *sicknessCategoryArray;
@property (strong, nonatomic) NSMutableArray *sicknessfoldCategoryArray;
@property (strong, nonatomic) NSMutableArray *sicknessContentArray;

@end

@implementation BaiKeViewController
#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"疾病查询";
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    [self setUpDataAndView];
    [self addtestData];
    
    self.sicknessFoldCategoryView.delegate = self;
    self.sicknessUnfoldCategoryView.delegate = self;
    self.sicknessContentView.delegate =self;
    
    [self setUpCategoryView];
    [self.sicknessContentView showViewWithArray:self.sicknessContentArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark IBActions

- (IBAction)selectPersonBtnPress:(id)sender {
    
    if (self.selectPersonButton.selected) {
        return;
    }
    
    self.leftLayoutConstraint.constant = moveLeftConstraintDis;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    self.selectPersonButton.selected = YES;
    self.sicknessButton.selected = NO;
    [self setUpCategoryView];
}

- (IBAction)sicknessBtnPress:(id)sender {
    
    if (self.sicknessButton.selected) {
        return;
    }
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat leftDis = screenWidth - moveLeftConstraintDis - self.moveView.frame.size.width;
    
    self.leftLayoutConstraint.constant = leftDis;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    self.selectPersonButton.selected = NO;
    self.sicknessButton.selected = YES;
    self.sicknessFoldCategoryView.hidden = NO;
    self.sicknessUnfoldCategoryView.hidden = YES;
    
    [self setUpCategoryView];

}

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate

- (void)onSelectUnfold{
    self.sicknessUnfoldCategoryView.hidden = NO;
    self.sicknessFoldCategoryView.hidden = YES;
    [self.sicknessUnfoldCategoryView showUnfoldCategoryViewWithArray:self.sicknessCategoryArray];
}

- (void)onSelectOneElementWithData:(NSString *)aString withIndex:(NSInteger)aIndex{
    [self.sicknessContentView showViewWithArray:self.sicknessContentArray];

}

- (void)onUnfoldCategoryOneElementSelectWithData:(NSString *)aData withIndex:(NSInteger)aIndex{
    
    [self.sicknessCategoryArray moveObjectFromIndex:aIndex toIndex:0];
    [self setUpCategoryView];
    
}

- (void)onSicknessContentOneElementSelectWithData:(NSString *)aData withIndex:(NSInteger)aIndex{
    BKDetailViewController *ndVC = [[BKDetailViewController alloc] initWithNibName:@"BKDetailViewController" bundle:nil];
    ndVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndVC animated:YES];
}


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private

- (void)setUpDataAndView{
    self.selectPersonButton.selected = YES;
    self.sicknessButton.selected = NO;
    
    self.sicknessContentArray = [[NSMutableArray alloc] init];
    self.sicknessCategoryArray = [[NSMutableArray alloc] init];
    self.sicknessfoldCategoryArray = [[NSMutableArray alloc] init];

    self.sicknessFoldCategoryView.hidden = NO;
    self.sicknessUnfoldCategoryView.hidden = YES;

}

- (void)setUpCategoryView{
    
    self.sicknessFoldCategoryView.hidden = NO;
    self.sicknessUnfoldCategoryView.hidden = YES;
    
    NSArray *array = [self.sicknessCategoryArray subarrayWithRange:NSMakeRange(0, 4)];
    [self.sicknessfoldCategoryArray setArray:array];
    [self.sicknessFoldCategoryView showFoldCategoryViewWithArray:self.sicknessfoldCategoryArray];

}

- (void)addtestData{
    NSArray *array = [NSArray arrayWithObjects:@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道",@"结核",@"艾滋",@"呼吸道",@"肠道", nil];
    [self.sicknessCategoryArray setArray:array];
    
    [self.sicknessContentArray setArray:array];
}

@end
