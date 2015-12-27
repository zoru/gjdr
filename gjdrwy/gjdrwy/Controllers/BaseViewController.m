//
//  BaseViewController.m
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使导航栏在不透明的时候 视图自动调整高度
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
}

- (void)BasePushViewControler:(UIViewController *)ViewController
{
    ViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ViewController animated:YES];
}

- (void)setNavigationBack
{
    [self customizeNavigateBarButton:@"通用_返回.png" IsLeftButton:YES buttonAction:@selector(navigationControllerLeftEvent:)];
}

- (void)customizeNavigateBarButton:(NSString *)imageName IsLeftButton:(BOOL)bLeftButton buttonAction:(SEL)action
{
    UIImage *btnbackImage = [UIImage imageNamed: imageName];
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];

    [button setFrame: CGRectMake(0, 0, 47, 18)];
    [button setImage:btnbackImage forState:UIControlStateNormal];
    //[button setBackgroundImage:btnbackImage forState:UIControlStateNormal];
    [button addTarget: self action:action forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView: button];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width=-17;
    if(bLeftButton)
    {
        self.navigationItem.leftBarButtonItem = barButton;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = barButton;
    }
}
- (void)setNavigationBarItemTitle:(NSString *)title isLeft:(BOOL)left
{

    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
//    [button setFrame:CGRectMake(0.0, 0.0, 32.0, 32.0)];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:title forState:UIControlStateNormal];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView: button];
    if (left) {
        self.navigationItem.leftBarButtonItem= barButton;
        [button addTarget: self action:@selector(navigationControllerLeftEvent:) forControlEvents: UIControlEventTouchUpInside];
    }
    else
    {
        self.navigationItem.rightBarButtonItem=barButton;
        [button addTarget: self action:@selector(navigationControllerRightEvent:) forControlEvents: UIControlEventTouchUpInside];
    }
}

- (void)navigationControllerLeftEvent:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationControllerRightEvent:(UIButton*)sender
{
    
}


- (void)setViewBorder:(UIView*)view color:(UIColor*)color width:(CGFloat)width
{
    view.layer.borderColor = [color CGColor];
    view.layer.borderWidth = width;
}

- (void)setViewRadius:(UIView *)view rValue:(CGFloat)du
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = du;
}

- (void)alertErrorMessage:(NSString *)text title:(NSString *)title
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:text delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)cleanTableLine:(UITableView *)tableView
{
    UIView* view = [[UIView alloc] init];
    tableView.tableFooterView = view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
