//
//  Helper.h
//  gjdrwy
//
//  Created by AllPepole on 15/12/18.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Helper : NSObject

+ (UIWindow*)mainWindow;

+ (void)showHud:(NSString*)messgae inView:(UIView*)view;

+ (void)hideHudFromView:(UIView*)view;

+ (void)showHud:(NSString *)message;

+ (void)hideHud;

+ (void)showHud:(NSString *)message inView:(UIView*)view withCustemView:(UIView*)custemView;


+ (void)toast:(NSString *)message;

+ (void)toast:(NSString *)message block:(void (^)())block;

+ (void)showHudWithDuration:(NSString *)message;

@end
