//
//  HelpDetailViewController.h
//  gjdrwy
//
//  Created by AllPepole on 15/12/11.
//  Copyright (c) 2015年 AllPepole. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderModel.h"

@interface HelpDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)OrderModel* model;

@end
