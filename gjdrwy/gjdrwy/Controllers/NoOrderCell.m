//
//  NoOrderCell.m
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import "NoOrderCell.h"

@implementation NoOrderCell

- (void)awakeFromNib {
    
    _titleLable.text= @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
