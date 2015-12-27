//
//  ShowImageViewController.h
//  gjdryz
//
//  Created by AllPepole on 15/12/9.
//
//

#import "BaseViewController.h"


@interface ShowImageViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UILabel *pageLable;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic)NSArray* imageArray;
@property (assign,nonatomic)NSInteger imageIndex;


@end
