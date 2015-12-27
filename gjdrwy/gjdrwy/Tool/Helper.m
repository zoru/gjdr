//
//  Helper.m
//  gjdrwy
//
//  Created by AllPepole on 15/12/18.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import "Helper.h"
#import "MBProgressHUD.h"

@implementation Helper

+ (void)runInMainQueue:(void (^)())queue{
    dispatch_async(dispatch_get_main_queue(), queue);
}

+ (void)runInGlobalQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), queue);
}

+ (void)runAfterSecs:(float)secs block:(void (^)())block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, secs*NSEC_PER_SEC), dispatch_get_main_queue(), block);
}

+ (UIWindow*)mainWindow
{
    return [[[UIApplication sharedApplication] delegate] window];
}

+ (void)showHud:(NSString*)messgae inView:(UIView*)view
{
    [Helper runInMainQueue:^{
       
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.labelText = messgae;
    }];
}

+(void)hideHudFromView:(UIView*)view
{
    [Helper runInMainQueue:^{
        [MBProgressHUD hideHUDForView:view animated:YES];
    }];
}

+ (void)showHud:(NSString *)message
{
    [Helper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:Helper.mainWindow animated:YES];
        hud.labelText = message;
    }];
}

+ (void)hideHud
{
    [Helper runInMainQueue:^{
        [MBProgressHUD hideAllHUDsForView:Helper.mainWindow animated:YES];
    }];
}

+ (void)toast:(NSString *)message
{
    [Helper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:Helper.mainWindow animated:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:hud action:@selector(removeFromSuperview)];
        [hud addGestureRecognizer:tap];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        double delayInSeconds = 1.6;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideAllHUDsForView:Helper.mainWindow animated:YES];
        });
    }];
}

+ (void)toast:(NSString *)message block:(void (^)())block
{
    [Helper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:Helper.mainWindow animated:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:hud action:@selector(removeFromSuperview)];
        [hud addGestureRecognizer:tap];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        double delayInSeconds = 1.6;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideAllHUDsForView:Helper.mainWindow animated:YES];
        });
    }];
}

+ (void)showHudWithDuration:(NSString *)message{
    [Helper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:Helper.mainWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        double delayInSeconds = 1.6;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideAllHUDsForView:Helper.mainWindow animated:YES];
        });
    }];
    
}

+ (void)showHud:(NSString *)message inView:(UIView*)view withCustemView:(UIView*)custemView;
{
    [Helper runInMainQueue:^{
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.labelText = message;
        hud.customView = view;
    }];
}
@end
