//
//  config.h
//  gjdryz
//
//  Created by AllPepole on 15/12/9.
//
//

#ifndef gjdryz_config_h
#define gjdryz_config_h


#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width

#define ScreenHeight_NoNavigat   [UIScreen mainScreen].bounds.size.height-64


#define REQUEST_BASE_URL                @"http://gjdr.app.zrukj.com/gjdrService/interface"

// 关于
#define ABOUT_URL                       @"http://gjdr.app.zrukj.com/gjdrService/interface?method=aboutWe&isPage=1"

#define DOWNIMAGE_URL                   @"http://gjdr.app.zrukj.com/filemanage/download.do?storeFileName="

// 登陆
#define WY_LOGIN_METHOD                 @"wyLogin"
// 获取帮助信息列表
#define WY_GETHELPLIST_METHOD           @"wyHelpRecordList"
//修改密码
#define WY_MODIFYPWD_METHOD             @"wyModifyPassword"
//获取所有内容分类
#define WY_GETCONTENTYPE_METHOD         @"getContentTypeList"
//获取帮助详情
#define WY_GETHELPDETAIL_METHOD         @"wyHelpDetail"
#endif
