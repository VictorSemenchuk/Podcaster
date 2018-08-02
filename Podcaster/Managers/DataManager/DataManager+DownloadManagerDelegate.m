//
//  DataManager+DownloadManagerDelegate.m
//  Podcaster
//
//  Created by Victor Macintosh on 29/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager+DownloadManagerDelegate.h"
#import "ItemCoreDataService+Updating.h"

@implementation DataManager (DownloadManagerDelegate)

- (void)backgroundTaskDownloadedData:(NSData *)data {
    FileManager *fileManager = [FileManager sharedFileManager];
    NSString *partFilePath = [fileManager rootDirectoryForSourceType:self.item.sourceType];
    NSString *fileName = [fileManager getFilenameFromStringURL:self.item.content.webUrl];
    NSString *filePath = [NSString stringWithFormat:@"/%@/%@", partFilePath, fileName];
    self.item.content.localUrl = filePath;
    [fileManager createFileWithData:data atPath:filePath withSandboxFolderType:kDocuments];
    
    ItemCoreDataService *itemCoreDataService = [[ItemCoreDataService alloc] init];
    [itemCoreDataService updateItemWithGUID:self.item.guid setValue:filePath forKey:@"content.localUrl"];
    
    [self.savingDelegate wasFinishedBackgroundDownloadingForItem:self.item];
    self.savingDelegate = nil;
}

@end
