//
//  DAFileModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/03.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAFileModule.h"

#define kURLFileHistory @"/file/history_ios.json?fid=%@"

#define kURLFileDetail @"/file/detail.json?fid=%@"
#define kURLFileList @"/file/list.json?start=%d&count=%d&type=all"
#define kURLUploadFile @"/file/upload.json"

@implementation DAFileModule

- (void)getFileList:(int)start count:(int)count callback:(void (^)(NSError *error, DAFileList *files))callback
{
    NSString *path = [NSString stringWithFormat:kURLFileList, start, count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAFileList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)uploadFile:(NSData *)data
          fileName:(NSString *)fileName
          mimeType:(NSString *)mimeType
          callback:(void (^)(NSError *error, DAFile *files))callback
          progress:(void (^)(CGFloat percent))progress
{
    DAAFHttpClient *httpClient = [DAAFHttpClient sharedClient];

    // 添加formData到Request
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST"
                                                                         path:kURLUploadFile
                                                                   parameters:nil
                                                    constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                                                        
        [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:mimeType];
    }];

    // 设定上传进度block
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (progress) {
            progress((CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite);
        }
    }];

    // 设定上传结束block
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if (callback) {
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&jsonError];

            callback(jsonError, [[DAFile alloc] initWithDictionary:result]);
        }

    } failure:nil];
    
    [httpClient enqueueHTTPRequestOperation:operation];
}

- (void)getFileDetail:(NSString *)fid callback:(void (^)(NSError *, DAFileDetail *))callback
{
    NSString *path = [NSString stringWithFormat:kURLFileDetail, fid];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if (callback) {
            callback(nil, [[DAFileDetail alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void) getFileHistory:(NSString *)fid callback:(void (^)(NSError *, DAFileHistory *))callback
{
    NSString *path = [NSString stringWithFormat:kURLFileHistory, fid];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if (callback) {
            callback(nil, [[DAFileHistory alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];

}

@end