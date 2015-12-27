//
//  HelpDetailUnProcessCell.h
//  gjdrwy
//
//  Created by AllPepole on 15/12/10.
//  Copyright (c) 2015年 AllPepole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpDetailViewController.h"
#import "showImageDelegate.h"

static NSString* const helpdetailunprocessCell = @"HelpDetailUnProcessCell";

@interface HelpDetailUnProcessCell : UITableViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *orderNubLable;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *helpContentLable;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollerView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic,strong)HelpDetailViewController* surperController;

@property (assign,nonatomic)id<showImageDelegate> delegate;

- (void)setdataWithModel:(OrderModel*)modle;

@end
