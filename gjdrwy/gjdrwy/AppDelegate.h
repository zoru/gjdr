//
//  AppDelegate.h
//  gjdrwy
//
//  Created by AllPepole on 15/12/10.
//  Copyright (c) 2015年 AllPepole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HomeViewController* homeController;
@property (strong, nonatomic) UINavigationController* navigatControl;

- (void)goHomeViewController;
- (void)goLoginViewController;

+ (AppDelegate*)shareAppDelegate;

@end

