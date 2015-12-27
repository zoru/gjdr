//
//  ModifyPwdViewController.m
//  gjdrwy
//
//  Created by AllPepole on 15/12/10.
//  Copyright (c) 2015年 AllPepole. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import "ModifyPwdCell.h"

@interface ModifyPwdViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBack];
    self.title = @"修改密码";
    [_tableView registerNib:[UINib nibWithNibName:modifyPasswordcell bundle:nil] forCellReuseIdentifier:modifyPasswordcell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight_NoNavigat;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModifyPwdCell* cell = [_tableView dequeueReusableCellWithIdentifier:modifyPasswordcell];
    
    cell.superController = self;
    return cell;
}


@end
