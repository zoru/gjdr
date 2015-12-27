//
//  LoginViewController.m
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import "LoginViewController.h"
#import "UIColor+hexcolor.h"
#import "AppDelegate.h"

#define ISREMENBER_PWD @"isRemenberPwd"
#define ISAUTO_LOGIN   @"isAutoLogin"
#define USERNAME @"LogiName"
#define PASSWORD @"LoginPwd"

@interface LoginViewController ()
{
    BOOL isAutoLogin;
    BOOL isRemenberPwd;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([self CheckRemenberPwd])
    {
        NSString* userName = [[NSUserDefaults standardUserDefaults] objectForKey:USERNAME];
        if (![NSString isNullOrEmpty:userName]) {
            self.UserNameTextField.text = userName;
        }
        NSString* password = [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORD];
        if (![NSString isNullOrEmpty:password]) {
            self.PwdTextField.text = password;
        }
    }
    if (self.isLoginLaunch) {
        
        if ([self CheckIsAutoLogin]) {
            [self loginAction:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)remenberBtnAction:(UIButton *)sender {
    
    BOOL autoLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:ISAUTO_LOGIN] boolValue];
    if (autoLogin) {
        return;
    }
    BOOL remenber = [[[NSUserDefaults standardUserDefaults] objectForKey:ISREMENBER_PWD] boolValue];
    [[NSUserDefaults standardUserDefaults] setObject:@(!remenber) forKey:ISREMENBER_PWD];
    [self CheckRemenberPwd];
}

- (IBAction)autoBtnAction:(UIButton *)sender {
    
    BOOL autoLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:ISAUTO_LOGIN] boolValue];
    [[NSUserDefaults standardUserDefaults] setObject:@(!autoLogin) forKey:ISAUTO_LOGIN];
    [self CheckIsAutoLogin];
    if (!autoLogin) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:ISREMENBER_PWD];
        [self CheckRemenberPwd];
    }
}


- (IBAction)loginAction:(UIButton *)sender {

    
    NSString* userName = self.UserNameTextField.text;
    NSString* pwd = self.PwdTextField.text;
    
    if ([NSString isNullOrEmpty:userName]) {
        [Helper showHudWithDuration:@"用户名不能为空"];
        return;
    }
    if ([NSString isNullOrEmpty:pwd]) {
        [Helper showHudWithDuration:@"密码不能为空"];
        return;
    }

    
    NSMutableDictionary* parameter = [[NSMutableDictionary alloc] initWithCapacity:2];
    [parameter setObject:userName forKey:@"username"];
    [parameter setObject:pwd forKey:@"password"];
    [parameter setObject:WY_LOGIN_METHOD forKey:@"method"];
    
    [Helper showHud:@"" inView:self.view];
    [RequestData netRequestPOSTWithRequestURL:REQUEST_BASE_URL withParameter:parameter withReturnValeuBlock:^(id returnValue) {
        if (returnValue && [returnValue isKindOfClass:[NSDictionary class]]) {
            UserInfo* user = [UserInfo UserInfoWithJson:returnValue];
            user.passWord = pwd;
            [user SavaUserInfo];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotifiction object:nil];
            
            if (isRemenberPwd) {
                [[NSUserDefaults standardUserDefaults] setObject:userName forKey:USERNAME];
                [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:PASSWORD];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERNAME];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:PASSWORD];
            }
            [Helper hideHudFromView:self.view];
            
            [[AppDelegate shareAppDelegate] goHomeViewController];
        }
    } withErrorCodeBlock:^(NSString *errorMsg) {
        [Helper hideHudFromView:self.view];
        [Helper showHudWithDuration:errorMsg];
        //[self alertErrorMessage:errorMsg title:@"登陆"];
    } withFailureBlock:^{
        [Helper hideHudFromView:self.view];
        [Helper showHudWithDuration:@"网络连接失败,请检查网络连接"];
        //[self alertErrorMessage:@"网络连接失败,请检查网络连接" title:nil];
    }];
}

- (BOOL)CheckIsAutoLogin
{
    isAutoLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:ISAUTO_LOGIN] boolValue];
    if (isAutoLogin) {
        [self.AutoLoginBtn setImage:[UIImage imageNamed:@"登录_选中.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.AutoLoginBtn setImage:[UIImage imageNamed:@"登录_未选中.png"] forState:UIControlStateNormal];
    }
    return isAutoLogin;
}

- (BOOL)CheckRemenberPwd
{
    isRemenberPwd= [[[NSUserDefaults standardUserDefaults] objectForKey:ISREMENBER_PWD] boolValue];
    
    if (isRemenberPwd) {
        [self.remenberBtn setImage:[UIImage imageNamed:@"登录_选中.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.remenberBtn setImage:[UIImage imageNamed:@"登录_未选中.png"] forState:UIControlStateNormal];
    }
    return isRemenberPwd;
}

@end
