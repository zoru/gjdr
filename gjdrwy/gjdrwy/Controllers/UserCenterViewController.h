//
//  UserCenterViewController.h
//  gjdryz
//
//  Created by AllPepole on 15/12/6.
//
//

#import "BaseViewController.h"
#import "OrderModel.h"

static NSString* const logoutNotifction = @"logoutNotifction";

@interface UserCenterViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;    //头像
@property (weak, nonatomic) IBOutlet UILabel *nameLable;          //姓名
@property (weak, nonatomic) IBOutlet UILabel *communityLbale;         //小区
@property (weak, nonatomic) IBOutlet UILabel *postLable;      //职位

- (IBAction)modifyPassword:(UIButton *)sender;

- (IBAction)aboutApp:(UIButton *)sender;

@end
