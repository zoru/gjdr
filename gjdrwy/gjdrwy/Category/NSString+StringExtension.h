//
//  NSString+StringExtension.h
//  Environmental
//
//  Created by CG on 15/9/5.
//  Copyright (c) 2015年 CG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringExtension)

+ (BOOL) isNullOrEmpty:(NSString *)string;

- (NSString *)toMD5;
+(NSString *)md5pwd:(NSString *)pwsstr;
- (CGRect) getStringRectWith:(int)maxwidth maxheight:(int)maxheight fontSize:(float)size;

/**
 *  全数字
 *
 *  @return BOOL
 */
- (BOOL)isOnlyNumber;
/**
 * 纯数字或带有中划线
 *
 *  @return BOOL
 */
- (BOOL)isOnlyNumberOrLine;
/**
 *  数字验证码
 *
 *  @return BOOL
 */
- (BOOL)isNumSecurityCode;
/**
 *  手机号码正则校验
 *
 *  @return BOOL
 */
- (BOOL)isMobileNo;
/**
 *  身份证验证
 *
 *  @return BOOL
 */
- (BOOL)validateIDCardNumber;
/**
 *  获取设备型号
 *
 *  @return
 */

@end
