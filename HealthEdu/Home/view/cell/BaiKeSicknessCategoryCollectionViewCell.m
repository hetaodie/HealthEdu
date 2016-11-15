//
//  BaiKeSicknessCategoryCollectionViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/15.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "BaiKeSicknessCategoryCollectionViewCell.h"
#import "UIColor+HEX.h"

const CGFloat BaiKeSicknessCategoryCollectionViewCellheight = 33;

@interface BaiKeSicknessCategoryCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BaiKeSicknessCategoryCollectionViewCell


#pragma mark -
#pragma mark lifecycle


- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHexString:@"ffffff" alpha:1.0];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"777777" alpha:1.0];
    self.layer.cornerRadius = 5.0f;
    self.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = [UIColor colorWithHexString:@"0066e6" alpha:1.0];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff" alpha:1.0];
    }
    else{
        self.backgroundColor = [UIColor colorWithHexString:@"ffffff" alpha:1.0];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"777777" alpha:1.0];
    }
}


#pragma mark -
#pragma mark IBActions

#pragma mark -
#pragma mark public

+ (CGSize)cellSizeForString:(NSString *)aString{
    UIFont *font = [UIFont systemFontOfSize:17.0];
    NSDictionary *dict = @{NSFontAttributeName:font};

    CGRect rect = [aString boundingRectWithSize:CGSizeMake(MAXFLOAT, BaiKeSicknessCategoryCollectionViewCellheight) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    CGFloat width = rect.size.width + 40;
    CGSize size = CGSizeMake(width, BaiKeSicknessCategoryCollectionViewCellheight);
    return size;
}

- (void)showCellWithTitle:(NSString *)aTitle{
    self.titleLabel.text = aTitle;
}



#pragma mark -
#pragma mark delegate


#pragma mark -
#pragma mark NSNotification

#pragma mark -
#pragma mark private
@end
