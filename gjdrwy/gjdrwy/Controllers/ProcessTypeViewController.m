//
//  ProcessTypeViewController.m
//  gjdrwy
//
//  Created by AllPepole on 15/12/13.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import "ProcessTypeViewController.h"
#import "ProcessTypeCell.h"
@interface ProcessTypeViewController ()<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>

@property (nonatomic,strong)NSMutableArray* typeArray;

@end

@implementation ProcessTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类筛选";
    [self setNavigationBack];
    
    _typeArray = [[NSMutableArray alloc] init];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:processtypecell bundle:nil] forCellReuseIdentifier:processtypecell];
    [self cleanTableLine:self.tableView];
    
    
    [self loadData];
//    _typeArray = @[@{@"image":@"物管-已处理分类_03.png",@"title":@"投诉",@"type":@(ProcessType_tousu)},@{@"image":@"物管-已处理分类_07.png",@"title":@"建议",@"type":@(ProcessType_jianyi)},@{@"image":@"物管-已处理分类_10.png",@"title":@"报修",@"type":@(ProcessType_baoxiu)},@{@"image":@"物管-已处理分类_15.png",@"title":@"咨询",@"type":@(ProcessType_zixun)},@{@"image":@"物管-已处理分类_18.png",@"title":@"其他",@"type":@(ProcessType_qita)}];

}

- (void)loadData
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    [dic setObject:WY_GETCONTENTYPE_METHOD forKey:@"method"];
    
    [Helper showHud:nil inView:self.view];
    
    [RequestData netRequestGETWithRequestURL:REQUEST_BASE_URL withParameter:dic withReturnValeuBlock:^(id returnValue) {
        
        [Helper hideHudFromView: self.view];
        [self.tableView setPullTableIsRefreshing:NO];
        
        if (returnValue && [returnValue isKindOfClass:[NSArray class]]) {
            
            NSArray* array = (NSArray*)returnValue;
            
            [self.typeArray removeAllObjects];
            
            [array enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
                
                if (obj && [obj isKindOfClass:[NSDictionary class]]) {
            
                    [self.typeArray addObject:obj];
                }
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
           
        }

        
    } withErrorCodeBlock:^(NSString *errorMsg) {
        [Helper hideHudFromView:self.view];
        [self alertErrorMessage:errorMsg title:nil];
        [self.tableView setPullTableIsRefreshing:NO];
    } withFailureBlock:^{
        [Helper hideHudFromView:self.view];
        [self.tableView setPullTableIsRefreshing:NO];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _typeArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProcessTypeCell* cell = [_tableView dequeueReusableCellWithIdentifier:processtypecell];
    NSDictionary* dic = _typeArray[indexPath.row];
    NSInteger typeId = [dic[@"id"] integerValue];
    
    cell.processLbale.text = dic[@"name"];
    cell.processTypeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"物管-已处理分类_%ld.png",(long)typeId]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProcessTypeCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectImageView.hidden = NO;
    NSDictionary* dic = _typeArray[indexPath.row];
    
    if ([self.delegate performSelector:@selector(selectProcessType:)]) {
        [self.delegate selectProcessType:[[dic objectForKey:@"id"] integerValue]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProcessTypeCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectImageView.hidden = YES;
}


- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self.tableView setPullTableIsRefreshing:YES];
    [self.tableView setPullTableIsLoadingMore:NO];
    [self loadData];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self.tableView setPullTableIsRefreshing:NO];
    [self.tableView setPullTableIsLoadingMore:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
