//
//  ModifyPwdCell.h
//  gjdrwy
//
//  Created by AllPepole on 15/12/10.
//  Copyright (c) 2015年 AllPepole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModifyPwdViewController.h"


static NSString* const modifyPasswordcell = @"ModifyPwdCell";

@interface ModifyPwdCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *oldPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *NpwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *NePwdTextField;

@property (strong,nonatomic)ModifyPwdViewController* superController;

- (IBAction)modifyCancel:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;

@end
