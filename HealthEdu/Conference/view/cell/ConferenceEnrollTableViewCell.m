//
//  ConferenceEnrollTableViewCell.m
//  HealthEdu
//
//  Created by weixu on 2017/2/24.
//  Copyright © 2017年 allWants. All rights reserved.
//

#import "ConferenceEnrollTableViewCell.h"

@interface ConferenceEnrollTableViewCell()
@property (nonatomic, strong) NSString *key;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) ConferenceEnrollPersionObject *persionObject;


@end

@implementation ConferenceEnrollTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)showCellWithText:(ConferenceEnrollPersionObject *)aObject {
    self.persionObject = aObject;
    self.tagLabel.text = aObject.tagString;
    self.desLabel.text = aObject.desString;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    self.persionObject.content = textField.text;
    if ([self.delegate respondsToSelector:@selector(onTextFieldText:)]) {
        [self.delegate onTextFieldText:_persionObject];
    }
    return YES;
}



@end
