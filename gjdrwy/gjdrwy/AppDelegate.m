//
//  AppDelegate.m
//  gjdrwy
//
//  Created by AllPepole on 15/12/10.
//  Copyright (c) 2015年 AllPepole. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "JPushHelpr.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [JPushHelpr setupWithOptions:launchOptions];
    [self goLoginViewController];
    
   
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPushHelpr registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [JPushHelpr handleRemoteNotification:userInfo completion:nil];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [JPushHelpr handleRemoteNotification:userInfo completion:completionHandler];
    if (application.applicationState == UIApplicationStateInactive) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"收到推送" message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
#endif

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [JPushHelpr showLocalNotificationAtFront:notification];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"消息推送注册失败.错误:%@",error);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler
{
    
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    
    
}

- (void)goHomeViewController
{
    _navigatControl = nil;
    
    _homeController = [[HomeViewController alloc] init];
    _navigatControl = [[UINavigationController alloc] initWithRootViewController:_homeController];
    [_navigatControl.navigationBar setBackgroundImage:[UIImage imageNamed:@"通用_状态栏背景.png"] forBarMetrics:UIBarMetricsDefault];
     _window.rootViewController = _navigatControl;
     [_window makeKeyAndVisible];
}


- (void)goLoginViewController
{
    if (_homeController) {
        _homeController = nil;
    }
    _navigatControl = nil;
    
    LoginViewController* loginController = [[LoginViewController alloc] init];
    
    _navigatControl = [[UINavigationController alloc] initWithRootViewController:loginController];
    [_navigatControl.navigationBar setBackgroundImage:[UIImage imageNamed:@"通用_状态栏背景.png"] forBarMetrics:UIBarMetricsDefault];
    _navigatControl.navigationBarHidden = YES;
    _window.rootViewController = _navigatControl;
     [_window makeKeyAndVisible];
}

+ (AppDelegate*)shareAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

@end
