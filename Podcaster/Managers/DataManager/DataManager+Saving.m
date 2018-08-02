//
//  DataManager+Saving.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager+Saving.h"
#import "ItemCoreDataService+Saving.h"
#import "DataManager+DownloadManagerDelegate.h"

@implementation DataManager (Saving)

- (void)saveItemToPersistent:(Item *)item completionBlock:(void(^)(void))completionBlock {
    if (item.persistentSourceType == kCoreData) return;
    
    self.item = [[Item alloc] initWithDictionary:item.sourceDictionary andSourceType:item.sourceType];;
    
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    downloadManager.delegate = self;
    [downloadManager downloadFileInBackgroundForURL:item.content.webUrl forItem:item];
    
    [DownloadManager downloadFileForURL:item.image.webUrl withCompletionBlock:^(NSData *data) {
        FileManager *fileManager = [FileManager sharedFileManager];
        ItemCoreDataService *itemCoreDataService = [[ItemCoreDataService alloc] init];
        NSString *fileName = [fileManager getFilenameFromStringURL:item.image.webUrl];
        NSString *filePath = [NSString stringWithFormat:@"/%@/%@", kFullSizeImageDirectory, fileName];
        [fileManager createFileWithData:data atPath:filePath withSandboxFolderType:kDocuments];
        self.item.image.localFullUrl = filePath;
        
        [itemCoreDataService saveNewItem:self.item];
        completionBlock();
    }];
}

@end
