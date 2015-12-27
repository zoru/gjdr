//
//  HomeViewController.m
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import "HomeViewController.h"
#import "UserCenterViewController.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "NoOrderCell.h"
#import "OrderCell.h"
#import "OrderModel.h"
#import "HelpDetailViewController.h"
#import "ProcessTypeViewController.h"

@interface HomeViewController ()<ProcessTypeControllerDelegate,PullTableViewDelegate>
{
    OrderStatus orderStatus;
    
    NSInteger allPages;
    NSInteger unProcessPages;
    NSInteger processPages;
    
    BOOL isFirstLoadAll;
    BOOL isFirstLoadProcess;
    BOOL isFirstLoadunProcess;
}

@property (nonatomic,strong)NSMutableArray* AllOrderArray;
@property (nonatomic,strong)NSMutableArray* unProcessedArray;
@property (nonatomic,strong)NSMutableArray* ProcessedArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    
    _AllOrderArray = [[NSMutableArray alloc] init];
    _unProcessedArray = [[NSMutableArray alloc] init];
    _ProcessedArray = [[NSMutableArray alloc] init];
    
    /*初始化数据状态*/
    [self initOrderStaues];
    
    /*设置视图*/
    [self initviews];
    
    [self LoginSuccess];
    
}

- (void)initOrderStaues
{
    orderStatus = OrderStatus_all;
    allPages = 1;
    unProcessPages = 1;
    processPages = 1;
    
    isFirstLoadAll = YES;
    isFirstLoadProcess = YES;
    isFirstLoadunProcess = YES;
}

- (void)initviews
{
    [_tableView registerNib:[UINib nibWithNibName:ordercell bundle:nil] forCellReuseIdentifier:ordercell];
    [_tableView registerNib:[UINib nibWithNibName:noordercell bundle:nil] forCellReuseIdentifier:noordercell];
    
    [self setViewRadius:_allCountLable rValue:_allCountLable.frame.size.height/2];
    [self setViewRadius:_unProcessCountLbale rValue:_unProcessCountLbale.frame.size.height/2];
    
    _allCountLable.hidden = YES;
    _unProcessCountLbale.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)serchBtnAction:(UIButton *)sender {
    SearchViewController* searchController = [[SearchViewController alloc] init];
    [self BasePushViewControler:searchController];
}

- (IBAction)allBtnAction:(UIButton *)sender {
    
    [self setMarkImageViewFrameWithView:sender];
    self.processTypeButton.enabled = NO;
    orderStatus = OrderStatus_all;
//    if (isFirstLoadAll) {
//        [self setup];
//        isFirstLoadAll = NO;
//    }
    [self setup];
    [self.tableView reloadData];
}

- (IBAction)pendingBtnAction:(UIButton *)sender {
    [self setMarkImageViewFrameWithView:sender];
     self.processTypeButton.enabled = NO;
    orderStatus = OrderStatus_unProcess;
//    if (isFirstLoadunProcess) {
//        [self setup];
//        isFirstLoadunProcess = NO;
//    }
    [self setup];
    [self.tableView reloadData];
}


- (IBAction)processedBtnAction:(UIButton *)sender {
    [self setMarkImageViewFrameWithView:sender];
    self.processTypeButton.enabled = YES;
    orderStatus = OrderStatus_processed;
//    if (isFirstLoadProcess) {
//        [self setup];
//        isFirstLoadProcess = NO;
//    }
    [self setup];
    [self.tableView reloadData];
}

- (IBAction)toUserCenter:(UIButton *)sender {
    UserCenterViewController* userCenter = [[UserCenterViewController alloc] init];
    [self BasePushViewControler:userCenter];

}

- (void)setMarkImageViewFrameWithView:(UIView*)view
{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = view.frame;
        CGRect imageFrame = _markImageView.frame;
        imageFrame.origin.x = frame.origin.x;
        _markImageView.frame = imageFrame;
        
        self.imageLeftConstraint.constant = view.frame.origin.x;
    }];

}

