//
//  CacheViewController.m
//  HealthEdu
//
//  Created by NetEase on 16/10/24.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "CacheViewController.h"
#import "UIColor+HEX.h"
#import "LectureHailObject.h"
#import "VideoDownloaderManger.h"
#import "CacheCollectionViewCell.h"

@interface CacheViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CacheCollectionViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cachedButton;
@property (weak, nonatomic) IBOutlet UIButton *cachingButton;
@property (weak, nonatomic) IBOutlet UIView *zanTingBgView;
@property (weak, nonatomic) IBOutlet UIView *zanTingView;
@property (weak, nonatomic) IBOutlet UIImageView *zantingImageView;
@property (weak, nonatomic) IBOutlet UILabel *zantingLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *contentArray;
@property (strong, nonatomic) NSMutableArray *videoStatusArray;
@property (nonatomic, assign) NSInteger selectCacheTag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewTopLayout;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) NSMutableArray *selectVideoArray;
@property (weak, nonatomic) IBOutlet UIView *deleteView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleteViewBottomLayout;


@end

@implementation CacheViewController

#pragma mark -
#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCollectionView];
    [self setUpRightItem];
    
    self.contentArray = [[NSMutableArray alloc] init];
    self.videoStatusArray = [[NSMutableArray alloc] init];
    self.selectVideoArray = [[NSMutableArray alloc] init];
    
    self.cachedButton.selected = YES;
    self.cachingButton.selected = NO;
    self.deleteViewBottomLayout.constant = -60;

    self.selectCacheTag = 0;
    [self getCachedData];
    [self.collectionView reloadData];

    self.cachingButton.backgroundColor = [UIColor colorWithHexString:@"ededed" alpha:1.0];
    self.cachedButton.backgroundColor = [UIColor whiteColor];
    
    self.zanTingView.clipsToBounds = YES;
    self.zanTingView.layer.cornerRadius = 15;
    self.zanTingView.layer.borderWidth = 1;
    self.zanTingView.layer.borderColor = [UIColor colorWithHexString:@"0099e6" alpha:1.0].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oneVideoCompleted:) name:VideoDownloaderDownloadingCompleted object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark -
#pragma mark IBActions

- (IBAction)zanTingBtnPress:(UIButton *)sender {
    if (sender.selected) {
        self.zantingLabel.text = @"暂停下载";
        [[VideoDownloaderManger sharedInstance] startAllDownLoad];
    }
    else{
        self.zantingLabel.text = @"开始下载";
        [[VideoDownloaderManger sharedInstance] stopAllDownLoad];
    }
    sender.selected = !sender.selected;
}

- (IBAction)deleteBtnPress:(id)sender {
    [self.selectVideoArray enumerateObjectsUsingBlock:^(LectureHailObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *strUrl = [obj.exturl length]>0 ? obj.exturl : obj.content1;
        if (self.selectCacheTag == 0) {
            [[VideoDownloaderManger sharedInstance] removeCompletedVideoWithString:strUrl];
        }
        else{
            [[VideoDownloaderManger sharedInstance] removeDownLoadingVideoWithString:strUrl];
        }
        
    }];

   
    if (self.selectCacheTag == 0) {
        [self getCachedData];
    }
    else{
        [self getCachingData];
    }
    [self.collectionView reloadData];
}


- (IBAction)cachedBtnPress:(id)sender {
    if (self.cachedButton.selected) {
        return;
    }
    
    self.collectionViewTopLayout.constant = 0.f;

    
    self.zanTingBgView.hidden = YES;

    self.cachedButton.selected = YES;
    self.cachingButton.selected = NO;
    
    self.cachingButton.backgroundColor = [UIColor colorWithHexString:@"ededed" alpha:1.0];
    self.cachedButton.backgroundColor = [UIColor whiteColor];
    self.selectCacheTag = 0;
    [self getCachedData];
    [self.collectionView reloadData];

}

