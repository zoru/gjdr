//
//  UserInfo.h
//  gjdryz
//
//  Created by AllPepole on 15/12/13.
//
//

#import <Foundation/Foundation.h>

/**
 *  绑定信息改变通知
 */
static NSString* const UserBindInfoChanged  = @"UserBindInfoChanged";

#define USERINFO_COMMUNITY              @"Community"
#define USERINFO_REALNAME               @"RealName"
#define USERINFO_POSTS                  @"Posts"
#define USERINFO_ONLINEKey              @"OnlineKey"
#define USERINFO_ID                     @"UserId"
#define USERINF_DEPARTMENT              @"DepartMent"
#define USERINF_PASSWORD                @"Password"

@interface UserInfo : NSObject

@property   (nonatomic,copy)NSString* user_Community;       //业主所在小区名称
@property   (nonatomic,copy)NSString* user_Name;        //姓名
@property   (nonatomic,copy)NSString* user_Post;         //职位
@property   (nonatomic,copy)NSString* onlineKey;
@property   (nonatomic,copy)NSString* user_Id;
@property   (nonatomic,copy)NSString* department;
@property   (nonatomic,copy)NSString* passWord;


+ (UserInfo*)UserInfoWithJson:(id)data;

/**
 *  获取本地信息
 *
 *  @return
 */
+ (UserInfo*)localUserInfo;

/**
 *  保存信息
 */
- (void)SavaUserInfo;

/**
 *  清除信息
 */
+ (void)deleteUserInfo;


@end