- (void)LoginSuccess
{
    self.nameLable.text = [UserInfo localUserInfo].user_Name;
    self.postLable.text = [NSString stringWithFormat:@"职位:%@",[UserInfo localUserInfo].user_Post];
    self.communityLbale.text = [UserInfo localUserInfo].user_Community;
    
    [self setup];
    
}

#pragma mark ----------------UITableViewDataSource,UITableViewDelegate------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (orderStatus) {
        case OrderStatus_all:
        {
            if(_AllOrderArray.count>0)
            {
                return _AllOrderArray.count;
            }
            else
                return 1;
        }
            break;
        case OrderStatus_processed:
        {
            if (_ProcessedArray.count>0) {
                return _ProcessedArray.count;
            }
            else
                return 1;
        }
            break;
        case OrderStatus_unProcess:
        {
            if (_unProcessedArray.count) {
                return _unProcessedArray.count;
            }
            return 1;
        }
            break;
        default:
            return 1;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (orderStatus) {
        case OrderStatus_all:
        {
            if(_AllOrderArray.count>0)
            {
                return 10;
            }
            else
                return 0;
        }
            break;
        case OrderStatus_processed:
        {
            if (_ProcessedArray.count>0) {
                return 10;
            }
            else
                return 0;
        }
            break;
        case OrderStatus_unProcess:
        {
            if (_unProcessedArray.count>0) {
                return 10;
            }
            return 0;
        }
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (orderStatus) {
        case OrderStatus_all:
        {
            if (!_AllOrderArray.count) {
                return _tableView.frame.size.height;
            }
            else
            {
                OrderModel* model = _AllOrderArray[indexPath.section];
                if (OrderStatus_processed == model.status) {
                     return 145;
                }
                else
                    return 120;
            }
        }
            break;
        case OrderStatus_processed:
        {
            if (!_ProcessedArray.count) {
                return _tableView.frame.size.height;
            }
            else
            {
                return 145;
            }
        }
            break;
        case OrderStatus_unProcess:
        {
            if (!_unProcessedArray.count) {
                return _tableView.frame.size.height;
            }
            else
            {
                return 120;
            }
        }
            break;
        default:
            break;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (orderStatus) {
        case OrderStatus_all:
        {
            if (!_AllOrderArray.count) {
                NoOrderCell*  cell = [tableView dequeueReusableCellWithIdentifier:noordercell];
                cell.titleLable.text = @"没有客户帮助请求";
                return cell;
            }
            else
            {
                OrderCell*  cell = [tableView dequeueReusableCellWithIdentifier:ordercell];
                OrderModel* model = _AllOrderArray[indexPath.section];
                [cell setValueWithModel:model];
                return cell;
            }
        }
            break;
        case OrderStatus_processed:
        {
            if (!_ProcessedArray.count) {
                NoOrderCell*  cell = [tableView dequeueReusableCellWithIdentifier:noordercell];
                 cell.titleLable.text = @"没有已处理的帮助请求";
                return cell;
            }
            else
            {
                OrderCell*  cell = [tableView dequeueReusableCellWithIdentifier:ordercell];
                OrderModel* model = _ProcessedArray[indexPath.section];
                [cell setValueWithModel:model];
                return cell;
            }
        }
            break;
        case OrderStatus_unProcess:
        {
            if (!_unProcessedArray.count) {
                NoOrderCell*  cell = [tableView dequeueReusableCellWithIdentifier:noordercell];
                cell.titleLable.text = @"没有需要处理的帮助请求";
                return cell;
            }
            else
            {
                OrderCell*  cell = [tableView dequeueReusableCellWithIdentifier:ordercell];
                OrderModel* model = _unProcessedArray[indexPath.section];
                [cell setValueWithModel:model];
                return cell;
            }
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderModel* model;
    switch (orderStatus) {
        case OrderStatus_all:
        {
            if (!_AllOrderArray.count) return;
            model = _AllOrderArray[indexPath.section];
        }
            break;
        case OrderStatus_processed:
        {
            if (!_ProcessedArray.count) return;
            model = _ProcessedArray[indexPath.section];
        }
            break;
        case OrderStatus_unProcess:
        {
            if (!_unProcessedArray.count) return;
            model = _unProcessedArray[indexPath.section];
        }
            break;
        default:
            break;
    }
    
    HelpDetailViewController* helpController = [[HelpDetailViewController alloc] init];
    helpController.model = model;
    [self BasePushViewControler:helpController];
}
- (IBAction)chooseProcessedType:(UIButton *)sender {
    
    ProcessTypeViewController* processTypeController = [[ProcessTypeViewController alloc] init];
    processTypeController.delegate = self;
    
    [self BasePushViewControler:processTypeController];
}

#pragma mark  ---------ProcessTypeControllerDelegate------------

- (void)selectProcessType:(ProcessType)type
{

    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    UserInfo* user = [UserInfo localUserInfo];
    [parameters setObject:WY_GETHELPLIST_METHOD forKey:@"method"];
    [parameters setObject:user.user_Id forKey:@"wyygId"];
    [parameters setObject:user.passWord forKey:@"password"];
    [parameters setObject:user.onlineKey forKey:@"onlineKey"];
    [parameters setObject:@(type) forKey:@"typeId"];
    
    if (OrderStatus_all !=orderStatus) {
        [parameters setObject:@(orderStatus) forKey:@"status"];
    }
    //[Helper showHud:nil inView:self.tableView];
    [RequestData completeNetRequestPOSTWithRequestURL:REQUEST_BASE_URL withParameter:parameters withReturnValeuBlock:^(id returnValue) {
        
        //[Helper hideHudFromView:_tableView];
        
        if (returnValue && [returnValue isKindOfClass:[NSDictionary class]]) {
            
            NSArray* array = returnValue[@"data"];
            if (array&& [array isKindOfClass:[NSArray class]]) {
                
                [self.ProcessedArray removeAllObjects];
                
                for (int i = 0; i<array.count; i++) {
                    
                    id data = array[i];
                    
                    if (data&& [data isKindOfClass:[NSDictionary class]]) {
                        OrderModel* model = [[OrderModel alloc] initWithJson:data];
                        if (model) {
                            [self.ProcessedArray addObject:model];
                        }
                    }
                }
            }
            [self.tableView reloadData];
        }
        
       

        
    } withErrorCodeBlock:^(NSString *errorMsg) {
        
        [Helper hideHudFromView:self.tableView];
        [Helper showHudWithDuration:errorMsg];
        
        
    } withFailureBlock:^{
        
        [Helper hideHudFromView:self.tableView];
        
    }];

}

#pragma mark ------------loaddata----------

- (void)setup
{
    __weak typeof(self)blockSelf = self;
    
    [self loadData:^(NSArray *array) {
        
        switch (orderStatus) {
            case OrderStatus_all:
            {
                [blockSelf.AllOrderArray removeAllObjects];
                [blockSelf.AllOrderArray addObjectsFromArray:array];
            }
                break;
            case OrderStatus_processed:
            {
                [blockSelf.ProcessedArray removeAllObjects];
                [blockSelf.ProcessedArray addObjectsFromArray:array];
            }
                break;
            case OrderStatus_unProcess:
            {
                [blockSelf.unProcessedArray removeAllObjects];
                [blockSelf.unProcessedArray addObjectsFromArray:array];
            }
                break;
            default:
                break;
        }
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
    {
        switch (orderStatus) {
            case OrderStatus_all:
            {
                currentPage = allPages+1;
            }
                break;
            case OrderStatus_processed:
            {
                currentPage = processPages+1;
            }
                break;
            case OrderStatus_unProcess:
            {
                currentPage = unProcessPages+1;
            }
                break;
            default:
                break;
        }
    }
    
    NSMutableDictionary* parameters = [[NSMutableDictionary alloc] init];
    UserInfo* user = [UserInfo localUserInfo];
    [parameters setObject:WY_GETHELPLIST_METHOD forKey:@"method"];
    [parameters setObject:user.user_Id forKey:@"wyygId"];
    [parameters setObject:user.passWord forKey:@"password"];
    [parameters setObject:user.onlineKey forKey:@"onlineKey"];
    [parameters setObject:@(currentPage) forKey:@"page"];
    
    if (OrderStatus_all !=orderStatus) {
         [parameters setObject:@(orderStatus) forKey:@"status"];
    }
    [Helper showHud:nil inView:self.tableView];
    [RequestData completeNetRequestPOSTWithRequestURL:REQUEST_BASE_URL withParameter:parameters withReturnValeuBlock:^(id returnValue) {
        
        [Helper hideHudFromView:self.tableView];
        
        [_tableView setPullTableIsLoadingMore:NO];
        [_tableView setPullTableIsRefreshing:NO];
        
        if (returnValue && [returnValue isKindOfClass:[NSDictionary class]]) {
    
            NSInteger amount = [returnValue[@"amount"] integerValue];
            if (amount>0) {
                NSString* amoutString = [NSString stringWithFormat:@"%ld",(long)amount];
                dispatch_async(dispatch_get_main_queue(), ^{
                    switch (orderStatus) {
                        case OrderStatus_all:
                        {
                            self.allCountLable.text = amoutString;
                            self.allCountLable.hidden = amount>0 ? NO:YES;
                            allPages = currentPage;
                        }
                            break;
                        case OrderStatus_processed:
                        {
                            processPages = currentPage;
                        }
                            break;
                        case OrderStatus_unProcess:
                        {
                            self.unProcessCountLbale.text = amoutString;
                            self.unProcessCountLbale.hidden = amount>0 ? NO:YES;
                            unProcessPages = currentPage;
                        }
                            break;
                        default:
                            break;
                    }
                });
            }
            
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
        
        [_tableView setPullTableIsLoadingMore:NO];
        [_tableView setPullTableIsRefreshing:NO];
        

    } withFailureBlock:^{
        
        [Helper hideHudFromView:self.tableView];
        [_tableView setPullTableIsLoadingMore:NO];
        [_tableView setPullTableIsRefreshing:NO];
        
    }];
}

#pragma mark ------pulltableView--------

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    [_tableView setPullTableIsRefreshing:YES];
    [_tableView setPullTableIsLoadingMore:NO];
    [self setup];
}


- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    [_tableView setPullTableIsRefreshing:NO];
    [_tableView setPullTableIsLoadingMore:YES];
    
    __weak typeof(self) blockSelf = self;
    [self loadData:^(NSArray *array) {
        switch (orderStatus) {
            case OrderStatus_all:
            {
                [blockSelf.AllOrderArray addObjectsFromArray:array];
            }
                break;
            case OrderStatus_processed:
            {
                [blockSelf.ProcessedArray addObjectsFromArray:array];
            }
                break;
            case OrderStatus_unProcess:
            {
                [blockSelf.unProcessedArray addObjectsFromArray:array];
            }
                break;
            default:
                break;
        }
        blockSelf.tableView.pullTableIsRefreshing = NO;
        [blockSelf.tableView reloadData];
    } isRefresh:NO];
}

- (void)logout
{
//    [self.AllOrderArray removeAllObjects];
//    [self.ProcessedArray removeAllObjects];
//    [self.unProcessedArray removeAllObjects];
//    
//    [UserInfo deleteUserInfo];
//    
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    
//    LoginViewController* loginController = [[LoginViewController alloc] init];
//    loginController.isLoginLaunch = NO;
//    [self.navigationController presentViewController:loginController animated:YES completion:nil];
}

@end
