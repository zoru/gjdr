//
//  HelpDetailCompleteCell.h
//  gjdryz
//
//  Created by AllPepole on 15/12/8.
//
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "showImageDelegate.h"
#import "HelpDetailViewController.h"
#import "CWStarRateView.h"

static NSString* const heldetailcell = @"HelpDetailCompleteCell";

@interface HelpDetailCompleteCell : UITableViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *orderNubLable;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *processTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *processInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *remarkLab;
@property (weak, nonatomic) IBOutlet UILabel *orderContentLable;

@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (retain, nonatomic) IBOutlet CWStarRateView *percentView;

@property (weak, nonatomic) IBOutlet UILabel *evaluatDateLable;
@property (weak, nonatomic) IBOutlet UILabel *evaluatTextLable;

@property (nonatomic,strong)HelpDetailViewController* superControler;
@property (assign,nonatomic)id<showImageDelegate> delegate;

- (void)setOrderInfo:(OrderModel*)model;

@end
