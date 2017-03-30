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

#pragma mark -
#pragma mark lifecycle


- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentArray = [[NSMutableArray alloc] init];
    
    [self setUpCollectionView];
   // [self addTestData];
}

#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

- (void)showCellWithArray:(NSArray *)aArray{
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
    LectureHailContentElementCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LectureHailContentElementCollectionViewCell" forIndexPath:indexPath];
    LectureHailObject *object = [self.contentArray objectAtIndex:indexPath.row];
    
    [cell showCellWithData:object];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    LectureHailObject *object = [self.contentArray objectAtIndex:row];
    
    NSString *strUrl = [object.exturl length]>0 ? object.exturl : object.content1;
    
    if ([strUrl length] == 0) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"视频连接为空！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alertview show];
        return;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickOneElementOfCellWithInfo:withIndex:)]){
        [self.delegate clickOneElementOfCellWithInfo:object withIndex:row];
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size =[LectureHailContentElementCollectionViewCell cellSizeWithData:nil];
    return size;
}


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private


- (void)setUpCollectionView{
    UINib *nib = [UINib nibWithNibName:@"LectureHailContentElementCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"LectureHailContentElementCollectionViewCell"];
}

//- (void)addTestData{
//    for (int i =1; i<16; i++) {
//        LectureHailObject *object = [[LectureHailObject alloc] init];
//        NSString *strUrl = [NSString stringWithFormat:@"http://120.25.226.186:32812/resources/videos/minion_0%d.mp4",i];
//        object.exturl= strUrl;
//        object.title = @"台湾医疗美容市场流行用高压氧抗老用高压氧抗老用高压氧抗老";
//        [self.contentArray addObject:object];
//    }
//    [self.collectionView reloadData];
//}

- (void)dealloc
{
    
}

@end
