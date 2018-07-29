//
//  DownloadManager.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DownloadManager.h"
#import "DataManager.h"

@interface DownloadManager () <NSURLSessionDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic) Item *item;

- (void)startDownloadingFromUrl:(NSString *)stringUrl;

@end

@implementation DownloadManager

+ (void)downloadFileForURL:(NSString *)stringUrl withCompletionBlock:(void(^)(NSData *data))completionBlock {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:stringUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data);
        });
    });
}
- (void)downloadFileInBackgroundForURL:(NSString *)stringUrl forItem:(Item *)item {
    self.item = item;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.epam.podcasterApp"];
    configuration.HTTPMaximumConnectionsPerHost = 5;
    self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    [self startDownloadingFromUrl:stringUrl];
}

- (void)startDownloadingFromUrl:(NSString *)stringUrl {
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:stringUrl]];
    [downloadTask resume];
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"BG LOCATION: %@", location.absoluteString);
    NSFileManager *nsFileManager = [NSFileManager defaultManager];
    NSData *data = [NSData dataWithContentsOfFile:location.relativePath];
    dispatch_async(dispatch_get_main_queue(), ^{
        [DataManager saveDownloadedData:data forItem:self.item];
    });
    [self.session invalidateAndCancel];
    [nsFileManager removeItemAtPath:location.absoluteString error:nil];
}

@end
