//
//  SearchViewController.h
//  gjdryz
//
//  Created by AllPepole on 15/12/10.
//
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController

@property (nonatomic,strong)NSMutableArray* OrderArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end
