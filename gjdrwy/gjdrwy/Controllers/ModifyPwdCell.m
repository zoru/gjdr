//
//  ModifyPwdCell.m
//  gjdrwy
//
//  Created by AllPepole on 15/12/10.
//  Copyright (c) 2015年 AllPepole. All rights reserved.
//

#import "ModifyPwdCell.h"
#import "NSString+StringExtension.h"
#import "RequestData.h"

@implementation ModifyPwdCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)modifyCancel:(UIButton *)sender {
    
    [self.superController.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(UIButton *)sender {
    
    NSString* oldPwd = self.oldPwdTextField.text;
    NSString* NPwd = self.NpwdTextField.text;
    NSString* NePwd = self.NePwdTextField.text;
    
    if ([NSString isNullOrEmpty:oldPwd]) {
        [Helper toast:@"请输入密码"];
        return;
    }
    if ([NSString isNullOrEmpty:NPwd]||[NSString isNullOrEmpty:NePwd]) {
        [Helper toast:@"请输入密码"];
        return;
    }
    
    if (![NPwd isEqualToString:NePwd]) {
        [Helper toast:@"请输入密码"];
        return;
    }
    
    NSMutableDictionary* parmaeter = [[NSMutableDictionary alloc] init];
    [parmaeter setObject:[UserInfo localUserInfo].user_Id forKey:@"wyygId"];
    [parmaeter setObject:[UserInfo localUserInfo].onlineKey forKey:@"onlineKey"];
    [parmaeter setObject:[UserInfo localUserInfo].passWord forKey:@"password"];
    [parmaeter setObject:oldPwd forKey:@"oldPassword"];
    [parmaeter setObject:NePwd forKey:@"newPassword"];
    [parmaeter setObject:WY_MODIFYPWD_METHOD forKey:@"method"];
    
    [Helper showHud:nil];
    [RequestData netRequestPOSTWithRequestURL:REQUEST_BASE_URL withParameter:parmaeter withReturnValeuBlock:^(id returnValue) {
        
        [Helper hideHud];
        UserInfo* user = [UserInfo localUserInfo];
        user.passWord  = NePwd;
        [user SavaUserInfo];

        [Helper showHudWithDuration:@"密码修改成功,新密码已经生效"];
        [self.superController.navigationController popViewControllerAnimated:YES];
        

    } withErrorCodeBlock:^(NSString *errorMsg) {
        [Helper hideHud];
        [Helper showHudWithDuration:errorMsg];

    } withFailureBlock:^{
        [Helper hideHud];
    }];
   
}
@end
