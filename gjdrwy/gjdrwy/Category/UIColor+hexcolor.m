//
//  UIColor+hexcolor.m
//  gjdryz
//
//  Created by AllPepole on 15/12/5.
//
//

#import "UIColor+hexcolor.h"

@implementation UIColor (hexcolor)

+(UIColor*)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
+(UIColor*)colorWithHex:(long)hexColor
{
    return [UIColor colorWithHex:hexColor alpha:1];
}
@end
