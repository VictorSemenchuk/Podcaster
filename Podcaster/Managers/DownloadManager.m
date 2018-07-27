//
//  DownloadManager.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DownloadManager.h"

@implementation DownloadManager

- (void)downloadFileForURL:(NSString *)stringUrl withCompletionBlock:(void(^)(NSData *data))completionBlock {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:stringUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data);
        });
    });
}

@end
