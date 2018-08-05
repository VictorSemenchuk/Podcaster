//
//  DownloadManager.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@protocol DownloadManagerDelegate <NSObject>

- (void)backgroundTaskDownloadedData:(NSData *)data;
- (void)updatedProgessFor:(float)progress;

@end

@interface DownloadManager : NSObject <NSURLSessionDelegate>

@property (nonatomic) NSURLSession *session;
@property (strong, nonatomic) id<DownloadManagerDelegate> delegate;

+ (void)downloadFileForURL:(NSString *)stringUrl withCompletionBlock:(void(^)(NSData *data))completionBlock;
- (void)downloadFileInBackgroundForURL:(NSString *)stringUrl forItem:(Item *)item;
+ (void)downloadXMLFileFormURL:(NSString *)stringUrl withCompletionBlock:(void(^)(NSData *data))completionBlock;

@end
