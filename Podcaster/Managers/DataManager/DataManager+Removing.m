//
//  DataManager+Removing.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 8/2/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "DataManager+Removing.h"
#import "FileManager+Removing.h"
#import "ItemCoreDataService+Removing.h"

@implementation DataManager (Removing)

+ (void)removeItemFromPersistent:(Item *)item completionBlock:(void (^)(void))completionBlock {
    ItemCoreDataService *itemCoreDataService = [[ItemCoreDataService alloc] init];
    FileManager *fileManager = [FileManager sharedFileManager];
    if ([fileManager fileIsExistForPath:item.content.localUrl withSandboxFolderType:kDocuments]) {
        [fileManager removeFileFromPath:item.content.localUrl withSandboxFolderType:kDocuments];
    }
    if ([fileManager fileIsExistForPath:item.image.localFullUrl withSandboxFolderType:kDocuments]) {
        [fileManager removeFileFromPath:item.image.localFullUrl withSandboxFolderType:kDocuments];
    }
    [itemCoreDataService removeItem:item];
    item.content.localUrl = @"";
    item.image.localFullUrl = @"";
    completionBlock();
}

@end
