//
//  RequestData.h
//  gjdrwy
//
//  Created by AllPepole on 15/12/16.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

typedef void (^ReturnValueBlock)(id returnValue);
typedef void (^ErrorCodeBlock)(NSString *errorMsg);
typedef void (^FailureBlock)();
typedef void (^UploadProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);
typedef void (^PageInfoBlock)(NSDictionary *pageDic);


@interface RequestData : NSObject


#pragma 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl;

#pragma POST
+ (void) netRequestPOSTWithRequestURL: (NSString *) requestURLString
                        withParameter: (NSDictionary *) parameter
                 withReturnValeuBlock: (ReturnValueBlock) block
                   withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     withFailureBlock: (FailureBlock) failureBlock;

#pragma GET
+ (void) netRequestGETWithRequestURL: (NSString *) requestURLString
                       withParameter: (NSDictionary *) parameter
                withReturnValeuBlock: (ReturnValueBlock) block
                  withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                    withFailureBlock: (FailureBlock) failureBlock;


#pragma POST IMAGES
+ (void) netRequestPOSTImagesWithRequestURL: (NSString *) requestURLString
                              withParameter: (NSDictionary *) parameter
                               withFileData: (NSArray *) images
                       withReturnValeuBlock: (ReturnValueBlock) block
                         withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                           withFailureBlock: (FailureBlock) failureBlock
                    withUploadProgressBlock: (UploadProgressBlock) uploadProgressBlock;

#pragma mark - 统一的POST
+ (void) completeNetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        withParameter: (NSDictionary *) parameter
                 withReturnValeuBlock: (ReturnValueBlock) block
                   withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     withFailureBlock: (FailureBlock) failureBlock;


+ (void) netRequestPOSTMultipleParmeterImagesWithRequestURL: (NSString *) requestURLString
                                              withParameter: (NSDictionary *) parameter
                                           withFileParamter: (NSArray *) images
                                       withReturnValeuBlock: (ReturnValueBlock) block
                                         withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                                           withFailureBlock: (FailureBlock) failureBlock
                                    withUploadProgressBlock: (UploadProgressBlock) uploadProgressBlock;

@end
