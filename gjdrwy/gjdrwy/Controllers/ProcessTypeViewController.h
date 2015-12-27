//
//  ProcessTypeViewController.h
//  gjdrwy
//
//  Created by AllPepole on 15/12/13.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import "BaseViewController.h"
#import "PullTableView.h"

typedef NS_ENUM(NSInteger,ProcessType) {
    
    ProcessType_tousu = 1,
    ProcessType_jianyi = 2,
    ProcessType_baoxiu = 3,
    ProcessType_zixun = 4,
    ProcessType_qita = 5,
};

@protocol ProcessTypeControllerDelegate <NSObject>

- (void)selectProcessType:(ProcessType)type;

@end

@interface ProcessTypeViewController : BaseViewController

@property (nonatomic,assign)id<ProcessTypeControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet PullTableView *tableView;

@end
