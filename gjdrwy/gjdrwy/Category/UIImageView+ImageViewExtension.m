//
//  UIImageView+ImageViewExtension.m
//  gjdrwy
//
//  Created by jzkj on 15/12/15.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import "UIImageView+ImageViewExtension.h"
#import "NSString+StringExtension.h"

@implementation UIImageView (ImageViewExtension)

- (void)loadImageWithUrl:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSData* data = [NSData dataWithContentsOfURL:url];
    if (data && data.length>0) {
        UIImage* image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    }
}

- (void)loadImageWithUrl:(NSString *)urlString plcaeHodel:(UIImage*)placeholder
{
    if (placeholder) {
        self.image = placeholder;
    }
    __weak typeof(self)blcokself = self;
    
    [self getImageWithUrl:urlString complete:^(UIImage * image) {
        blcokself.image = image;
    }];
}

- (void)getImageWithUrl:(NSString*)urlString  complete:(void(^)(UIImage* image))hander
{
    NSURLCache* cache = [self shareCache];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0];
    
    NSCachedURLResponse* response = [cache cachedResponseForRequest:request];
    if (response) {
        if (hander) {
            UIImage * image = [UIImage imageWithData:response.data];
            dispatch_async(dispatch_get_main_queue(), ^{
                hander(image);
            });
        }
    }
    else
    {
        [NSURLConnection sendAsynchronousRequest:request queue:[self shareQueue] completionHandler:^(NSURLResponse *  response, NSData *  data, NSError *  connectionError) {
            UIImage* image = [UIImage imageWithData:data];
            if (hander) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    hander(image);
                });
            }
        }];
    }
    
}

- (NSURLCache*)shareCache
{
    NSURLCache* cache = [NSURLCache sharedURLCache];
    [cache setMemoryCapacity:1024*1024*10];
    [cache setDiskCapacity:1024*1024*200];
    
    return cache;
}

- (NSOperationQueue*)shareQueue
{
    static NSOperationQueue* queue = nil;
    static dispatch_once_t onceTock;
    
    dispatch_once(&onceTock, ^{
        queue = [[NSOperationQueue alloc] init];
        [queue setSuspended:NO];
        [queue setMaxConcurrentOperationCount:1];
        queue.name = @"imageloadQueue";
    });
    return queue;
}

- (void)cancelLoadImage
{
    [[self shareQueue] cancelAllOperations];
}

- (void)loadImageWithUrl:(NSString *)urlString plcaeHodel:(UIImage *)placeholder blcok:(void(^)(UIImage*))block
{
    if (placeholder) {
        self.image = placeholder;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSString* path = [self  getImagePathCacheWithUrl:urlString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       
        NSData* data = [NSData dataWithContentsOfFile:path];
        UIImage* image = nil;
        if (data &&data.length>0) {
            image = [UIImage imageWithData:data];
        }
        else
        {
            data = [NSData dataWithContentsOfURL:url];
            if (data && data.length>0) {
                [data writeToFile:path atomically:YES];
                image = [UIImage imageWithData:data];
            }
            else return ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
            if (image) {
                if(block) block(image);
            }
        });
        
    });
    
}

- (NSString*)getImagePathCacheWithUrl:(NSString*)url
{
    
    NSString* pathCache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [pathCache stringByAppendingPathComponent:url.lastPathComponent];
    return path;
}

@end
