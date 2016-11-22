//
//  LectureHailContentCollectionViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/22.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "LectureHailContentCollectionViewCell.h"
#import "LectureHailContentElementCollectionViewCell.h"

@interface LectureHailContentCollectionViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end


@implementation LectureHailContentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentArray = [[NSMutableArray alloc] init];
    
    [self setUpCollectionView];
    [self addTestData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = [self.contentArray count];
    return count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LectureHailContentElementCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LectureHailContentElementCollectionViewCell" forIndexPath:indexPath];
    LectureHailContentObject *object = [self.contentArray objectAtIndex:indexPath.row];
    
    [cell showCellWithData:object];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    LectureHailContentObject *object = [self.contentArray objectAtIndex:row];
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickOneElementOfCellWithInfo:withIndex:)]){
        [self.delegate clickOneElementOfCellWithInfo:object withIndex:row];
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size =[LectureHailContentElementCollectionViewCell cellSizeWithData:nil];
    return size;
}

- (void)setUpCollectionView{
    UINib *nib = [UINib nibWithNibName:@"LectureHailContentElementCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"LectureHailContentElementCollectionViewCell"];
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
