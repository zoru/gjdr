//
//  LoginViewController.h
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *UserFaceImageView;
@property (weak, nonatomic) IBOutlet UITextField *UserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *remenberBtn;
@property (weak, nonatomic) IBOutlet UIButton *AutoLoginBtn;

@property (assign, nonatomic) BOOL isLoginLaunch;
- (IBAction)remenberBtnAction:(UIButton *)sender;
- (IBAction)autoBtnAction:(UIButton *)sender;
- (IBAction)loginAction:(UIButton *)sender;

@end


static NSString* LoginSuccessNotifiction =  @"LoginSuccessNotifiction";