//
//  DownloadManager+NSURLSessionDelegate.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DownloadManager+NSURLSessionDelegate.h"

@implementation DownloadManager (NSURLSessionDelegate)

#pragma mark - NSURLSessionDelegate

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"BG LOCATION: %@", location.absoluteString);
    NSFileManager *nsFileManager = [NSFileManager defaultManager];
    NSData *data = [NSData dataWithContentsOfFile:location.relativePath];
    [nsFileManager removeItemAtPath:location.absoluteString error:nil];
    [self.delegate backgroundTaskDownloadedData:data];
    self.delegate = nil;
    [self.session invalidateAndCancel];
}

@end
