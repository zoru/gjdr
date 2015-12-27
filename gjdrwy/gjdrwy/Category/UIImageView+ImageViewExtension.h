//
//  UIImageView+ImageViewExtension.h
//  gjdrwy
//
//  Created by jzkj on 15/12/15.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ImageViewExtension)
/**
 *  异步加载图片
 *
 *  @param urlString 图片地址
 */
- (void)loadImageWithUrl:(NSString*)urlString;

- (void)loadImageWithUrl:(NSString *)urlString plcaeHodel:(UIImage*)placeholder;

/**
 *  取消图片加载
 */
- (void)cancelLoadImage;


- (void)loadImageWithUrl:(NSString *)urlString plcaeHodel:(UIImage *)placeholder blcok:(void(^)(UIImage*))block;


@end
