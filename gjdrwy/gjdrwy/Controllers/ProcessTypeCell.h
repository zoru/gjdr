//
//  ProcessTypeCell.h
//  gjdrwy
//
//  Created by AllPepole on 15/12/13.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* const processtypecell = @"ProcessTypeCell";

@interface ProcessTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *processTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *processLbale;


@end
