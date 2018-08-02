//
//  DownloadManager.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DownloadManager.h"
#import "DataManager.h"

@interface DownloadManager ()

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

+ (void)downloadXMLFileFormURL:(NSString *)stringUrl withCompletionBlock:(void (^)(NSData *))completionBlock {
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSData *data = [NSData dataWithContentsOfURL:location];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(data);
            });
        } else {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
        [session invalidateAndCancel];
    }];
    [task resume];
}

@end
