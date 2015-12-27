//
//  HelpDetailViewController.m
//  gjdrwy
//
//  Created by AllPepole on 15/12/11.
//  Copyright (c) 2015年 AllPepole. All rights reserved.
//

#import "HelpDetailViewController.h"
#import "HelpDetailCompleteCell.h"
#import "HelpDetailUnProcessCell.h"
#import "ShowImageViewController.h"

@interface HelpDetailViewController ()<UITableViewDataSource,UITableViewDelegate,showImageDelegate>

@end

@implementation HelpDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"帮助详情";
    [self setNavigationBack];
    
    [_tableView registerNib:[UINib nibWithNibName:heldetailcell bundle:nil] forCellReuseIdentifier:heldetailcell];
    
    [_tableView registerNib:[UINib nibWithNibName:helpdetailunprocessCell bundle:nil] forCellReuseIdentifier:helpdetailunprocessCell];
    
    [self setup];
}


- (void)setup
{
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    UserInfo* user = [UserInfo localUserInfo];
    [parameters setObject:user.passWord forKey:@"password"];
    [parameters setObject:user.user_Id forKey:@"wyygId"];
    [parameters setObject:user.onlineKey forKey:@"onlineKey"];
    [parameters setObject:self.model.helpId forKey:@"helpId"];
    [parameters setObject:WY_GETHELPDETAIL_METHOD forKey:@"method"];
    
    [Helper showHud:@""];
    
    [RequestData netRequestPOSTWithRequestURL:REQUEST_BASE_URL withParameter:parameters withReturnValeuBlock:^(id returnValue) {
        
        [Helper hideHud];
        
        if (returnValue && [returnValue isKindOfClass:[NSDictionary class]]) {
            
            [self.model setValueWithJson:returnValue];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
               
            });
        }
        
    } withErrorCodeBlock:^(NSString *errorMsg) {
        [Helper hideHud];
        [Helper showHudWithDuration:errorMsg];
        
    } withFailureBlock:^{
        [Helper hideHud];
    }];
    
}
#pragma mark ------------UITableViewDataSource,UITableViewDelegate-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = self.tableView.frame.size.height;
    switch (_model.status) {
        case OrderStatus_processed:
        {
            HelpDetailCompleteCell* cell = [[[NSBundle mainBundle] loadNibNamed:heldetailcell owner:nil options:nil] lastObject];
            height = cell.frame.size.height;
        }
            break;
        case OrderStatus_unProcess:
        {
            HelpDetailUnProcessCell* cell = [[[NSBundle mainBundle] loadNibNamed:helpdetailunprocessCell owner:nil options:nil] lastObject];
            height = cell.frame.size.height;
        }
            break;
        default:
            break;
    }
    return height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (_model.status) {
        case OrderStatus_processed:
        {
            HelpDetailCompleteCell* cell = [tableView dequeueReusableCellWithIdentifier:heldetailcell];
            [cell setOrderInfo:_model];
            cell.delegate = self;
            return cell;
        }
            break;
        case OrderStatus_unProcess:
        {
            HelpDetailUnProcessCell* cell = [tableView dequeueReusableCellWithIdentifier:helpdetailunprocessCell];
            cell.delegate = self;
            [cell setdataWithModel:_model];
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)showImageWithIndex:(NSInteger)index
{
    ShowImageViewController* showImage = [[ShowImageViewController alloc] init];
    showImage.imageArray = self.model.images;
    showImage.imageIndex = index;
    [self presentViewController:showImage animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
