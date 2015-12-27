//
//  RequestData.m
//  gjdrwy
//
//  Created by AllPepole on 15/12/16.
//  Copyright © 2015年 AllPepole. All rights reserved.
//

#import "RequestData.h"

@implementation RequestData


#pragma mark - 监测网络的可链接性

+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl
{
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}




#pragma mark - GET

+ (void) netRequestGETWithRequestURL: (NSString *) requestURLString
                       withParameter: (NSDictionary *) parameter
                withReturnValeuBlock: (ReturnValueBlock) block
                  withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                    withFailureBlock: (FailureBlock) failureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    AFHTTPRequestOperation *op = [manager GET:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSInteger respCode = [[dic objectForKey:@"respcode"] integerValue];
        NSString *errorMsg = [dic objectForKey:@"respmessage"];
        
        if (1 == respCode) {
            id retureValue = [dic objectForKey:@"data"];
            if(block) block(retureValue);
        }
        else
        {
            if (errorBlock) errorBlock(errorMsg);
        }
        
        /******************************
         在这做判断如果有dic里有errorCode
         调用errorBlock(dic)
         没有errorCode则调用block(dic)
         ******************************/
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock();
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [op start];
    
}

#pragma mark - POST

+ (void) netRequestPOSTWithRequestURL: (NSString *) requestURLString
                        withParameter: (NSDictionary *) parameter
                 withReturnValeuBlock: (ReturnValueBlock) block
                   withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     withFailureBlock: (FailureBlock) failureBlock
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    AFHTTPRequestOperation *op = [manager POST:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSInteger respCode = [[dic objectForKey:@"respcode"] integerValue];
        NSString *errorMsg = [dic objectForKey:@"respmessage"];
        
        if (1 == respCode) {
            id retureValue = [dic objectForKey:@"data"];
            if(block) block(retureValue);
        }
        else
        {
            if (errorBlock) errorBlock(errorMsg);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failureBlock) failureBlock();
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [op start];
    
}

#pragma mark - POST IMAGES

+ (void) netRequestPOSTImagesWithRequestURL: (NSString *) requestURLString
                              withParameter: (NSDictionary *) parameter
                               withFileData: (NSArray *) images
                       withReturnValeuBlock: (ReturnValueBlock) block
                         withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                           withFailureBlock: (FailureBlock) failureBlock
                    withUploadProgressBlock: (UploadProgressBlock) uploadProgressBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestOperation *operation = [manager POST:requestURLString
                                           parameters:parameter
                            constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                
                                if (images.count > 0) {
                                    NSObject *firstObj = [images objectAtIndex:0];
                                    if ([firstObj isKindOfClass:[UIImage class]]) {     // 图片
                                        for(NSInteger i=0; i<images.count; i++) {
                                            UIImage *eachImg = [images objectAtIndex:i];
                                            NSData *eachImgData = UIImageJPEGRepresentation(eachImg, 0.5);
                                            [formData appendPartWithFileData:eachImgData
                                                                        name:[NSString stringWithFormat:@"img%ld", i+1]
                                                                    fileName:[NSString stringWithFormat:@"img%ld.jpg", i+1]
                                                                    mimeType:@"image/jpeg"];
                                            
                                        }
                                    }
                                }
                                
                            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                block(dic);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failureBlock();
                            }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        uploadProgressBlock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    }];
}

+ (void) netRequestPOSTMultipleParmeterImagesWithRequestURL: (NSString *) requestURLString
                                              withParameter: (NSDictionary *) parameter
                                           withFileParamter: (NSArray *) images
                                       withReturnValeuBlock: (ReturnValueBlock) block
                                         withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                                           withFailureBlock: (FailureBlock) failureBlock
                                    withUploadProgressBlock: (UploadProgressBlock) uploadProgressBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestOperation *operation = [manager POST:requestURLString
                                           parameters:parameter
                            constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                if (images.count>0) {
                                    for (int i = 0 ; i<images.count;i++) {
                                        NSDictionary* dic = [images objectAtIndex:i];
                                        
                                        NSData* imagedata = [dic objectForKey:@"imageData"];
                                        NSString* parmeter = [dic objectForKey:@"KEY"];
                                        [formData appendPartWithFileData:imagedata
                                                                    name:parmeter
                                                                fileName:[NSString stringWithFormat:@"img%d.jpg", i+1]
                                                                mimeType:@"image/jpeg"];
                                    }
                                }
                                
                            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                NSData * data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                                NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                
                                block(dic);
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failureBlock();
                            }];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        uploadProgressBlock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    }];
}

#pragma mark - 统一的POST

#pragma mark - 统一的POST
+ (void) completeNetRequestPOSTWithRequestURL: (NSString *) requestURLString
                                withParameter: (NSDictionary *) parameter
                         withReturnValeuBlock: (ReturnValueBlock) block
                           withErrorCodeBlock: (ErrorCodeBlock) errorBlock
                             withFailureBlock: (FailureBlock) failureBlock;
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    AFHTTPRequestOperation *op = [manager POST:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSInteger respCode = [[dic objectForKey:@"respcode"] integerValue];
        NSString *errorMsg = [dic objectForKey:@"respmessage"];
        
        if (1 == respCode) {
            if(block) block(dic);
        }
        else
        {
            if (errorBlock) errorBlock(errorMsg);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failureBlock) failureBlock();
    }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [op start];
    
}


@end
