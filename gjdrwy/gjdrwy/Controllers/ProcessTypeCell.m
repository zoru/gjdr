//
//  ProcessTypeCell.m
//  gjdrwy
//
//  Created by AllPepole on 15/12/13.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import "ProcessTypeCell.h"

@implementation ProcessTypeCell

- (void)awakeFromNib {
    
    _processLbale.text = @"";
    _processTypeImageView.image = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
