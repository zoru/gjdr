//
//  UserCenterViewController.m
//  gjdryz
//
//  Created by AllPepole on 15/12/6.
//
//

#import "UserCenterViewController.h"
#import "AboutViewController.h"
#import "ModifyPwdViewController.h"
#import "AppDelegate.h"



@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户中心";
    [self setNavigationBack];
    [self initViews];
}

- (void)initViews
{
    self.communityLbale.text = [UserInfo localUserInfo].user_Community;
    self.nameLable.text = [UserInfo localUserInfo].user_Name;
    self.postLable.text  = [NSString stringWithFormat:@"职位:%@",[UserInfo localUserInfo].user_Post];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)aboutApp:(UIButton *)sender
{
    AboutViewController* aboutController = [[AboutViewController alloc] init];
    [self BasePushViewControler:aboutController];
}

- (IBAction)modifyPassword:(UIButton *)sender {
    
    ModifyPwdViewController* modifyController = [[ModifyPwdViewController alloc] init];
    [self BasePushViewControler:modifyController];
}
- (IBAction)logout:(UIButton *)sender {
    
    [UserInfo deleteUserInfo];
    [[AppDelegate shareAppDelegate] goLoginViewController];
}

@end
