//
//  HomeViewController.h
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//


#import "BaseViewController.h"
#import "PullTableView.h"


@interface HomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userFaceImageView;
@property (weak, nonatomic) IBOutlet UIButton *serchButon;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;          //姓名
@property (weak, nonatomic) IBOutlet UILabel *communityLbale;         //小区
@property (weak, nonatomic) IBOutlet UILabel *postLable;      //职位
@property (weak, nonatomic) IBOutlet PullTableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *allOrderButton;

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLeftConstraint;

@property (weak, nonatomic) IBOutlet UILabel *allCountLable;
@property (weak, nonatomic) IBOutlet UILabel *unProcessCountLbale;
@property (weak, nonatomic) IBOutlet UIButton *processTypeButton;


@end
