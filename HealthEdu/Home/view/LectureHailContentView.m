//
//  LectureHailContentView.m
//  HealthEdu
//
//  Created by weixu on 16/11/16.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "LectureHailContentView.h"
#import "LectureHailContentCollectionViewCell.h"
#import "LectureHailContentObject.h"

@interface LectureHailContentView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) NSMutableArray *contentArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation LectureHailContentView


#pragma mark -
#pragma mark lifecycle

- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setUpCollectionView];
    self.contentArray = [[NSMutableArray alloc] init];
    [self addTestData];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSString *className = NSStringFromClass([self class]);
        self.contentView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (void)showViewWithArray:(NSArray *)aArray{
    [self.contentArray setArray:aArray];
    
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LectureHailContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LectureHailContentCollectionViewCell" forIndexPath:indexPath];
    
    LectureHailContentObject *object = [self.contentArray objectAtIndex:indexPath.row];
    [cell showCellWithData:object];
        
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onOneElementContentSelectWithData:withIndex:)]) {
        [self.delegate onOneElementContentSelectWithData:nil withIndex:indexPath.row];
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size =[LectureHailContentCollectionViewCell cellSizeWithData:nil];
    return size;
}



#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private
- (void)setUpCollectionView{
    UINib *nib = [UINib nibWithNibName:@"LectureHailContentCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"LectureHailContentCollectionViewCell"];
}

- (void)addTestData{
    for (int i =0; i<20; i++) {
        LectureHailContentObject *object = [[LectureHailContentObject alloc] init];
        object.videoUrl= @"http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA";
        object.title = @"台湾医疗美容市场流行用高压氧抗老用高压氧抗老用高压氧抗老";
        [self.contentArray addObject:object];
    }
    [self.collectionView reloadData];
}

@end