- (IBAction)cachingBtnPress:(id)sender {
    if (self.cachingButton.selected) {
        return;
    }

    self.collectionViewTopLayout.constant = 49.f;
    
    self.zanTingBgView.hidden = NO;
    self.cachingButton.selected = YES;
    self.cachedButton.selected = NO;
    
    self.cachedButton.backgroundColor = [UIColor colorWithHexString:@"ededed" alpha:1.0];
    self.cachingButton.backgroundColor = [UIColor whiteColor];
    self.selectCacheTag = 1;
    
    [self getCachingData];
    [self.collectionView reloadData];

}

#pragma mark -
#pragma mark public

#pragma mark -
#pragma mark delegate

- (void)onSelectVideoWithData:(LectureHailObject *)aObject andIsSelected:(BOOL)isSelected{
    if (isSelected) {
        [self.selectVideoArray addObject:aObject];
    }
    else{
        [self.selectVideoArray removeObject:aObject];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger status = [[self.videoStatusArray objectAtIndex:indexPath.row] integerValue];
    
    CacheCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CacheCollectionViewCell" forIndexPath:indexPath];
    LectureHailObject *object = [self.contentArray objectAtIndex:indexPath.row];
    cell.delegate = self;
    
    [cell showCellWithData:object];
    

    [cell setCellEditStatus:status];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    LectureHailObject *object = [self.contentArray objectAtIndex:row];
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size =[CacheCollectionViewCell cellSizeWithData:nil];
    return size;
}



#pragma mark -
#pragma mark NSNotification

- (void)oneVideoCompleted:(NSNotification *)notification{
    if (self.selectCacheTag == 1) {
        [self getCachingData];
    }
    else if (self.selectCacheTag == 0){
        [self getCachedData];
    }
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark private

- (void)setUpRightItem{
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame =CGRectMake(0, 0, 70, 44);
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"取消" forState:UIControlStateSelected];
    [self.rightButton addTarget:self action:@selector(editCacheVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
}

- (void)editCacheVideo:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        for (int i =0; i<[self.videoStatusArray count]; i++) {
            [self.videoStatusArray replaceObjectAtIndex:i withObject:@(0)];
        }
        
        self.deleteViewBottomLayout.constant = -60;
    }
    else{
        
        btn.selected = YES;
        for (int i =0; i<[self.videoStatusArray count]; i++) {
            [self.videoStatusArray replaceObjectAtIndex:i withObject:@(1)];
        }
    }

    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^( CacheCollectionViewCell* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setCellEditStatus:[[self.videoStatusArray objectAtIndex:idx] integerValue]];
    }];
    self.deleteViewBottomLayout.constant = 0;

}

- (void)setUpCollectionView{
    UINib *nib = [UINib nibWithNibName:@"CacheCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"CacheCollectionViewCell"];
}

- (void)getCachedData{
    [self.videoStatusArray removeAllObjects];
    [self.selectVideoArray removeAllObjects];
    
    self.rightButton.selected = NO;
    self.deleteViewBottomLayout.constant = -60;
    
    NSDictionary *cachedDic = [[VideoDownloaderManger sharedInstance] getCompletedVideo];
    
    NSArray *cachedArray = [cachedDic allValues];
    [self.contentArray setArray:cachedArray];
    
    for (int i=0; i<[self.contentArray count]; i++) {
        [self.videoStatusArray addObject:@(0)];
    }
}

- (void)getCachingData{
    [self.videoStatusArray removeAllObjects];
    [self.selectVideoArray removeAllObjects];

    self.rightButton.selected = NO;
    self.deleteViewBottomLayout.constant = -60;


    NSDictionary *cachingDic = [[VideoDownloaderManger sharedInstance] getDownloadingVideo];
    
    NSArray *cachingArray = [cachingDic allValues];
    [self.contentArray setArray:cachingArray];
    
    for (int i=0; i<[self.contentArray count]; i++) {
        [self.videoStatusArray addObject:@(0)];
    }
}

@end
