//
//  SearchViewController.m
//  gjdryz
//
//  Created by AllPepole on 15/12/10.
//
//

#import "SearchViewController.h"
#import "OrderCell.h"
#import "HelpDetailViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSInteger pageIndex;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    [self setNavigationBack];
    
    _OrderArray = [[NSMutableArray alloc] init];
    pageIndex = 1;
    [_tableView registerNib:[UINib nibWithNibName:ordercell bundle:nil] forCellReuseIdentifier:ordercell];
    [self cleanTableLine:_tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startSearch:(UIButton *)sender {
    
    NSString* keyword = self.searchTextField.text;
    if([NSString isNullOrEmpty:keyword]){
        [Helper showHudWithDuration:@"请输入订单号"];
        return;
    }
    
    [self setup];
}



#pragma mark --------UITableViewDataSource,UITableViewDelegate------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _OrderArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel* model = _OrderArray[indexPath.section];
    switch (model.status) {
        case OrderStatus_processed:
        {
            return 145;
        }
            break;
        case OrderStatus_unProcess:
        {
            return 120;
        }
            break;
        default:
            break;
    }

    return 145;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_OrderArray.count) {
        return 10;
    }
    else return 0.000000001;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell* cell = [_tableView dequeueReusableCellWithIdentifier:ordercell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:ordercell owner:nil options:nil] lastObject];
    }
    OrderModel* model = _OrderArray[indexPath.section];
    
    [cell setValueWithModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderModel* model = _OrderArray[indexPath.section];
    HelpDetailViewController* detailCntroller = [[HelpDetailViewController alloc] init];
    detailCntroller.model = model;
    [self.navigationController pushViewController:detailCntroller animated:YES];
}

- (void)setup
{
    __weak typeof(self)blockSelf = self;
    
    [self loadData:^(NSArray *array) {
        [blockSelf.OrderArray removeAllObjects];
        [blockSelf.OrderArray addObjectsFromArray:array];
        [blockSelf.tableView reloadData];
    } isRefresh:YES];
}
- (void)loadData:(void(^)(NSArray* array))block isRefresh:(BOOL)refresh
{
    NSInteger currentPage = 1;
    
    if (refresh) {
        currentPage = 1;
    }
    else
        currentPage = pageIndex+1;
    NSString* keyword = self.searchTextField.text;
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    UserInfo* user = [UserInfo localUserInfo];
    [parameters setObject:WY_GETHELPLIST_METHOD forKey:@"method"];
    [parameters setObject:user.user_Id forKey:@"wyygId"];
    [parameters setObject:user.passWord forKey:@"password"];
    [parameters setObject:user.onlineKey forKey:@"onlineKey"];
    [parameters setObject:keyword forKey:@"keyword"];
    [parameters setObject:@(currentPage) forKey:@"page"];
    

    [Helper showHud:nil inView:self.tableView];
    [RequestData completeNetRequestPOSTWithRequestURL:REQUEST_BASE_URL withParameter:parameters withReturnValeuBlock:^(id returnValue) {

        [Helper hideHudFromView:self.tableView];
        
        if (returnValue && [returnValue isKindOfClass:[NSDictionary class]]) {
            
            NSArray* array = returnValue[@"data"];
            NSMutableArray* OrderArray = [[NSMutableArray alloc] init];
            
            [array enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
                if (obj && [obj isKindOfClass:[NSDictionary class]]) {
                    OrderModel* model = [[OrderModel alloc] initWithJson:obj];
                    if (model) {
                        [OrderArray addObject:model];
                    }
                }
            }];

            
            block(OrderArray);
        }
    } withErrorCodeBlock:^(NSString *errorMsg) {
        
        [Helper hideHudFromView:self.tableView];
        [Helper showHudWithDuration:errorMsg];
        
    } withFailureBlock:^{
        [Helper hideHudFromView:self.tableView];
    
    }];
}

#pragma mark -----UITextFieldDelegate-------

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self startSearch:nil];
    return YES;
}



@end
