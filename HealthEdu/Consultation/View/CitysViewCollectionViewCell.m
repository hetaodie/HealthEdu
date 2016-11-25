//
//  BaiKeSicknessCategoryCollectionViewCell.m
//  HealthEdu
//
//  Created by weixu on 16/11/15.
//  Copyright © 2016年 allWants. All rights reserved.
//

#import "CitysViewCollectionViewCell.h"
#import "UIColor+HEX.h"

const CGFloat CitysViewCollectionViewCellheight = 33;

@interface CitysViewCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CitysViewCollectionViewCell


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

    CGRect rect = [aString boundingRectWithSize:CGSizeMake(MAXFLOAT, CitysViewCollectionViewCellheight) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    CGFloat width = rect.size.width + 20;
    CGSize size = CGSizeMake(width, CitysViewCollectionViewCellheight);
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
