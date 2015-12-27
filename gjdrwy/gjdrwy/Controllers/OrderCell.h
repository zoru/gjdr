//
//  OrderCell.h
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "HomeViewController.h"

static NSString* const ordercell = @"OrderCell";

@interface OrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNubLable;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *processTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *processTitleLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrsint;

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;
@property (weak, nonatomic) IBOutlet UIImageView *processTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *processTypeLable;

@property (nonatomic, strong)HomeViewController* superController;

- (void)setValueWithModel:(OrderModel*)model;

@end
