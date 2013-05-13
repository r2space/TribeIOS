//
//  DAFilePoster.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAFilePoster.h"

#define uploadUrl @"/gridfs/save.json"

@implementation DAFilePoster

- (void)upload:(UIImage *)image delegateObj:(id)delegateObj
{
    self.delegate = delegateObj;
    [self sendRequest:[DARequestHelper httpFileRequest:uploadUrl image:image]];
}


- (void)didFinishLoading:(NSData *)data
{
    
    NSDictionary *jsonDict = [DAJsonHelper decode:data];
    NSDictionary *filesDict = [DAJsonHelper objectAtPath:jsonDict path:@"data"];
    DAFileList *files = [[DAFileList alloc] initWithDictionary:filesDict];
    
    if (self.delegate != nil) {
        [self.delegate didFinishUpload:[files.items objectAtIndex:0]];
    }
}

@end

// 使用AFNetworking进行上传的例子
//- (IBAction)onUploadTouched:(id)sender {
//    
//    NSString *strurl = [NSString stringWithFormat:@"/gridfs/save.json?_csrf=%@", csrf];
//    
//    NSLog(@"%@", strurl);
//    
//    NSURL *url = [NSURL URLWithString:@"http://10.2.3.199:3000"];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
//    
//    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"hello.jpg"], 0.5);
//    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:strurl parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
//        [formData appendPartWithFileData:imageData name:@"files" fileName:@"hello.jpg" mimeType:@"image/jpeg"];
//    }];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
//    }];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
//        NSDictionary *result;
//        if (responseObject) {
//            NSError *jsonError = nil;
//            result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&jsonError];
//            
//            NSLog(@"%@", result);
//        }
//        
//    } failure:nil];
//    
//    
//    [httpClient enqueueHTTPRequestOperation:operation];
//}
