//
//  CustemUIActionSheet.h
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import <UIKit/UIKit.h>

typedef void (^ActionSheetBlock)(BOOL isCancel, NSInteger buttonIndex);

@interface CustemUIActionSheet : UIActionSheet<UIActionSheetDelegate>

@property (nonatomic, strong)ActionSheetBlock Clickblock;

- (id)initWithTitle:(NSString*)title block:(ActionSheetBlock) blcok destructiveButtonTitle:(NSString*)destructive othersButton:(NSString*)ohters,...NS_REQUIRES_NIL_TERMINATION;

@end
