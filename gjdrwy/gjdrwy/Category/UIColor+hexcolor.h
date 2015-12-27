//
//  UIColor+hexcolor.h
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (hexcolor)

+(UIColor*)colorWithHex:(long)hexColor alpha:(float)opacity;

+(UIColor*)colorWithHex:(long)hexColor;

@end
