//
//  BaseViewController.h
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import <UIKit/UIKit.h>
#import "UIColor+hexcolor.h"
#import "UIImage+Color.h"
#import "NSString+StringExtension.h"
#import "config.h"
#import "UserInfo.h"
#import "RequestData.h"
#import "NSDictionary+dictionaryExtension.h"
#import "Helper.h"

@interface BaseViewController : UIViewController
/**
 *  页面跳转
 *
 *  @param ViewController 需要跳转的页面
 */
- (void)BasePushViewControler:(UIViewController*)ViewController;
/**
 *  设置返回按钮
 */
- (void)setNavigationBack;
/**
 *  提示信息
 *
 *  @param text  提示信息
 *  @param title 标题
 */
- (void)alertErrorMessage:(NSString *)text title:(NSString*)title;
/**
 *  设置视图圆角弧度
 *
 *  @param view 视图
 *  @param du   弧度
 */
- (void)setViewRadius:(UIView *)view rValue:(CGFloat)du;
/**
 *  设置视图边框
 *
 *  @param color 边框颜色
 *  @param width 边框宽度
 */
- (void)setViewBorder:(UIView*)view color:(UIColor*)color width:(CGFloat)width;

/**
 *  清除UITableView多余的分割线
 *
 *  @param tableView
 */
- (void)cleanTableLine:(UITableView*)tableView;

/**
 *  自定义导航按钮
 *
 *  @param imageName   图片名称
 *  @param bLeftButton 是否是左按钮
 *  @param action      响应函数
 */
- (void)customizeNavigateBarButton:(NSString *) imageName IsLeftButton:(BOOL)bLeftButton buttonAction:(SEL)action;
/**
 *  自定义导航按钮
 *
 *  @param title 按钮标题
 *  @param left  是否做按钮
 */
- (void)setNavigationBarItemTitle:(NSString *)title isLeft:(BOOL)left;
/**
 *  App委托
 *
 *  @return AppDelegate*
 */

@end

