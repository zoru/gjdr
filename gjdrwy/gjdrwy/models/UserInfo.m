//
//  UserInfo.m
//  gjdryz
//
//  Created by AllPepole on 15/12/13.
//
//

#import "UserInfo.h"
#import "NSString+StringExtension.h"
#import "NSDictionary+dictionaryExtension.h"

@implementation UserInfo


+ (UserInfo*)UserInfoWithJson:(id)data
{
    UserInfo* user = [[UserInfo alloc] init];
    
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        NSDictionary*dic = (NSDictionary*)data;
        user.user_Id = [dic objectForNotNullKey:@"wyygId"];
        user.onlineKey = [dic objectForNotNullKey:@"onlineKey"];
        user.user_Name = [dic objectForNotNullKey:@"name"];
        user.department = [dic objectForNotNullKey:@"department"];
        user.user_Post = [dic objectForNotNullKey:@"position"];
        user.user_Community = [dic objectForNotNullKey:@"xqname"];
    }
    return user;
}

- (void)SavaUserInfo
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if ([NSString isNullOrEmpty:self.user_Id])  [defaults setObject:@"" forKey:USERINFO_ID];
    else    [defaults setObject:self.user_Id forKey:USERINFO_ID];
    
    if ([NSString isNullOrEmpty:self.user_Name])  [defaults setObject:@"" forKey:USERINFO_REALNAME];
    else    [defaults setObject:self.user_Name forKey:USERINFO_REALNAME];
    
    if ([NSString isNullOrEmpty:self.user_Post])  [defaults setObject:@"" forKey:USERINFO_POSTS];
    else    [defaults setObject:self.user_Post forKey:USERINFO_POSTS];
    
    if ([NSString isNullOrEmpty:self.user_Community])  [defaults setObject:@"" forKey:USERINFO_COMMUNITY];
    else    [defaults setObject:self.user_Community forKey:USERINFO_COMMUNITY];
    
    if ([NSString isNullOrEmpty:self.onlineKey])  [defaults setObject:@"" forKey:USERINFO_ONLINEKey];
    else    [defaults setObject:self.onlineKey forKey:USERINFO_ONLINEKey];
    
    if ([NSString isNullOrEmpty:self.department])  [defaults setObject:@"" forKey:USERINF_DEPARTMENT];
    else    [defaults setObject:self.department forKey:USERINF_DEPARTMENT];
    
    if ([NSString isNullOrEmpty:self.passWord])  [defaults setObject:@"" forKey:USERINF_PASSWORD];
    else    [defaults setObject:self.passWord forKey:USERINF_PASSWORD];
    
    [defaults synchronize];
   
}

+ (UserInfo*)localUserInfo
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    UserInfo* user = [[UserInfo alloc] init];
    user.user_Community = [defaults objectForKey:USERINFO_COMMUNITY];
    user.user_Name = [defaults objectForKey:USERINFO_REALNAME];
    user.user_Post = [defaults objectForKey:USERINFO_POSTS];
    user.user_Id = [defaults objectForKey:USERINFO_ID];
    user.onlineKey = [defaults objectForKey:USERINFO_ONLINEKey];
    user.department = [defaults objectForKey:USERINF_DEPARTMENT];
    user.passWord = [defaults objectForKey:USERINF_PASSWORD];
    return user;
}


+ (void)deleteUserInfo
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:USERINFO_COMMUNITY];
    [defaults removeObjectForKey:USERINFO_REALNAME];
    [defaults removeObjectForKey:USERINFO_POSTS];
    [defaults removeObjectForKey:USERINFO_ID];
    [defaults removeObjectForKey:USERINF_DEPARTMENT];
    [defaults removeObjectForKey:USERINFO_ONLINEKey];
    [defaults removeObjectForKey:USERINF_PASSWORD];
    [defaults synchronize];
}

@end
