//
//  UIActionSheet+block.m
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import "CustemUIActionSheet.h"

@implementation CustemUIActionSheet


- (id)initWithTitle:(NSString *)title block:(ActionSheetBlock)blcok destructiveButtonTitle:(NSString *)destructive othersButton:(NSString *)ohters, ...
{
    self = [self initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:destructive otherButtonTitles: nil];
    if (self) {
        
        _Clickblock = blcok;
        
        va_list _arguments;
        va_start(_arguments, ohters);
        for (NSString *key = ohters; key != nil; key = (__bridge NSString *)va_arg(_arguments, void *)) {
            [self addButtonWithTitle:key];
        }
        va_end(_arguments);
    }
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    BOOL isCance = buttonIndex == self.cancelButtonIndex?YES:NO;
    _Clickblock(isCance, buttonIndex);
}
@end
